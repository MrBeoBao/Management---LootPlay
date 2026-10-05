<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderDetail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Routing\Controller;

class OrderController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id'
        ]);

        $cart = Cart::with('items.game')
            ->where('user_id', $request->user_id)
            ->first();

        if (!$cart || $cart->items->isEmpty()) {
            return response()->json([
                'message' => 'Giỏ hàng đang trống'
            ], 400);
        }

        foreach ($cart->items as $item) {
            if (!$item->game || $item->game->status !== 'active') {
                return response()->json([
                    'message' => 'Có game không còn được bán'
                ], 400);
            }

            if ($item->quantity > $item->game->stock) {
                return response()->json([
                    'message' => 'Số lượng game ' . $item->game->name . ' trong kho không đủ'
                ], 400);
            }
        }

        DB::beginTransaction();

        try {
            $totalAmount = 0;

            foreach ($cart->items as $item) {
                $totalAmount += $item->quantity * $item->game->price;
            }

            $order = Order::create([
                'user_id' => $request->user_id,
                'order_code' => 'LP' . date('YmdHis') . rand(100, 999),
                'total_amount' => $totalAmount,
                'status' => 'pending',
            ]);

            foreach ($cart->items as $item) {
                OrderDetail::create([
                    'order_id' => $order->id,
                    'game_id' => $item->game_id,
                    'quantity' => $item->quantity,
                    'price' => $item->game->price,
                ]);

                $item->game->decrement('stock', $item->quantity);
                $item->delete();
            }

            DB::commit();

            $order->load([
                'orderDetails.game.images',
                'payment'
            ]);

            return response()->json([
                'message' => 'Tạo đơn hàng thành công',
                'order' => $order
            ], 201);

        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'message' => 'Không thể tạo đơn hàng',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function index($userId)
    {
        $orders = Order::with([
            'orderDetails.game.images',
            'payment'
        ])
        ->where('user_id', $userId)
        ->orderBy('created_at', 'desc')
        ->get();

        return response()->json([
            'message' => 'Lấy danh sách đơn hàng thành công',
            'orders' => $orders
        ], 200);
    }

    public function show($id)
    {
        $order = Order::with([
            'user',
            'orderDetails.game.images',
            'payment'
        ])->find($id);

        if (!$order) {
            return response()->json([
                'message' => 'Không tìm thấy đơn hàng'
            ], 404);
        }

        return response()->json([
            'message' => 'Lấy thông tin đơn hàng thành công',
            'order' => $order
        ], 200);
    }
}