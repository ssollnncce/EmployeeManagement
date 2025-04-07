<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    protected $fillable =[
        'name',
        'start_date',
        'end_date',
        'description',
        'location',
        'creator_id'
    ];

    protected $casts = [
        'start_date' => 'datetime',
        'end_date' => 'datetime',
    ];

    public function members(){
        return $this->belongsToMany(User::class, 'task_user');
    }
    public function creator(){
        return $this->belongsTo(User::class, 'creator_id');
    }
}
