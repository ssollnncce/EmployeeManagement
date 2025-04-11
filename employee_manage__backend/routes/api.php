<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\NotoficationController;

use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Main
Route::get('/user', [AuthController::class, 'GetUser'])->middleware('auth:sanctum');
Route::get('/today-tasks', [TaskController::class, 'GetMainPageTasks'])->middleware('auth:sanctum');
Route::get('/departments', [EmployeeController::class, 'GetDepartments'])->middleware('auth:sanctum');

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

//Documents
    //Request document
    Route::post('/request-document', [DocumentController::class, 'RequestDocument'])->middleware('auth:sanctum');
    //Document list
    Route::get('/documents', [DocumentController::class, 'GetAllDocuments'])->middleware('auth:sanctum');

//Employees
    //Employees list
    Route::get('/employees', [EmployeeController::class, 'GetAllEmployees'])->middleware('auth:sanctum');
    //Employee account
    Route::get('/employees/{id}', [EmployeeController::class, 'GetEmployeeInfo'])->middleware('auth:sanctum');
//Notifications
    //Get all notifications
    Route::get('/notifications', [NotoficationController::class, 'GetAllNotifications'])->middleware('auth:sanctum');
    //Mark as read notifications
    Route::post('/notifications', [NotoficationController::class, 'MarkAsRead'])->middleware('auth:sanctum');

