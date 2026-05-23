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
          <div class="bg-white rounded-lg shadow p-6">
            <div class="flex items-start justify-between gap-4 mb-4">
              <div>
                <h3 class="text-lg font-medium text-gray-900">Price Negotiation</h3>
                <p class="text-sm text-gray-500 mt-1">Submit a lower per-unit offer for any item in this checkout.</p>
              </div>
              <button
                type="button"
                @click="clearOfferPrices"
                class="text-sm text-gray-500 hover:text-red-600"
                v-if="hasOfferPrices"
              >
                Clear offers
              </button>
            </div>

            <div class="space-y-4">
              <div
                v-for="item in marketplaceStore.cart"
                :key="`offer-${item.id}`"
                class="rounded-lg border border-gray-200 p-4"
              >
                <div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                  <div class="min-w-0">
                    <div class="font-medium text-gray-900 truncate">{{ item.name }}</div>
                    <div class="text-sm text-gray-500">
                      Listed: {{ formatCurrency(item.price) }}/{{ formatUnit(item.unit) }} · Qty {{ item.quantity }}
                    </div>
                  </div>
                  <div class="w-full sm:w-48">
                    <label :for="`offer-${item.id}`" class="block text-xs font-medium text-gray-600 mb-1">
                      Offer per unit
                    </label>
                    <input
                      :id="`offer-${item.id}`"
                      :value="offerPrices[item.id] || ''"
                      @input="setOfferPrice(item.id, $event.target.value)"
                      type="number"
                      step="0.01"
                      min="0.01"
                      :max="Math.max(Number(item.price) - 0.01, 0.01)"
                      class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500 sm:text-sm"
                      placeholder="Optional"
                    />
                    <p v-if="getOfferError(item)" class="text-xs text-red-600 mt-1">
                      {{ getOfferError(item) }}
                    </p>
                  </div>
                </div>
                <div v-if="getValidOffer(item)" class="mt-3 rounded-md bg-orange-50 border border-orange-200 px-3 py-2 text-sm text-orange-800">
                  Proposed subtotal: {{ formatCurrency(getValidOffer(item) * item.quantity) }}
                  <span class="text-orange-600">
                    ({{ formatCurrency((item.price - getValidOffer(item)) * item.quantity) }} below list)
                  </span>
                </div>
              </div>
            </div>
          </div>

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
                  <span class="text-gray-600">List Subtotal</span>
                  <span class="text-gray-900">{{ formatCurrency(marketplaceStore.cartTotal) }}</span>
                </div>
                <div v-if="hasOfferPrices" class="flex justify-between text-sm mb-2">
                  <span class="text-gray-600">Proposed Subtotal</span>
                  <span class="text-orange-700 font-medium">{{ formatCurrency(proposedSubtotal) }}</span>
                </div>
                <div class="flex justify-between text-sm mb-2">
                  <span class="text-gray-600">Shipping</span>
                  <span class="text-gray-900">{{ formatCurrency(shippingCost) }}</span>
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
import { formatCurrency, formatUnit } from '@/utils/format';
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
const offerPrices = ref({});

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

const totalAmount = computed(() => {
  return proposedSubtotal.value + shippingCost.value;
});

const hasOfferPrices = computed(() => Object.keys(normalizedOfferPrices.value).length > 0);

const normalizedOfferPrices = computed(() => {
  return Object.entries(offerPrices.value).reduce((offers, [cartItemId, price]) => {
    if (price !== null && price !== '') {
      offers[cartItemId] = Number(price);
    }
    return offers;
  }, {});
});

const proposedSubtotal = computed(() => {
  return marketplaceStore.cart.reduce((total, item) => {
    return total + (getValidOffer(item) || item.price) * item.quantity;
  }, 0);
});

const setOfferPrice = (cartItemId, value) => {
  offerPrices.value = {
    ...offerPrices.value,
    [cartItemId]: value,
  };
};

const clearOfferPrices = () => {
  offerPrices.value = {};
};

const getValidOffer = (item) => {
  const offer = Number(offerPrices.value[item.id]);
  if (!offer || offer <= 0 || offer >= Number(item.price)) return null;
  return offer;
};

const getOfferError = (item) => {
  const rawOffer = offerPrices.value[item.id];
  if (rawOffer === undefined || rawOffer === null || rawOffer === '') return '';

  const offer = Number(rawOffer);
  if (!offer || offer <= 0) return 'Enter an amount greater than zero.';
  if (offer >= Number(item.price)) return 'Offer must be lower than the listed price.';
  return '';
};

const getOfferErrors = () => {
  return marketplaceStore.cart
    .map(getOfferError)
    .filter(Boolean);
};

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

  const offerErrors = getOfferErrors();
  if (offerErrors.length) {
    error.value = offerErrors[0];
    return;
  }

  error.value = null;
  confirmTitle.value = 'Confirm Purchase';
  
  confirmMessage.value = hasOfferPrices.value
    ? `Submit this order with price negotiation offers? Proposed total is ${formatCurrency(totalAmount.value)}.`
    : `Are you sure you want to place this order? Total amount is ${formatCurrency(totalAmount.value)}.`;
  
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
      offer_prices: normalizedOfferPrices.value,
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
