<template>
  <div class="min-h-screen flex bg-white">
    <div class="hidden lg:flex lg:w-1/2 relative bg-emerald-900 overflow-hidden">
      <img
        src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvideocdn.cdnpk.net%2Fvideos%2Fc26be4b4-774f-419a-8a2f-23ab8a5ec41f%2Fhorizontal%2Fthumbnails%2Flarge.jpg&f=1&nofb=1&ipt=1312bd0242d431b3ae9b0426ec439925c9bf29a6d4166f8e0ea48943b0abbb96"
        alt="Greenhouse Harvest"
        class="absolute inset-0 h-full w-full object-cover opacity-50 mix-blend-overlay"
      />

      <div class="relative z-10 w-full flex flex-col justify-between p-16 text-white">
        <div class="flex items-center space-x-4">
          <div class="transform transition-transform hover:scale-105">
            <img src="@assets/logo.png" alt="Logo" class="h-28 w-28 object-contain drop-shadow-md" />
          </div>
          <span class="text-3xl font-bold tracking-wide font-display">ANIBUKID</span>
        </div>

        <div class="space-y-8">
          <h1 class="text-4xl xl:text-5xl font-extrabold leading-tight">
            Farm-to-Table <br/>
            <span class="text-emerald-300">Simplified.</span>
          </h1>

          <p class="text-emerald-100 text-lg max-w-md leading-relaxed">
            The central hub for our agricultural ecosystem.
          </p>

          <div class="grid grid-cols-2 gap-6 pt-4 border-t border-emerald-500/30">
            <div class="space-y-2">
              <h3 class="text-emerald-300 font-semibold uppercase text-xs tracking-wider">For Operations</h3>
              <ul class="text-sm space-y-2 text-emerald-50">
                <li class="flex items-center">
                  <svg class="w-4 h-4 mr-2 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  Inventory Management
                </li>
                <li class="flex items-center">
                  <svg class="w-4 h-4 mr-2 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  Harvest Analytics
                </li>
              </ul>
            </div>

            <div class="space-y-2">
              <h3 class="text-amber-300 font-semibold uppercase text-xs tracking-wider">For Buyers</h3>
              <ul class="text-sm space-y-2 text-emerald-50">
                <li class="flex items-center">
                  <svg class="w-4 h-4 mr-2 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  Browse Fresh Crops
                </li>
                <li class="flex items-center">
                  <svg class="w-4 h-4 mr-2 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  Direct Ordering
                </li>
              </ul>
            </div>
          </div>
        </div>

        <div class="text-xs text-emerald-300/60 font-mono">
          System v2.4.0 • Secure Connection
        </div>
      </div>
    </div>

    <div class="w-full lg:w-1/2 flex items-center justify-center p-8 sm:p-12 bg-gray-50/50">
      <div class="w-full max-w-md bg-white p-10 rounded-2xl shadow-xl border border-gray-100">

        <div class="lg:hidden text-center mb-8">
          <div class="inline-flex items-center justify-center p-3 rounded-xl bg-gradient-to-br from-emerald-500 to-green-600 shadow-lg mb-4">
            <svg class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 006.001 0M6 7l3 9M6 7l6-2m6 2l3-1m-3 1l-3 9a5.002 5.002 0 006.001 0M18 7l3 9m-3-9l-6-2m0-2v2m0 16V5m0 16H9m3 0h3" />
            </svg>
          </div>
          <h2 class="text-xl font-bold text-gray-800">ANIBUKID</h2>
        </div>

        <div class="mb-8">
          <h2 class="text-2xl font-bold text-gray-900">Welcome Back</h2>
          <p class="mt-2 text-sm text-gray-500">
            Please log in to manage your farm operations or access the wholesale marketplace.
          </p>
        </div>

        <form class="space-y-6" @submit.prevent="handleLogin">
          <div class="space-y-5">
            <div>
              <label for="login_id" class="block text-sm font-semibold text-gray-700">
                Email or Phone
              </label>
              <input
                id="login_id"
                v-model="form.login_id"
                name="login_id"
                type="text"
                required
                class="mt-1 block w-full px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 focus:bg-white transition-colors text-gray-900 text-sm"
                placeholder="Enter your registered email"
              />
            </div>

            <div>
              <div class="flex items-center justify-between">
                <label for="password" class="block text-sm font-semibold text-gray-700">
                  Password
                </label>
                <router-link to="/forgot-password" class="text-sm font-medium text-emerald-600 hover:text-emerald-500">
                  Forgot password?
                </router-link>
              </div>
              <input
                id="password"
                v-model="form.password"
                name="password"
                type="password"
                autocomplete="current-password"
                required
                class="mt-1 block w-full px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 focus:bg-white transition-colors text-gray-900 text-sm"
                placeholder="••••••••"
              />
            </div>

            <div class="rounded-lg border border-gray-200 bg-gray-50 p-4">
              <p class="text-xs font-semibold uppercase tracking-wide text-gray-600">Terms of Service</p>
              <p class="mt-2 text-sm text-gray-600 leading-relaxed">
                By signing in, you agree to use Anibukid responsibly, keep your account secure, and provide accurate farm and marketplace records. Misuse, fraud, and unauthorized access are prohibited.
              </p>
              <label class="mt-3 flex items-start gap-2 text-sm text-gray-700">
                <input
                  v-model="form.accept_tos"
                  type="checkbox"
                  class="mt-1 h-4 w-4 rounded border-gray-300 text-emerald-600 focus:ring-emerald-500"
                />
                <span>I have read and accept the Terms of Service.</span>
              </label>
            </div>
          </div>

          <div v-if="authStore.error" class="rounded-lg bg-red-50 p-4 border border-red-100 flex items-start">
            <svg class="h-5 w-5 text-red-400 mt-0.5 mr-3" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
            </svg>
            <div>
              <h3 class="text-sm font-medium text-red-800">Login Failed</h3>
              <p class="mt-1 text-sm text-red-600">{{ authStore.error }}</p>
            </div>
          </div>

          <button
            type="submit"
            :disabled="authStore.loading"
            class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-bold text-white bg-emerald-600 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 disabled:opacity-70 disabled:cursor-not-allowed transition-all"
          >
            <span v-if="authStore.loading" class="mr-2">
              <svg class="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
            </span>
            {{ authStore.loading ? 'Accessing System...' : 'Sign In' }}
          </button>

          <div class="mt-6">
            <div class="relative">
              <div class="absolute inset-0 flex items-center">
                <div class="w-full border-t border-gray-200"></div>
              </div>
              <div class="relative flex justify-center text-sm">
                <span class="px-2 bg-white text-gray-500">New to Anibukid?</span>
              </div>
            </div>

            <div class="mt-6 text-center">
               <p class="text-sm text-gray-600 mb-2">Join our network of buyers</p>
               <router-link to="/register" class="inline-flex items-center text-emerald-600 hover:text-emerald-700 font-semibold transition-colors">
                  Create a Buyer Account
                  <svg class="ml-1 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
               </router-link>
            </div>

            <div class="mt-4 pt-4 border-t border-gray-200 text-center">
               <p class="text-sm text-gray-500 mb-2">Just browsing?</p>
               <router-link to="/marketplace" class="inline-flex items-center text-amber-600 hover:text-amber-700 font-medium transition-colors">
                  View Marketplace as Guest
                  <svg class="ml-1 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
               </router-link>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '@/stores/auth';

const router = useRouter();
const authStore = useAuthStore();

const form = ref({
  login_id: '',
  password: '',
  accept_tos: false,
});

const handleLogin = async () => {
  try {
    // Assuming the store handles role-based redirection
    // e.g., if (user.role === 'farmer') push('/admin') else push('/shop')
    await authStore.login(form.value);
    router.push('/dashboard');
  } catch (error) {
    console.error('Login error:', error);
    
    // Handle unverified account error
    if (error.response?.status === 403 && error.response?.data?.message?.includes('verified')) {
      const isEmail = form.value.login_id.includes('@');
      router.push({
        path: '/verify-phone',
        query: {
          email: isEmail ? form.value.login_id : undefined,
          phone: !isEmail ? form.value.login_id : undefined,
          method: isEmail ? 'email' : 'sms'
        }
      });
      return;
    }

    authStore.error = error.response?.data?.message || 'Login failed. Please try again.';
  }
};
</script>
