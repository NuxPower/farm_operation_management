<template>
  <div class="min-h-screen bg-gray-50">
    <div class="container mx-auto px-4 py-8">
      <!-- Standard Header -->
      <div class="flex flex-col md:flex-row justify-between items-center mb-8 gap-4">
        <div>
          <h1 class="text-3xl font-bold text-gray-800">Shopping Cart</h1>
          <p class="text-gray-500 mt-1">Review and manage your cart items</p>
        </div>
      </div>

      <!-- Loading -->
      <div v-if="loading" class="text-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-green-600 mx-auto"></div>
      </div>

      <!-- Empty Cart -->
      <div v-else-if="cartItems.length === 0" class="text-center py-16 bg-white rounded-xl shadow">
        <div class="text-6xl mb-4">🛒</div>
        <h2 class="text-xl font-medium text-gray-900 mb-2">Your cart is empty</h2>
        <p class="text-gray-500 mb-6">Browse our marketplace to find quality rice products</p>
        <router-link to="/buyer/products"
          class="inline-flex items-center px-6 py-3 bg-green-600 text-white rounded-lg hover:bg-green-700"
        >Browse Products</router-link>
      </div>

      <!-- Cart Items -->
      <div v-else class="space-y-6">
        <div class="bg-white rounded-xl shadow divide-y">
          <div v-for="item in cartItems" :key="item.id" class="p-6 flex gap-6">
            <div class="w-20 h-20 bg-green-100 rounded-lg flex items-center justify-center text-4xl flex-shrink-0 overflow-hidden">
              <img
                v-if="item.rice_product?.images?.length"
                :src="item.rice_product.images[0]"
                :alt="item.rice_product?.name"
                class="w-full h-full object-cover"
              />
              <span v-else>🌾</span>
            </div>
            <div class="flex-1">
              <h3 class="font-semibold text-gray-900 mb-1">{{ item.rice_product?.name }}</h3>
              <p class="text-sm text-gray-500 mb-2">
                Seller: {{ item.rice_product?.farmer?.name || 'N/A' }}
              </p>
              <p class="text-lg font-medium text-green-600">
                {{ formatCurrency(item.rice_product?.price_per_unit || 0) }} / {{ item.rice_product?.unit || 'kg' }}
              </p>
            </div>
            <div class="flex flex-col items-end gap-2">
              <div class="flex items-center gap-2">
                <button @click="updateQuantity(item, -1)" class="w-8 h-8 rounded-full bg-gray-200 hover:bg-gray-300">−</button>
                <input v-model.number="item.quantity" type="number" min="1" 
                  class="w-16 text-center border rounded-md" @change="saveQuantity(item)" />
                <button @click="updateQuantity(item, 1)" class="w-8 h-8 rounded-full bg-gray-200 hover:bg-gray-300">+</button>
              </div>
              <p class="font-semibold text-gray-900">{{ formatCurrency(item.quantity * (item.rice_product?.price_per_unit || 0)) }}</p>
              <button @click="confirmRemoveItem(item)" class="text-red-600 text-sm hover:underline">Remove</button>
            </div>
          </div>
        </div>

        <!-- Summary -->
        <div class="bg-white rounded-xl shadow p-6">
          <div class="flex justify-between items-center mb-4">
            <span class="text-gray-600">Subtotal ({{ cartItems.length }} items)</span>
            <span class="text-xl font-bold text-gray-900">{{ formatCurrency(total) }}</span>
          </div>
          <button @click="showCheckoutModal = true"
            class="w-full py-3 bg-green-600 text-white rounded-lg font-medium hover:bg-green-700"
          >Proceed to Checkout</button>
          <button @click="confirmClearCart"
            class="w-full mt-2 py-2 text-gray-600 hover:text-red-600"
          >Clear Cart</button>
        </div>
      </div>

      <!-- Checkout Modal -->
      <div v-if="showCheckoutModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div class="bg-white rounded-xl max-w-md w-full p-6">
          <h2 class="text-xl font-bold text-gray-900 mb-4">Checkout</h2>
          
          <form @submit.prevent="confirmCheckout">
            <div class="mb-4 p-3 bg-gray-50 border border-gray-200 rounded-lg">
              <div class="flex items-center gap-2 text-gray-800 font-medium mb-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-600" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z" />
                  <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0014 7z" />
                </svg>
                <span>Pickup from Farm</span>
              </div>
              <p class="text-sm text-gray-600">
                Your order will be prepared for pickup at the farmer's location.
              </p>
            </div>

            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700 mb-1">Preferred Pickup Date *</label>
              <input 
                type="date" 
                v-model="checkoutForm.preferred_pickup_date" 
                :min="minPickupDate"
                required
                class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500"
              />
              <p class="text-xs text-gray-500 mt-1">Choose when you'd like to pick up your order</p>
            </div>

            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700 mb-1">Payment Method</label>
              <select v-model="checkoutForm.payment_method" required class="w-full px-3 py-2 border rounded-lg">
                <option value="Cash on Delivery">Cash on Delivery</option>
                <option value="Bank Transfer">Bank Transfer</option>
                <option value="GCash">GCash</option>
              </select>
            </div>

            <div class="mb-6">
              <label class="block text-sm font-medium text-gray-700 mb-1">Notes (Optional)</label>
              <textarea v-model="checkoutForm.notes" rows="2" class="w-full px-3 py-2 border rounded-lg"
                placeholder="Any special instructions?"></textarea>
            </div>

            <div class="border-t pt-4 mb-4">
              <div class="flex justify-between text-lg font-bold">
                <span>Total</span>
                <span>{{ formatCurrency(total) }}</span>
              </div>
            </div>

            <div class="flex gap-3">
              <button type="button" @click="showCheckoutModal = false"
                class="flex-1 px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200"
              >Cancel</button>
              <button type="submit"
                class="flex-1 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700"
              >Place Order</button>
            </div>
          </form>
        </div>
      </div>
      
      <!-- Confirmation Modal -->
      <ConfirmationModal
        :show="showConfirmModal"
        :title="confirmTitle"
        :message="confirmMessage"
        :confirm-text="confirmButtonText"
        :type="confirmType"
        @close="showConfirmModal = false"
        @confirm="handleConfirmAction"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useMarketplaceStore } from '@/stores/marketplace'
