<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8">
      <div>
        <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-full bg-green-100">
          <svg class="h-8 w-8 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
          </svg>
        </div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Join ANIBUKID
        </h2>
        <p class="mt-2 text-center text-sm text-gray-600">
          Create your account to manage rice farming operations
        </p>
      </div>
      
      <form class="mt-8 space-y-6" @submit.prevent="handleRegister">
        <div class="space-y-4">
          <div class="grid grid-cols-12 gap-4">
            <div class="col-span-12 sm:col-span-5">
              <label for="first_name" class="block text-sm font-medium text-gray-700">First Name</label>
              <input
                id="first_name"
                v-model="form.first_name"
                name="first_name"
                type="text"
                required
                :class="['mt-1 appearance-none relative block w-full px-3 py-2 border placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm', errors.first_name ? 'border-red-300' : 'border-gray-300']"
                placeholder="First Name"
              />
              <p v-if="errors.first_name" class="mt-1 text-xs text-red-600">{{ errors.first_name }}</p>
            </div>
            <div class="col-span-12 sm:col-span-2">
              <label for="middle_initial" class="block text-sm font-medium text-gray-700">M.I.</label>
              <input
                id="middle_initial"
                v-model="form.middle_initial"
                name="middle_initial"
                type="text"
                maxlength="5"
                :class="['mt-1 appearance-none relative block w-full px-3 py-2 border placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm', errors.middle_initial ? 'border-red-300' : 'border-gray-300']"
                placeholder="M.I."
              />
              <p v-if="errors.middle_initial" class="mt-1 text-xs text-red-600">{{ errors.middle_initial }}</p>
            </div>
            <div class="col-span-12 sm:col-span-5">
              <label for="last_name" class="block text-sm font-medium text-gray-700">Last Name</label>
              <input
                id="last_name"
                v-model="form.last_name"
                name="last_name"
                type="text"
                required
                :class="['mt-1 appearance-none relative block w-full px-3 py-2 border placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm', errors.last_name ? 'border-red-300' : 'border-gray-300']"
                placeholder="Last Name"
              />
              <p v-if="errors.last_name" class="mt-1 text-xs text-red-600">{{ errors.last_name }}</p>
            </div>
          </div>
          
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
            <input
              id="email"
              v-model="form.email"
              name="email"
              type="email"
              autocomplete="email"
              required
              :class="['mt-1 appearance-none relative block w-full px-3 py-2 border placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm', errors.email ? 'border-red-300' : 'border-gray-300']"
              placeholder="Enter your email address"
            />
            <p v-if="errors.email" class="mt-1 text-xs text-red-600">{{ errors.email }}</p>
          </div>

          <div>
            <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
            <input
              id="phone"
              v-model="form.phone"
              name="phone"
              type="tel"
              required
              :class="['mt-1 appearance-none relative block w-full px-3 py-2 border placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm', errors.phone ? 'border-red-300' : 'border-gray-300']"
              placeholder="e.g. 09123456789"
            />
            <p v-if="errors.phone" class="mt-1 text-xs text-red-600">{{ errors.phone }}</p>
          </div>


          
          <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <input
              id="password"
              v-model="form.password"
              name="password"
              type="password"
              autocomplete="new-password"
              required
              :class="['mt-1 appearance-none relative block w-full px-3 py-2 border placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm', errors.password ? 'border-red-300' : 'border-gray-300']"
              placeholder="Create a password"
            />
            <p v-if="errors.password" class="mt-1 text-xs text-red-600">{{ errors.password }}</p>
          </div>
          
          <div>
            <label for="password_confirmation" class="block text-sm font-medium text-gray-700">Confirm Password</label>
            <input
              id="password_confirmation"
              v-model="form.password_confirmation"
              name="password_confirmation"
              type="password"
              autocomplete="new-password"
              required
              class="mt-1 appearance-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm"
              placeholder="Confirm your password"
            />
          </div>
        </div>

        <div v-if="authStore.error" class="rounded-md bg-red-50 border border-red-200 px-4 py-3 mb-4">
          <div class="flex">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <p class="text-sm text-red-800">{{ authStore.error }}</p>
            </div>
          </div>
        </div>

        <div>
          <button
            type="submit"
            :disabled="authStore.loading"
            class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="authStore.loading" class="absolute left-0 inset-y-0 flex items-center pl-3">
              <div class="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
            </span>
            {{ authStore.loading ? 'Creating account...' : 'Create account' }}
          </button>
        </div>

        <div class="text-center">
          <p class="text-sm text-gray-600">
            Already have an account?
            <router-link to="/login" class="font-medium text-green-600 hover:text-green-500">
              Sign in here
            </router-link>
          </p>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '@/stores/auth';
import { useFormValidation } from '@/composables/useFormValidation';

const router = useRouter();
const authStore = useAuthStore();
const { errors, rules, validateForm, sanitizeForm } = useFormValidation();

const form = ref({
  first_name: '',
  middle_initial: '',
  last_name: '',
  email: '',
  phone: '',
  verification_method: 'email', // Default to Email
  role: 'buyer', // Default to buyer
  password: '',
  password_confirmation: ''
});

const handleRegister = async () => {
  // Clear previous errors
  authStore.error = null;
  
  // Sanitize inputs (strip emojis)
  sanitizeForm(form.value);

  // Validate form
  const isValid = validateForm(form.value, {
    first_name: [rules.required, rules.maxLength(255), rules.alphaSpaces, rules.noEmoji],
    last_name: [rules.required, rules.maxLength(255), rules.alphaSpaces, rules.noEmoji],
    email: [rules.required, rules.email, rules.maxLength(255)],
    phone: [rules.required, rules.phone, rules.maxLength(20)],
    password: [rules.required, rules.minLength(8)]
  });

  if (!isValid) {
    authStore.error = 'Please fix the errors in the form before submitting.';
    return;
  }
  
  if (form.value.password !== form.value.password_confirmation) {
    authStore.error = 'Passwords do not match.';
    return;
  }
  
  try {
    // Register user first (this sends the verification code)
    const response = await authStore.register(form.value);
    
    // On success, redirect to verification page
    // In local/dev mode, pass the debug code for testing
    router.push({ 
      path: '/verify-phone', 
      query: { 
        phone: form.value.phone,
        email: form.value.email,
        method: form.value.verification_method,
        // Debug code for development (only available in local environment)
        debug_code: response?.debug_verification_code || ''
      } 
    });
  } catch (error) {
    // Error is handled in the store
    console.error('Registration error:', error);
    // Log the full error response for debugging
    if (error.response?.data) {
      console.error('Error response:', error.response.data);
    }
  }
};
</script>