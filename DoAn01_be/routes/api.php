<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\UserController;
use App\Http\Controllers\GameController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PaymentController;


Route::post('/register/send-code', [UserController::class, 'sendVerificationCode']);
Route::post('/register/verify-code', [UserController::class, 'verifyCode']);
Route::post('/login', [UserController::class, 'login']);


Route::get('/games', [GameController::class, 'index']);
Route::get('/games/{id}', [GameController::class, 'show']);

Route::post('/cart/add', [CartController::class, 'addToCart']);
Route::get('/cart/{userId}', [CartController::class, 'getCart']);

Route::put('/cart/update', [CartController::class, 'updateCart']);
Route::delete('/cart/remove/{id}', [CartController::class, 'removeFromCart']);

Route::post('/orders', [OrderController::class, 'create']);

Route::get('/orders/{userId}', [OrderController::class, 'index']);

Route::get('/orders/detail/{id}', [OrderController::class, 'show']);


Route::post('/payments', [PaymentController::class, 'create']);

Route::post('/payments/webhook', [PaymentController::class, 'webhook']);

Route::get('/payments/{orderId}', [PaymentController::class, 'show']);