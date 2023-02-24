<?php

namespace App\Http\Controllers\Admin\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class LoginController extends Controller
{
    public function index(){
        $title = 'login';
        return view('admin.auth.login',compact('title'));
    }

    public function login(Request $request){
        $this->validate($request ,[
            'account_id' => 'required',
            'email'=>'required|email',
            'password'=>'required',
        ]);
       $authenticate = auth()->attempt($request->only('account_id','email','password'));
       if (!$authenticate){
           return back()->with('login_error',"Invalid user credentials");
       }
       return redirect()->route('dashboard');

    }
}
