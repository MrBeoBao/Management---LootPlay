<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('order_details', function (Blueprint $table) {
            $table->id();

            $table->foreignId('order_id')
                ->constrained('orders')
                ->cascadeOnDelete();

            $table->foreignId('game_id')
                ->constrained('games')
                ->cascadeOnDelete();

            $table->integer('quantity')->default(1);
            $table->decimal('price', 12, 2);

            $table->timestamps();

            $table->unique(['order_id', 'game_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_details');
    }
};