<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Notification;
use Carbon\Carbon;

use Illuminate\Support\Facades\DB;


class DeleteOldNotifications extends Command
{
    // Название и описание команды
    protected $signature = 'notifications:delete-old';
    protected $description = 'Удаляет уведомления старше недели';

    public function __construct()
    {
        parent::__construct();
    }

    // Логика удаления уведомлений
    public function handle()
    {
        $deleted = DB::table('notifications')
            ->where('created_at', '<', Carbon::now()->subWeek())
            ->delete(); // Удаление уведомлений

        $this->info("Удалено уведомлений: " . $deleted);
    }
}
