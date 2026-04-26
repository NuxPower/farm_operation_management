<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Header -->
    <header class="bg-white shadow-sm border-b border-gray-200">
      <div class="w-full mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <div class="flex items-center">
            <router-link to="/cart" class="text-gray-500 hover:text-gray-700 mr-4">
              <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
            </router-link>
            <div>
              <h1 class="text-xl font-semibold text-gray-900">Checkout</h1>
              <p class="text-sm text-gray-500">Complete your purchase</p>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main class="w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div v-if="marketplaceStore.cartItemsCount === 0" class="text-center py-12">
        <p class="text-gray-600 mb-4">Your cart is empty.</p>
        <router-link 
          to="/marketplace"
          class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors inline-block"
        >
          Browse Products
        </router-link>
      </div>

      <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Checkout Form -->
        <div class="lg:col-span-2 space-y-6">
          
          <!-- Pickup Method & Date -->
          <div class="bg-white rounded-lg shadow p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Delivery Method</h3>
            
            <div class="mb-6 p-4 bg-gray-50 border border-gray-200 rounded-lg">
              <div class="flex items-center gap-2 text-gray-800 font-medium mb-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-600" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z" />
                  <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0014 7z" />
                </svg>
                <span>Pickup from Farm</span>
              </div>
              <p class="text-sm text-gray-600 ml-7">
                Your order will be prepared for pickup at the farmer's location.
              </p>
            </div>

            <div class="mb-4">
              <label for="pickup_date" class="block text-sm font-medium text-gray-700 mb-1">Preferred Pickup Date *</label>
              <input 
                type="date" 
                id="pickup_date" 
                v-model="form.preferred_pickup_date" 
                :min="minPickupDate"
                required
                class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500 sm:text-sm"
              />
              <p class="text-xs text-gray-500 mt-1">Choose when you'd like to pick up your order</p>
            </div>
          </div>

          <!-- Delivery Method -->
          <div class="bg-white rounded-lg shadow p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Delivery Method</h3>
            <div class="space-y-4">
              <div class="flex items-center">
                <input id="delivery_pickup" name="delivery_method" type="radio" value="pickup" v-model="form.delivery_method" class="focus:ring-green-500 h-4 w-4 text-green-600 border-gray-300" checked>
                <label for="delivery_pickup" class="ml-3 block text-sm font-medium text-gray-700">
                  Pickup from Farm
                </label>
              </div>
              <p class="text-sm text-gray-500 ml-7">
                Products must be picked up directly from the farmer's location. Contact the farmer for pickup schedule and location details after placing your order.
              </p>
            </div>
          </div>


          
          <!-- Notes -->
           <div class="bg-white rounded-lg shadow p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Order Notes</h3>
            <div>
              <label for="notes" class="block text-sm font-medium text-gray-700">Additional Instructions</label>
              <textarea id="notes" v-model="form.notes" rows="3" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500 sm:text-sm"></textarea>
            </div>
          </div>
          
          <!-- Price Negotiation -->


        </div>

        <!-- Order Summary -->
        <div class="lg:col-span-1">
          <div class="bg-white rounded-lg shadow p-6 sticky top-8">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Order Summary</h3>
            
            <div class="space-y-4 mb-6">
              <div v-for="item in marketplaceStore.cart" :key="item.id" class="flex justify-between text-sm">
                <span class="text-gray-600">{{ item.name }} x {{ item.quantity }}</span>
                <span class="text-gray-900">{{ formatCurrency(item.price * item.quantity) }}</span>
              </div>
              
              <div class="border-t border-gray-200 pt-4">
                <div class="flex justify-between text-sm mb-2">
                  <span class="text-gray-600">Subtotal</span>
                  <span class="text-gray-900">{{ formatCurrency(marketplaceStore.cartTotal) }}</span>
                </div>
                <div class="flex justify-between text-sm mb-2">
                  <span class="text-gray-600">Shipping</span>
                  <span class="text-gray-900">{{ formatCurrency(shippingCost) }}</span>
                </div>
                <div class="flex justify-between text-sm mb-2">
                  <span class="text-gray-600">Tax (8%)</span>
                  <span class="text-gray-900">{{ formatCurrency(taxAmount) }}</span>
                </div>
                <div class="border-t border-gray-200 pt-2 flex justify-between text-lg font-semibold">
                  <span class="text-gray-900">Total</span>
                  <span class="text-gray-900">{{ formatCurrency(totalAmount) }}</span>
                </div>
              </div>
            </div>

            <button 
              @click="confirmOrder"
              :disabled="loading"
              class="w-full bg-green-600 text-white py-3 px-4 rounded-lg hover:bg-green-700 transition-colors font-medium disabled:opacity-50 disabled:cursor-not-allowed flex justify-center items-center"
            >
              <svg v-if="loading" class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              {{ loading ? 'Processing...' : 'Place Order' }}
            </button>
            
            <div v-if="error" class="mt-4 text-sm text-red-600">
              {{ error }}
            </div>
          </div>
        </div>
      </div>
      
      <!-- Confirmation Modal -->
      <ConfirmationModal
        :show="showConfirmModal"
        :title="confirmTitle"
        :message="confirmMessage"
        :confirm-text="confirmButtonText"
        type="success"
        @close="showConfirmModal = false"
        @confirm="submitOrder"
      />
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useMarketplaceStore } from '@/stores/marketplace';
import { useAuthStore } from '@/stores/auth';
import { formatCurrency } from '@/utils/format';
import ConfirmationModal from '@/Components/UI/ConfirmationModal.vue';
import { useFormValidation } from '@/composables/useFormValidation';

