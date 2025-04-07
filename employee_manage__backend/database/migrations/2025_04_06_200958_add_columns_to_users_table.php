<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migration.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {

            // Adding new columns
            $table->string('first_name')->after('id');
            $table->string('last_name')->after('first_name');
            $table->string('patronymic')->after('last_name');
            $table->string('phone_number', 15)->after('patronymic');
            $table->string('position')->after('email');
            $table->enum('work_mode', ['office', 'remote']);
            
            // Adding manager column
            $table->unsignedBigInteger('manager_id')->nullable()->after('position'); // Column for manager
            $table->foreign('manager_id')->references('id')->on('users')->onDelete('set null'); // Foreign key for manager_id
            
            // Deleting unnecessary columns
            $table->dropColumn('email_verified_at');

        });
    }

    /**
     * Reverse the migration.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {

            // Remove foreign key and manager_id column
            $table->dropForeign(['manager_id']);
            $table->dropColumn('manager_id');
            
            // Remove new columns
            $table->dropColumn('first_name');
            $table->dropColumn('last_name');
            $table->dropColumn('patronymic');
            $table->dropColumn('phone_number');
            $table->dropColumn('position');
            $table->dropColumn('work_mode');
            
            // Restore email_verified_at column
            $table->timestamp('email_verified_at')->nullable();
            
        });
    }
};
