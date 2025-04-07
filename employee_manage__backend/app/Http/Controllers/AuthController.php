<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
    * Login user
    *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
    */
    public function Login(Request $request){
        
        //Validationg input data
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        if (Auth::attempt($request->only('email', 'password'))){

            $user = Auth::user();
            
            return response()->json([
                'message' => 'Login succesfull',
                'Full name' => $user->full_name,
                'Token' => $user->createToken('access_token')->plainTextToken
            ]);
            
        }

        return response()->json([
            'message' => 'Something went wrong'
        ]);
    }

    /**
     * Logout user and revoke their tokens
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function Logout()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }

        // Убедитесь, что у пользователя есть токены
        if ($user->tokens) {
            $user->tokens->each(function ($token) {
                $token->delete();
            });
        }

        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }
}