const router = useRouter();
const marketplaceStore = useMarketplaceStore();
const authStore = useAuthStore();
const { errors: clientErrors, rules, validateForm, sanitizeForm, clearErrors } = useFormValidation();

const loading = ref(false);
const error = ref(null);

// Confirmation State
const showConfirmModal = ref(false);
const confirmTitle = ref('');
const confirmMessage = ref('');
const confirmButtonText = ref('Place Order');

const form = ref({
  address: {
    street: 'Pickup from farmer',
    city: '',
    state: '',
    postal_code: '',
    country: 'Philippines'
  },
  delivery_method: 'pickup',
  payment_method: 'cod',
  notes: '',
  preferred_pickup_date: ''
});

// Computed: minimum pickup date (tomorrow)
const minPickupDate = computed(() => {
  const tomorrow = new Date()
  tomorrow.setDate(tomorrow.getDate() + 1)
  return tomorrow.toISOString().split('T')[0]
})

// Pre-fill address from user profile if available
onMounted(async () => {
  await marketplaceStore.fetchCart();
  // No need to pre-fill address for pickup
});

const shippingCost = computed(() => {
  return 0; // Free shipping for pickup
});

const taxAmount = computed(() => {
  return marketplaceStore.cartTotal * 0.08;
});

const totalAmount = computed(() => {
  return marketplaceStore.cartTotal + shippingCost.value + taxAmount.value;
});

const confirmOrder = () => {
  // Basic validation before showing confirmation
  if (!form.value.preferred_pickup_date) {
    error.value = 'Please select a preferred pickup date.';
    return;
  }
  
  clearErrors();
  sanitizeForm(form.value);
  const isValid = validateForm(form.value, {
    notes: [rules.maxLength(2000), rules.noEmoji]
  });
  
  if (!isValid) {
    error.value = Object.values(clientErrors.value).join(' ');
    return;
  }

  error.value = null;
  confirmTitle.value = 'Confirm Purchase';
  
  confirmMessage.value = `Are you sure you want to place this order? Total amount is ${formatCurrency(totalAmount.value)}.`;
  
  showConfirmModal.value = true;
};

const submitOrder = async () => {
  showConfirmModal.value = false;
  loading.value = true;
  error.value = null;

  try {
    // Use bulk checkout action
    await marketplaceStore.checkout({
      delivery_address: form.value.address,
      delivery_method: form.value.delivery_method,
      payment_method: form.value.payment_method,
      notes: form.value.notes,
      offer_price: null,
      preferred_pickup_date: form.value.preferred_pickup_date
    });

    // Success - Cart is already cleared by the store action
    
    // Show success message or redirect
    router.push('/marketplace/orders');
    
  } catch (err) {
    console.error('Order submission failed:', err);
    error.value = err.response?.data?.message || 'Checkout failed. Please try again.';
  } finally {
    loading.value = false;
  }
};
</script>
