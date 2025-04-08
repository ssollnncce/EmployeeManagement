<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

use App\Models\Task;

class TaskCreatedToUser extends Notification
{
    use Queueable;

    public $task;

    /**
     * Create a new notification instance.
     */
    public function __construct(Task $task)
    {
        $this->task = $task;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database'];
    }

    /**
     * Get the mail representation of the notification.
     */
  

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toDataBase($notifiable) 
    {
        return [
            'task_id' => $this->task->id,
            'task_name' => $this->task->name,
            'message' => 'Вы успешно создали задачу: ' . $this->task->name
        ];
    }
}
