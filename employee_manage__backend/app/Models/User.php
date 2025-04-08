<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
        // Указываем массово заполняемые поля
        protected $fillable = [
            'first_name',
            'last_name',
            'patronymic',
            'phone_number',
            'position',
            'work_mode',
            'manager_id',
            'email',
            'password',
        ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'password' => 'hashed',
        ];
    }

// В модели User
    public function getFullNameAttribute()
    {
        return $this->last_name . ' ' . $this->first_name . ' ' . $this->patronymic;    
    }
    public function tasks(){
        return $this->belongsToMany(Task::class, 'task_user');
    }
    public function manager(){
        return $this->belongsTo(User::class, 'manager_id');  
    }

    public function department_name(){
        return $this->belongsTo(Department::class, 'department');
    }
}
