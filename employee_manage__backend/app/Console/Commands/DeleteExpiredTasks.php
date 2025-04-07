<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Task;
use Carbon\Carbon;

class DeleteExpiredTasks extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'tasks:delete-expired';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Delete tasks where end_date has passed';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        // Получаем текущую дату
        $now = Carbon::now();

        // Удаляем задачи, у которых end_date истёк
        $deletedTasks = Task::where('end_date', '<', $now->startOfDay())->delete();

        // Выводим сообщение о количестве удалённых задач
        $this->info("Deleted {$deletedTasks} expired tasks.");
    }
}
