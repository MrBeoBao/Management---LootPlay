<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Game extends Model
{
    use HasFactory;

    protected $table = 'games';

    protected $primaryKey = 'id';

    public $incrementing = true;

    protected $keyType = 'int';

    public $timestamps = true;

   protected $fillable = [
    'category_id',
    'name',
    'description',
    'price',
    'stock',
    'developer',
    'publisher',
    'release_date',
    'version',
    'views',
    'status',
];

    protected function casts(): array
    {
        return [
            'price' => 'decimal:2',
            'release_date' => 'date',
        ];
    }

 public function order()
{
    return $this->belongsTo(Order::class);
}

public function orderDetails()
{
    return $this->hasMany(OrderDetail::class);
}

public function reviews()
{
    return $this->hasMany(Review::class);
}

public function wishlists()
{
    return $this->hasMany(Wishlist::class);
}
public function category()
{
    return $this->belongsTo(Category::class);
}

public function images()
{
    return $this->hasMany(GameImage::class);
}
    
}