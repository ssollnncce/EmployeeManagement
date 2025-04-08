<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use App\Models\User;



class EmployeeController extends Controller
{
    public function GetAllEmployees (Request $request){
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }

        $departmentFilter = $request->input('department');

        $employeesQuery = User::where('id', '!=', $user->id);

        if($departmentFilter){
            $employeesQuery->where('department', $departmentFilter);
        }

        $employees = $employeesQuery->get();

        $formattedEmployees = $employees->map(function ($employee) {
            return [
                'Name' => $employee->full_name,  // Доступ к полю модели
                'Position' => $employee->position,
                'Manager' => $employee->manager ? $employee->manager->full_name : null,  // Проверка на наличие менеджера
            ];
        });
    
        return response()->json([
            'Message' => 'Successful',
            'Employees' => $formattedEmployees
        ]);
    }

    public function GetEmployeeInfo($id) {

        $user = User::find($id);

        // Check if the user exists
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $workFormat = $user->work_mode;
        if ($workFormat === 'office'){
            $workFormat = 'В офисе';
        } else {
            $workFormat = 'Удаленно';
        }

        return response()->json([
            'Full name' => $user->full_name,
            'Email' => $user->email,
            'Phone' => $user->phone_number,
            'Position' => $user->position, // Assuming there's a position field
            'Department' => $user->department_name->name, // Assuming there's a department field
            'Manager' => $user->manager ? $user->manager->full_name : null, // Manager's full name
            'Work mode' => $workFormat
        ], 200);
    }
}
