<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;


class NotoficationController extends Controller
{
    public function GetAllNotifications(Request $request) {
        $user = Auth::user();

        if ($user) {
            // Получаем прочитанные и непрочитанные уведомления
            $readNotifications = $user->readNotifications;
            $unreadNotifications = $user->unreadNotifications;

            // Функция для форматирования даты
            $formatDate = function($date) {
                // Используем Carbon для работы с датами
                $carbonDate = Carbon::parse($date);

                // Проверяем, если дата сегодня
                if ($carbonDate->isToday()) {
                    return 'Сегодня в ' . $carbonDate->format('H:i');
                }

                // Проверяем, если дата вчера
                if ($carbonDate->isYesterday()) {
                    return 'Вчера в ' . $carbonDate->format('H:i');
                }

                // Иначе, возвращаем в обычном формате
                return $carbonDate->format('d.m.Y H:i');
            };

            // Собираем уведомления и форматируем дату и сообщение
            $notifications = $unreadNotifications->map(function ($notification) use ($formatDate) {
                return [
                    'message' => $notification->data['message'],
                    'date' => $formatDate($notification->created_at),
                ];
            });

            return response()->json([
                'Message' => 'У вас есть ' . $unreadNotifications->count() . ' уведомлений',
                'Unread notifications' => $notifications,
                'Read notifications' => $readNotifications->map(function ($notification) use ($formatDate) {
                    return [
                        'message' => $notification->data['message'],
                        'date' => $formatDate($notification->created_at),
                    ];
                }),
            ]);
        }
        return response()->json([
            'message' => 'User not authenticated.',
        ], 401);

    }  

    public function MarkAsRead(Request $request) {
        
        $user = Auth::user();
    
        if ($user) {
            // Получаем все непрочитанные уведомления
            $unreadNotifications = $user->unreadNotifications;
    
            // Помечаем все уведомления как прочитанные
            foreach ($unreadNotifications as $unreadNotification) {
                $unreadNotification->markAsRead();
            }
    
            return response()->json([]);
        }
    
        return response()->json([
            'message' => 'User not authenticated.',
        ], 401);
    }
}
