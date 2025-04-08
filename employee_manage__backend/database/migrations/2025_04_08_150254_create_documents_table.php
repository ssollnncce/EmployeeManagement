<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('documents', function (Blueprint $table) {
            $table->id();
                //Column of table's name
                $table->unsignedBigInteger('name_id');
                $table->foreign('name_id')->references('id')->on('documents_types')->ondelete('cascade');
            $table->date('created_date')->useCurrent();
            $table->enum('status', ['done', 'in_process', 'decline']);
            $table->string('file_path')->nullable(); // Path to uploaded file
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('documents');
    }
};
