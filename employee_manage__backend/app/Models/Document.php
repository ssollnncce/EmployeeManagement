<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    protected $fillable = [
        'name_id',
        'created_date',
        'status',
        'file_path',
        'creator_id',
    ];

    public function type()
    {
        return $this->belongsTo(DocumentsType::class, 'name_id');
    }

    public function creator() {
        return $this->belongsTo(User::class, 'creator_id');
    }
}