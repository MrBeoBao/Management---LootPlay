<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\VerificationCode;
use App\Mail\VerificationCodeMail;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;

class UserController extends Controller
{
    public function sendVerificationCode(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'phone' => 'nullable|string|max:20',
        ]);

        $code = rand(100000, 999999);

        VerificationCode::where('email', $request->email)->delete();

        VerificationCode::create([
            'email' => $request->email,
            'code' => $code,
            'expires_at' => now()->addMinutes(5),
        ]);

        Mail::to($request->email)->send(
            new VerificationCodeMail($code)
        );

        return response()->json([
            'message' => 'Mã xác nhận đã được gửi đến email',
        ], 200);
    }

    public function verifyCode(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email',
            'password' => 'required|string|min:6',
            'phone' => 'nullable|string|max:20',
            'code' => 'required|string',
        ]);

        if (User::where('email', $request->email)->exists()) {
            return response()->json([
                'message' => 'Email đã được đăng ký',
            ], 400);
        }

        $verificationCode = VerificationCode::where('email', $request->email)
            ->where('code', $request->code)
            ->first();

        if (!$verificationCode) {
            return response()->json([
                'message' => 'Mã xác nhận không đúng',
            ], 400);
        }

        if (now()->greaterThan($verificationCode->expires_at)) {
            $verificationCode->delete();

            return response()->json([
                'message' => 'Mã xác nhận đã hết hạn',
            ], 400);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => $request->password,
            'phone' => $request->phone,
            'role' => 'user',
        ]);

        $verificationCode->delete();

        return response()->json([
            'message' => 'Đăng ký tài khoản thành công',
            'user' => $user,
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'message' => 'Email hoặc mật khẩu không đúng',
            ], 401);
        }

        return response()->json([
            'message' => 'Đăng nhập thành công',
            'user' => $user,
        ], 200);
    }
}