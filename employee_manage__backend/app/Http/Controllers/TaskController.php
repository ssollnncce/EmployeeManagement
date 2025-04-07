<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\TaskRequest;

use Illuminate\Support\Facades\Auth;
use App\Models\Task;


class TaskController extends Controller
{
    public function CreateTask (TaskRequest $request){

        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }

        // Создание задачи
        $task = Task::create([
            'name' => $request->name,
            'description' => $request->description,
            'location' => $request->location,
            'start_date' => $request->start_date,
            'end_date' => $request->end_date,
            'creator_id' => $user->id, // Заполняем creator_id автоматически
        ]);
        
        // Получение участников из запроса
        $participants = $request->participants; // Массив ID участников
        
        // Добавление участников в таблицу task_user (связь многие ко многим)
        if ($participants) {
            $task->members()->attach($participants);
        }
        
        return response()->json([
            'message' => 'Task created successfully',
            'task' => [
                'name' => $task->name,
                'description' => $task->description,
                'location' => $task->location,
                'creator' => $task->creator->full_name,
                'members' => $task->members->pluck('full_name')
            ]
        ]);

    }

    public function GetMyTasks(TaskRequest $request){
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }
    
        // Получаем задачи, где пользователь является создателем или участником
        $tasks = Task::where('creator_id', $user->id)
            ->orWhereHas('members', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->orderBy('start_date')
            ->get();
    
        // Группируем задачи по дате
        $groupedTasks = $tasks->groupBy(function ($task) {
            $startDate = $task->start_date->format('Y-m-d');
            $today = now()->format('Y-m-d');
            $tomorrow = now()->addDay()->format('Y-m-d');
    
            if ($startDate === $today) {
                return 'Сегодня';
            } elseif ($startDate === $tomorrow) {
                return 'Завтра';
            } else {
                return $task->start_date->format('d.m.Y');
            }
        });
    
        // Формируем ответ
        $response = [];
        foreach ($groupedTasks as $date => $tasks) {
            $response[] = [
                'date' => $date,
                'tasks' => $tasks->map(function ($task) {
                    return [
                        'name' => $task->name,
                        'description' => $task->description,
                        'location' => $task->location,
                        'start_date' => $task->start_date->format('Y-m-d H:i'),
                        'end_date' => $task->end_date->format('Y-m-d H:i'),
                        'creator' => $task->creator->full_name,
                        'members' => $task->members->pluck('full_name'),
                    ];
                }),
            ];
        }
    
        return response()->json($response);
    }
}
