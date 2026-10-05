<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Game;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class CartController extends Controller
{
    public function addToCart(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id',
            'game_id' => 'required|integer|exists:games,id',
            'quantity' => 'required|integer|min:1',
        ]);

        $game = Game::where('id', $request->game_id)
            ->where('status', 'active')
            ->first();

        if (!$game) {
            return response()->json([
                'message' => 'Game không tồn tại hoặc đã ngừng bán'
            ], 404);
        }

        if ($request->quantity > $game->stock) {
            return response()->json([
                'message' => 'Số lượng game trong kho không đủ'
            ], 400);
        }

        $cart = Cart::firstOrCreate([
            'user_id' => $request->user_id
        ]);

        $cartItem = CartItem::where('cart_id', $cart->id)
            ->where('game_id', $request->game_id)
            ->first();

        if ($cartItem) {

            $newQuantity =
                $cartItem->quantity + $request->quantity;

            if ($newQuantity > $game->stock) {
                return response()->json([
                    'message' => 'Số lượng game trong kho không đủ'
                ], 400);
            }

            $cartItem->update([
                'quantity' => $newQuantity
            ]);

        } else {

            $cartItem = CartItem::create([
                'cart_id' => $cart->id,
                'game_id' => $request->game_id,
                'quantity' => $request->quantity
            ]);
        }

        return response()->json([
            'message' => 'Đã thêm game vào giỏ hàng',
            'cart_item' => $cartItem
        ], 200);
    }
    public function getCart($userId)
    {
        $cart = Cart::with([
            'items.game.images'
        ])
            ->where('user_id', $userId)
            ->first();

        if (!$cart) {
            return response()->json([
                'message' => 'Giỏ hàng đang trống',
                'cart' => null,
                'items' => []
            ], 200);
        }

        return response()->json([
            'message' => 'Lấy giỏ hàng thành công',
            'cart' => $cart,
            'items' => $cart->items
        ], 200);
    }
    public function updateCart(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id',
            'cart_item_id' => 'required|integer|exists:cart_items,id',
            'quantity' => 'required|integer|min:1',
        ]);

        $cart = Cart::where('user_id', $request->user_id)
            ->first();

        if (!$cart) {
            return response()->json([
                'message' => 'Không tìm thấy giỏ hàng'
            ], 404);
        }

        $cartItem = CartItem::where('id', $request->cart_item_id)
            ->where('cart_id', $cart->id)
            ->first();

        if (!$cartItem) {
            return response()->json([
                'message' => 'Không tìm thấy sản phẩm trong giỏ hàng'
            ], 404);
        }

        $game = Game::where('id', $cartItem->game_id)
            ->where('status', 'active')
            ->first();

        if (!$game) {
            return response()->json([
                'message' => 'Game không tồn tại hoặc đã ngừng bán'
            ], 404);
        }

        if ($request->quantity > $game->stock) {
            return response()->json([
                'message' => 'Số lượng game trong kho không đủ'
            ], 400);
        }

        $cartItem->update([
            'quantity' => $request->quantity
        ]);

        return response()->json([
            'message' => 'Cập nhật số lượng thành công',
            'cart_item' => $cartItem
        ], 200);
    }
    public function removeFromCart(Request $request, $id)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id',
        ]);

        $cart = Cart::where('user_id', $request->user_id)
            ->first();

        if (!$cart) {
            return response()->json([
                'message' => 'Không tìm thấy giỏ hàng'
            ], 404);
        }

        $cartItem = CartItem::where('id', $id)
            ->where('cart_id', $cart->id)
            ->first();

        if (!$cartItem) {
            return response()->json([
                'message' => 'Không tìm thấy sản phẩm trong giỏ hàng'
            ], 404);
        }

        $cartItem->delete();

        return response()->json([
            'message' => 'Đã xóa game khỏi giỏ hàng'
        ], 200);
    }
}