<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Payment;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Str;

class PaymentController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'order_id' => 'required|integer|exists:orders,id',
            'payment_method' => 'required|string'
        ]);

        $order = Order::find($request->order_id);

        if (!$order) {
            return response()->json([
                'message' => 'Không tìm thấy đơn hàng'
            ], 404);
        }

        if ($order->status === 'paid') {
            return response()->json([
                'message' => 'Đơn hàng đã thanh toán'
            ], 400);
        }

        $payment = Payment::updateOrCreate(
            [
                'order_id' => $order->id
            ],
            [
                'payment_method' => $request->payment_method,
                'amount' => $order->total_amount,
                'status' => 'pending',
                'transaction_code' => null,
                'paid_at' => null
            ]
        );

        return response()->json([
            'message' => 'Tạo thanh toán thành công',
            'payment' => $payment
        ], 201);
    }

    public function show($orderId)
    {
        $payment = Payment::where('order_id', $orderId)->first();

        if (!$payment) {
            return response()->json([
                'message' => 'Không tìm thấy thông tin thanh toán'
            ], 404);
        }

        return response()->json([
            'message' => 'Lấy thông tin thanh toán thành công',
            'payment' => $payment
        ], 200);
    }

    public function webhook(Request $request)
    {
        $request->validate([
            'order_id' => 'required|integer|exists:orders,id',
            'transaction_code' => 'required|string'
        ]);

        $order = Order::find($request->order_id);

        $payment = Payment::where('order_id', $order->id)->first();

        if (!$payment) {
            return response()->json([
                'message' => 'Không tìm thấy thanh toán'
            ], 404);
        }

        $payment->update([
            'status' => 'paid',
            'transaction_code' => $request->transaction_code,
            'paid_at' => now()
        ]);

        $order->update([
            'status' => 'paid'
        ]);

        return response()->json([
            'message' => 'Thanh toán thành công',
            'payment' => $payment
        ], 200);
    }
}