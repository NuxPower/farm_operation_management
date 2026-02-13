<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class VerificationController extends Controller
{
    public function verify(Request $request)
    {
        $request->validate([
            'phone' => 'required_without:email|nullable|string',
            'email' => 'required_without:phone|nullable|string|email',
            'code' => 'required|string',
        ]);

        // Find user by phone or email
        $user = null;
        if ($request->phone) {
            $user = User::where('phone', $request->phone)->first();
        } elseif ($request->email) {
            $user = User::where('email', $request->email)->first();
        }

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        if ($user->verification_code !== $request->code) {
            return response()->json(['message' => 'Invalid verification code'], 400);
        }

        if ($user->verification_code_expires_at && now()->gt($user->verification_code_expires_at)) {
            return response()->json(['message' => 'Verification code expired'], 400);
        }

        // Mark as verified based on method
        if ($request->phone) {
            $user->phone_verified_at = now();
        } else {
            $user->email_verified_at = now();
        }
        $user->verification_code = null; // Clear code after verification
        $user->save();

        // Generate token for auto-login
        $token = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'message' => 'Verification successful',
            'user' => $user,
            'token' => $token
        ]);
    }

    public function resend(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $verificationCode = str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
        $user->verification_code = $verificationCode;
        $user->verification_code_expires_at = now()->addMinutes(30);
        $user->save();

        try {
            \Illuminate\Support\Facades\Mail::to($user->email)->send(new \App\Mail\VerificationCodeMail($verificationCode));
            return response()->json(['message' => 'Verification code sent via email']);
        } catch (\Exception $e) {
            \Log::error('Failed to resend verification email: ' . $e->getMessage());
            return response()->json(['message' => 'Failed to send email'], 500);
        }
    }
}


