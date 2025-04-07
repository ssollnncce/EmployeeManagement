<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\TaskController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Authorize
    //Log In
    Route::post('/login', [AuthController::class, 'Login']);
    //Log out
    Route::post('/logout', [AuthController::class, 'Logout'])->middleware('auth:sanctum');

//Tasks
    //List of tasks
    Route::get('/tasks', [TaskController::class, 'GetMyTasks'])->middleware('auth:sanctum');
    //Create task
    Route::post('/create-task', [TaskController::class, 'CreateTask'])->middleware('auth:sanctum');
