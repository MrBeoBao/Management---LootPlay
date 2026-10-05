<?php

namespace App\Http\Controllers;

use App\Models\Game;
use Illuminate\Routing\Controller;

class GameController extends Controller
{
    public function index()
    {
        $games = Game::with('category')
            ->with('images')
            ->where('status', 'active')
            ->get();

        return response()->json([
            'message' => 'Lấy danh sách game thành công',
            'games' => $games
        ], 200);
    }

    public function show($id)
    {
        $game = Game::with('category')
            ->with('images')
            ->where('status', 'active')
            ->find($id);

        if (!$game) {
            return response()->json([
                'message' => 'Không tìm thấy game'
            ], 404);
        }

        // Tăng lượt xem lên 1
        $game->increment('views');

        // Lấy lại dữ liệu mới nhất
        $game->refresh();

        return response()->json([
            'message' => 'Lấy thông tin game thành công',
            'game' => $game
        ], 200);
    }
}