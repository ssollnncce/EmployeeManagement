<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use App\Console\Commands\DeleteOldNotifications;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     */

     protected $commands = [
        DeleteOldNotifications::class,  // Регистрируем команду
    ];

    protected function schedule(Schedule $schedule)
    {
        // Запускаем команду tasks:delete-expired ежедневно в полночь
        $schedule->command('tasks:delete-expired')->daily();
        $schedule->command('notifications:delete-old')->daily();  // Можно настроить другой интервал (например, weekly)
    }

    /**
     * Register the commands for the application.
     */
    protected function commands()
    {
        // Загружаем команды из папки Commands
        $this->load(__DIR__.'/Commands');

        // Подключаем файл console.php для дополнительных маршрутов
        require base_path('routes/console.php');
    }
}