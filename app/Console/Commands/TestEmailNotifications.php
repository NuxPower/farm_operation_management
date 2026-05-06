<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Password;
use App\Mail\VerificationCodeMail;
use App\Mail\WeatherWarningMail;
use App\Mail\PreOrderAvailableMail;
use App\Mail\OrderPickupReminderMail;
use App\Mail\PickupDeadlineWarningMail;
use App\Mail\OrderExpiredMail;
use App\Models\RiceOrder;
use App\Models\User;

class TestEmailNotifications extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'email:test 
        {email : The email address to send test emails to}
        {--user= : The user email to simulate (for fetching order data)}
        {--only= : Only test a specific email type (verification, weather, preorder, pickup_reminder, deadline_warning, order_expired, password_reset)}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Test all email notification modules by sending test emails';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $targetEmail = $this->argument('email');
        $userEmail = $this->option('user');
        $onlyType = $this->option('only');

        $this->info("🧪 Testing Email Notifications");
        $this->info("================================");
        $this->info("Target Email: {$targetEmail}");
        $this->info("");

        // Find user if specified
        $user = null;
        if ($userEmail) {
            $user = User::where('email', $userEmail)->first();
            if (!$user) {
                $this->warn("User {$userEmail} not found. Creating a test order without user association.");
            } else {
                $this->info("Found user: {$user->name} ({$user->email})");
            }
        }

        $results = [];

        // 0. Test Password Reset Email
        if (!$onlyType || $onlyType === 'password_reset') {
            $results['password_reset'] = $this->testPasswordResetEmail($targetEmail);
        }

        // 1. Test Verification Code Email
        if (!$onlyType || $onlyType === 'verification') {
            $results['verification'] = $this->testVerificationCodeEmail($targetEmail);
        }

        // 2. Test Weather Warning Email
        if (!$onlyType || $onlyType === 'weather') {
            $results['weather'] = $this->testWeatherWarningEmail($targetEmail);
        }

        // Get or create a test order
        $order = $this->getOrCreateTestOrder($user);
        if (!$order) {
            $this->error("Could not get or create a test order. Some tests will be skipped.");
        } else {
            $this->info("Using order ID: {$order->id}");

            // 3. Test Pre-Order Available Email
            if (!$onlyType || $onlyType === 'preorder') {
                $results['preorder'] = $this->testPreOrderAvailableEmail($targetEmail, $order);
            }

            // 4. Test Order Pickup Reminder Email
            if (!$onlyType || $onlyType === 'pickup_reminder') {
                $results['pickup_reminder'] = $this->testOrderPickupReminderEmail($targetEmail, $order);
            }

            // 5. Test Pickup Deadline Warning Email
            if (!$onlyType || $onlyType === 'deadline_warning') {
                $results['deadline_warning'] = $this->testPickupDeadlineWarningEmail($targetEmail, $order);
            }

            // 6. Test Order Expired Email (both farmer and buyer versions)
            if (!$onlyType || $onlyType === 'order_expired') {
                $results['order_expired_buyer'] = $this->testOrderExpiredEmail($targetEmail, $order, 'buyer');
                $results['order_expired_farmer'] = $this->testOrderExpiredEmail($targetEmail, $order, 'farmer');
            }
        }

        // Summary
        $this->info("");
        $this->info("================================");
        $this->info("📊 Test Results Summary");
        $this->info("================================");

        $successCount = 0;
        $failCount = 0;

        foreach ($results as $type => $result) {
            if ($result['success']) {
                $this->info("✅ {$type}: {$result['message']}");
                $successCount++;
            } else {
                $this->error("❌ {$type}: {$result['message']}");
                $failCount++;
            }
        }

        $this->info("");
        $this->info("Total: {$successCount} passed, {$failCount} failed");

        return $failCount > 0 ? 1 : 0;
    }

    private function testPasswordResetEmail(string $email): array
    {
        $this->info("");
        $this->info("🔑 Testing Password Reset Email...");

        // Find a user with that email, or any user as fallback
        $user = User::where('email', $email)->first() ?? User::first();

        if (!$user) {
            return ['success' => false, 'message' => 'No user found in database to send reset link for.'];
        }

        $this->info("   Sending reset link for user: {$user->email}");
        $this->info("   APP_URL is: " . config('app.url'));
        $this->info("   MAIL_MAILER is: " . config('mail.default'));
        $this->info("   MAIL_HOST is: " . config('mail.mailers.smtp.host'));

        try {
            $status = Password::sendResetLink(['email' => $user->email]);

            if ($status === Password::RESET_LINK_SENT) {
                return ['success' => true, 'message' => "Reset link sent to {$user->email} (status: {$status})"];
            }

            return ['success' => false, 'message' => "Laravel returned status: {$status} — email may not have been sent."];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function testVerificationCodeEmail(string $email): array
    {
        $this->info("");
        $this->info("📧 Testing Verification Code Email...");

        try {
            $code = rand(100000, 999999);
            Mail::to($email)->send(new VerificationCodeMail($code));

            return ['success' => true, 'message' => "Sent verification code: {$code}"];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function testWeatherWarningEmail(string $email): array
    {
        $this->info("");
        $this->info("🌧️ Testing Weather Warning Email...");

        try {
            $alert = [
                'title' => 'Heavy Rainfall Expected',
                'message' => 'Heavy rainfall is forecasted for the next 24 hours. Expect 50-100mm of precipitation.',
                'severity' => 'high',
                'recommendation' => 'Ensure proper drainage in rice paddies. Delay any fertilizer application. Consider harvesting mature crops early.'
            ];

            Mail::to($email)->send(new WeatherWarningMail($alert));

            return ['success' => true, 'message' => "Sent weather warning: {$alert['title']}"];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function testPreOrderAvailableEmail(string $email, RiceOrder $order): array
    {
        $this->info("");
        $this->info("📦 Testing Pre-Order Available Email...");

        try {
            Mail::to($email)->send(new PreOrderAvailableMail($order));

            return ['success' => true, 'message' => "Sent pre-order available for order #{$order->id}"];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function testOrderPickupReminderEmail(string $email, RiceOrder $order): array
    {
        $this->info("");
        $this->info("⏰ Testing Order Pickup Reminder Email...");

        try {
            Mail::to($email)->send(new OrderPickupReminderMail($order));

            return ['success' => true, 'message' => "Sent pickup reminder for order #{$order->id}"];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function testPickupDeadlineWarningEmail(string $email, RiceOrder $order): array
    {
        $this->info("");
        $this->info("⚠️ Testing Pickup Deadline Warning Email...");

        try {
            Mail::to($email)->send(new PickupDeadlineWarningMail($order, 24));

            return ['success' => true, 'message' => "Sent deadline warning for order #{$order->id} (24 hours remaining)"];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function testOrderExpiredEmail(string $email, RiceOrder $order, string $recipientType): array
    {
        $this->info("");
        $this->info("🚫 Testing Order Expired Email ({$recipientType})...");

        try {
            Mail::to($email)->send(new OrderExpiredMail($order, $recipientType));

            return ['success' => true, 'message' => "Sent order expired ({$recipientType}) for order #{$order->id}"];
        } catch (\Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    private function getOrCreateTestOrder(?User $user): ?RiceOrder
    {
        try {
            // Try to find an existing order first
            if ($user) {
                // First try to find orders where user is a farmer
                $order = RiceOrder::whereHas('riceProduct', function ($q) use ($user) {
                    $q->where('farmer_id', $user->id);
                })->with(['buyer', 'riceProduct'])->first();

                if ($order) {
                    return $order;
                }

                // Then try orders where user is a buyer
                $order = RiceOrder::where('buyer_id', $user->id)
                    ->with(['buyer', 'riceProduct'])
                    ->first();

                if ($order) {
                    return $order;
                }
            }

            // Get any order that has proper relationships
            // Use latest to get more recent data which might be more valid
            $order = RiceOrder::with(['buyer', 'riceProduct'])
                ->whereHas('riceProduct')
                ->latest()
                ->first();

            if ($order) {
                return $order;
            }

            // Fallback: just get any order
            $order = RiceOrder::with(['buyer', 'riceProduct'])->latest()->first();

            return $order;

        } catch (\Exception $e) {
            $this->error("Error fetching test order: " . $e->getMessage());
            // Try one last desperate attempt without relationships loaded, 
            // relying on lazy loading if needed, or just return null
            return RiceOrder::first();
        }
    }
}
