<?php

namespace App\Http\Controllers;

use App\Notifications\CreateTaskToMembers;
use App\Notifications\TaskCreatedToUser;
use Illuminate\Http\Request;
use App\Http\Requests\TaskRequest;

use Illuminate\Support\Facades\Auth;
use App\Models\Task;

use Carbon\Carbon;


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

        $user->notify(new TaskCreatedToUser($task));

        foreach($task->members as $member){
            $member->notify(new CreateTaskToMembers($task));
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

    public function GetMyTasks(){
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }
    
        $now = Carbon::now()->setTimezone('Asia/Yekaterinburg');
        \Log::info('Current time: ' . $now->format('Y-m-d H:i:s'));
    
        // Получаем все задачи пользователя
        $allTasks = Task::where('creator_id', $user->id)
            ->orWhereHas('members', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->orderBy('start_date')
            ->get();
            
        \Log::info('All tasks count: ' . $allTasks->count());
        
        // Фильтруем задачи, у которых end_date еще не наступила
        $tasks = $allTasks->filter(function ($task) use ($now) {
            $endDate = Carbon::parse($task->end_date)->setTimezone('Asia/Yekaterinburg');
            \Log::info('Task: ' . $task->name . ', end_date: ' . $endDate->format('Y-m-d H:i:s'));
            return $endDate->greaterThanOrEqualTo($now);
        });
        
        \Log::info('Filtered tasks count: ' . $tasks->count());
    
        $groupedTasks = $tasks->groupBy(function ($task) {
            $startDate = Carbon::parse($task->start_date)->format('Y-m-d');
            $today = now()->format('Y-m-d');
            $tomorrow = now()->addDay()->format('Y-m-d');
    
            if ($startDate === $today) {
                return 'Сегодня';
            } elseif ($startDate === $tomorrow) {
                return 'Завтра';
            } else {
                return Carbon::parse($task->start_date)->format('d.m.Y');
            }
        });
    
        $response = [];
        foreach ($groupedTasks as $date => $tasks) {
            $response[] = [
                'date' => $date,
                'tasks' => $tasks->map(function ($task) use ($now) {
                    $startDate = Carbon::parse($task->start_date);
                    $endDate = Carbon::parse($task->end_date);
                    $isOngoing = $now->between($startDate, $endDate);
                    $duration = null;
                    
                    // Форматирование даты начала
                    $formattedStartDate = $startDate->format('Y-m-d');
                    $formattedEndDate = $endDate->format('Y-m-d');
                    $today = now()->format('Y-m-d');
                    $tomorrow = now()->addDay()->format('Y-m-d');
                    
                    if ($formattedStartDate === $today) {
                        $displayStartDate = 'Сегодня';
                        $displayEndDate = 'Сегодня';
                    } elseif ($formattedStartDate === $tomorrow) {
                        $displayStartDate = 'Завтра';
                        $displayEndDate = 'Завтра';
                    } else {
                        $displayStartDate = $startDate->format('d.m.Y');
                        $displayEndDate = $endDate->format('d.m.Y');
                    }
                    
                    if ($isOngoing) {
                        $diffInMinutes = abs($now->diffInMinutes($startDate));
                        $duration = round($diffInMinutes) . ' минут';
                    }

                    return [
                        'name' => $task->name,
                        'description' => $task->description,
                        'location' => $task->location,
                        'start_date' => $displayStartDate . ', ' . $startDate->format('H:i'),
                        'end_date' => $displayEndDate . ', ' . $endDate->format('H:i'),
                        'creator' => $task->creator->full_name,
                        'members' => $task->members->pluck('full_name')->join(', '),
                        'is_ongoing' => $isOngoing,
                        'duration' => $duration
                    ];
                }),
            ];
        }
    
        return response()->json($response);
    }

    public function GetMainPageTasks() {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }

        // Используем правильный формат даты с учетом часового пояса
        $today = now()->setTimezone('Asia/Yekaterinburg')->format('Y-m-d');
        $todayText = Carbon::now()->setTimezone('Asia/Yekaterinburg');
        $todayText->locale('ru');
        $formattedTodayText = $todayText->isoFormat('DD MMMM YYYY');

        // Используем where с замыканием для группировки условий
        $todayTasks = Task::where(function($query) use ($today) {
                $query->whereDate('start_date',  $today)
                      ->orWhereDate('end_date', '<=',$today);
            })
            ->whereHas('members', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->orderBy('start_date')
            ->get();
        
        $now = Carbon::now()->setTimezone('Asia/Yekaterinburg');
        
        return response()->json([
            'today' => $formattedTodayText,
            'today_date' => $today,
            'tasks' => $todayTasks->map(function($todayTask) use ($now) {
                $startDate = Carbon::parse($todayTask->start_date)->setTimezone('Asia/Yekaterinburg');
                $endDate = Carbon::parse($todayTask->end_date)->setTimezone('Asia/Yekaterinburg');
                $isOngoing = $now->between($startDate, $endDate);
                $duration = null;
                
                // Форматирование даты начала
                $formattedStartDate = $startDate->format('Y-m-d');
                $formattedEndDate = $endDate->format('Y-m-d');
                $today = now()->format('Y-m-d');
                $tomorrow = now()->addDay()->format('Y-m-d');
                
                if ($formattedStartDate === $today) {
                    $displayStartDate = 'Сегодня';
                    $displayEndDate = 'Сегодня';
                } elseif ($formattedStartDate === $tomorrow) {
                    $displayStartDate = 'Завтра';
                    $displayEndDate = 'Завтра';
                } else {
                    $displayStartDate = $startDate->format('d.m.Y');
                    $displayEndDate = $endDate->format('d.m.Y');
                }
                
                if ($isOngoing) {
                    $diffInMinutes = abs($now->diffInMinutes($startDate));
                    $duration = round($diffInMinutes) . ' минут';
                }

                return [
                    'name' => $todayTask->name,
                    'description' => $todayTask->description,
                    'location' => $todayTask->location,
                    'members' => $todayTask->members->pluck('full_name')->join(', '),
                    'start_date' => $displayStartDate . ', ' . $startDate->format('H:i'),
                    'end_date' => $displayEndDate . ', ' . $endDate->format('H:i'),
                    'is_ongoing' => $isOngoing,
                    'duration' => $duration
                ];
            }),
        ]);
    }
}
