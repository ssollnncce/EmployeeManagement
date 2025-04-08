<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DocumentsType extends Model
{
    protected $fillable = [
        'name',
        'role'
    ];
}
