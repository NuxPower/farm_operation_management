<?php

namespace App\Console\Commands;

use App\Models\Task;
use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class ProcessDueTasks extends Command
{
    protected $signature = 'tasks:process-due';

    protected $description = 'Auto-complete overdue tasks and generate labor wages/expenses';

    public function handle()
    {
        $this->info('Processing due tasks...');

        // Find tasks that are overdue and not completed.
        // Exempt same-day tasks (due_date == created_at date) — these were just created
        // and should not be auto-completed immediately (e.g. post-harvest tasks assigned today).
        $overdueTasks = Task::where('status', '!=', Task::STATUS_COMPLETED)
            ->where('due_date', '<=', now())
            ->whereRaw('DATE(due_date) != DATE(created_at)')
            ->with(['planting.field', 'laborer', 'laborerGroup.laborers'])
            ->get();

        $processedCount = 0;
        $errorCount = 0;

        foreach ($overdueTasks as $task) {
            try {
                // Get the user (farmer) who owns this task
                $user = User::find($task->planting->field->user_id ?? null);

                if (!$user) {
                    $this->error("No user found for task {$task->id}");
                    $errorCount++;
                    continue;
                }

                // Use the existing logic to create labor expenses
                $taskController = app(\App\Http\Controllers\Labor\TaskController::class);
                $expenses = $taskController->createLaborExpensesForTask($task, $user, null, $task->due_date);

                if (!empty($expenses)) {
                    $this->info("Processed task {$task->id} - created {$expenses[0]['laborer_name']} wage: {$expenses[0]['amount']}");
                    $processedCount++;
                } else {
                    $this->warn("Task {$task->id} processed but no expenses created (no laborers assigned?)");
                }

            } catch (\Exception $e) {
                $this->error("Failed to process task {$task->id}: {$e->getMessage()}");
                Log::error("Task processing error for task {$task->id}: " . $e->getMessage());
                $errorCount++;
            }
        }

        $this->info("Processed {$processedCount} tasks successfully, {$errorCount} errors");
    }
}