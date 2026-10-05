<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Game;
use App\Models\GameImage;

class GameSeeder extends Seeder
{
    public function run(): void
    {
        $action = Category::firstOrCreate([
            'name' => 'Action'
        ], [
            'description' => 'Game hành động'
        ]);

        $rpg = Category::firstOrCreate([
            'name' => 'RPG'
        ], [
            'description' => 'Game nhập vai'
        ]);

        $racing = Category::firstOrCreate([
            'name' => 'Racing'
        ], [
            'description' => 'Game đua xe'
        ]);

        $sports = Category::firstOrCreate([
            'name' => 'Sports'
        ], [
            'description' => 'Game thể thao'
        ]);


        $games = [

            [
                'category_id' => $action->id,
                'name' => 'Cyber Warrior',
                'description' => 'Game hành động với những trận chiến hấp dẫn.',
                'price' => 299000,
                'stock' => 100,
                'developer' => 'LootPlay Studio',
                'publisher' => 'LootPlay',
                'release_date' => '2025-01-15',
                'version' => 'v1.0.0',
                'views' => 1250,
                'status' => 'active',
                'image' => 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1000&q=85'
            ],

            [
                'category_id' => $rpg->id,
                'name' => 'Fantasy World',
                'description' => 'Khám phá thế giới fantasy rộng lớn.',
                'price' => 399000,
                'stock' => 80,
                'developer' => 'Fantasy Studio',
                'publisher' => 'LootPlay',
                'release_date' => '2025-03-20',
                'version' => 'v1.2.5',
                'views' => 980,
                'status' => 'active',
                'image' => 'https://images.unsplash.com/photo-1605901309584-818e25960a8f?auto=format&fit=crop&w=1000&q=85'
            ],

            [
                'category_id' => $racing->id,
                'name' => 'Speed Racer',
                'description' => 'Trải nghiệm những cuộc đua tốc độ cao.',
                'price' => 249000,
                'stock' => 120,
                'developer' => 'Speed Studio',
                'publisher' => 'LootPlay',
                'release_date' => '2025-05-10',
                'version' => 'v2.1.0',
                'views' => 1560,
                'status' => 'active',
                'image' => 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=1000&q=85'
            ],

            [
                'category_id' => $sports->id,
                'name' => 'Football Pro',
                'description' => 'Game thể thao dành cho những người yêu bóng đá.',
                'price' => 349000,
                'stock' => 90,
                'developer' => 'Sports Studio',
                'publisher' => 'LootPlay',
                'release_date' => '2025-06-15',
                'version' => 'v3.0.2',
                'views' => 2100,
                'status' => 'active',
                'image' => 'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?auto=format&fit=crop&w=1000&q=85'
            ]

        ];


        foreach ($games as $gameData) {

            $image = $gameData['image'];

            unset($gameData['image']);

            $game = Game::create($gameData);

            GameImage::create([
                'game_id' => $game->id,
                'image_url' => $image,
                'is_primary' => true
            ]);
        }
    }
}