import ConfirmationModal from '@/Components/UI/ConfirmationModal.vue'
import { formatCurrency } from '@/utils/format'

const router = useRouter()
const marketplaceStore = useMarketplaceStore()
const showCheckoutModal = ref(false)
const checkingOut = ref(false)

// Confirmation State
const showConfirmModal = ref(false)
const confirmTitle = ref('')
const confirmMessage = ref('')
const confirmButtonText = ref('Confirm')
const confirmType = ref('danger')
const pendingAction = ref(null)

const checkoutForm = ref({
  delivery_address: '',
  delivery_method: 'pickup',
  payment_method: 'Cash on Delivery',
  notes: '',
  preferred_pickup_date: '',
})

// Computed: minimum pickup date (tomorrow)
const minPickupDate = computed(() => {
  const tomorrow = new Date()
  tomorrow.setDate(tomorrow.getDate() + 1)
  return tomorrow.toISOString().split('T')[0]
})

// Use store getters and state
const loading = computed(() => marketplaceStore.loading)
const cartItems = computed(() => marketplaceStore.cart)
const total = computed(() => marketplaceStore.cartTotal)

const updateQuantity = async (item, delta) => {
  const newQty = item.quantity + delta
  if (newQty < 1) return
  await marketplaceStore.updateCartQuantity(item.id, newQty)
}

const saveQuantity = async (item) => {
  await marketplaceStore.updateCartQuantity(item.id, item.quantity)
}

const confirmRemoveItem = (item) => {
  pendingAction.value = () => removeItem(item)
  confirmTitle.value = 'Remove Item'
  confirmMessage.value = `Are you sure you want to remove "${item.name}" from your cart?`
  confirmButtonText.value = 'Remove'
  confirmType.value = 'danger'
  showConfirmModal.value = true
}

const removeItem = async (item) => {
  await marketplaceStore.removeFromCart(item.id)
  showConfirmModal.value = false
}

const confirmClearCart = () => {
  pendingAction.value = clearCart
  confirmTitle.value = 'Clear Cart'
  confirmMessage.value = 'Are you sure you want to remove all items from your cart? This action cannot be undone.'
  confirmButtonText.value = 'Clear Cart'
  confirmType.value = 'danger'
  showConfirmModal.value = true
}

const clearCart = async () => {
  await marketplaceStore.clearCart()
  showConfirmModal.value = false
}

const confirmCheckout = () => {
  pendingAction.value = processCheckout
  confirmTitle.value = 'Confirm Order'
  confirmMessage.value = `Are you sure you want to place this order? Total amount to pay is ${formatCurrency(total.value)}.`
  confirmButtonText.value = 'Place Order'
  confirmType.value = 'success'
  showCheckoutModal.value = false 
  showConfirmModal.value = true
}

const processCheckout = async () => {
  checkingOut.value = true
  showConfirmModal.value = false 
  
  try {
    await marketplaceStore.checkout({
      delivery_address: {
        street: 'Pickup from farmer',
        city: '',
        state: '',
        country: 'Philippines'
      },
      delivery_method: 'pickup',
      payment_method: checkoutForm.value.payment_method,
      notes: checkoutForm.value.notes,
      preferred_pickup_date: checkoutForm.value.preferred_pickup_date,
    })
    
    alert('Order placed successfully!')
    router.push('/buyer/orders')
  } catch (error) {
    alert(marketplaceStore.error || 'Checkout failed')
  } finally {
    checkingOut.value = false
  }
}

const handleConfirmAction = () => {
  if (pendingAction.value) {
    pendingAction.value()
  }
  pendingAction.value = null
}



onMounted(() => {
  marketplaceStore.fetchCart()
})
</script>
