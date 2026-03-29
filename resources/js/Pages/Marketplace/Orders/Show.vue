<template>
  <div class="order-detail-page">
    <div class="container mx-auto px-4 py-8">
      <div v-if="loading" class="py-24 text-center text-gray-500">
        <div class="mx-auto mb-4 h-10 w-10 animate-spin rounded-full border-b-2 border-green-600"></div>
        Loading order details...
      </div>

      <div v-else-if="error" class="mx-auto max-w-2xl rounded-lg bg-white p-6 text-center shadow">
        <h1 class="text-xl font-semibold text-gray-900 mb-2">Unable to load order</h1>
        <p class="text-gray-600 mb-6">{{ error }}</p>
        <button
          @click="router.push(ordersListRoute)"
          class="rounded-md bg-green-600 px-4 py-2 text-white hover:bg-green-700"
        >
          Back to Orders
        </button>
      </div>

      <div v-else-if="order" class="space-y-8">
        <!-- Header -->
        <div class="flex justify-between items-center">
        <div>
          <nav class="text-sm text-gray-500 mb-2">
              <router-link :to="ordersListRoute" class="hover:text-gray-700">Orders</router-link>
            <span class="mx-2">/</span>
            <span class="text-gray-900">Order #{{ order.id }}</span>
          </nav>
          <h1 class="text-3xl font-bold text-gray-900">Order #{{ order.id }}</h1>
            <p class="text-gray-600 mt-2">
              Placed on {{ formatDate(order.order_date || order.created_at) }}
            </p>
        </div>
          <button
            @click="printOrder"
            class="bg-gray-600 text-white px-4 py-2 rounded-md hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500"
          >
            Print Order
          </button>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Main Content -->
        <div class="lg:col-span-2 space-y-6">
          <!-- Order Status -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold mb-4">Order Status</h2>
            <div class="flex items-center justify-between mb-4">
              <span
                :class="getStatusBadgeClass(order.status)"
                class="px-3 py-1 text-sm font-medium rounded-full"
              >
                {{ formatStatus(order.status) }}
              </span>
              <span class="text-sm text-gray-600">
                Last updated: {{ formatDate(order.updated_at) }}
              </span>
            </div>

            <!-- Negotiation Status -->
             <!-- Negotiation Status -->
             <div v-if="activeNegotiation" class="mb-4 bg-orange-50 p-4 rounded-md border border-orange-200">
               <h3 class="text-orange-900 font-medium flex items-center">
                 <span class="text-xl mr-2">🤝</span> Price Negotiation
               </h3>
               <p class="text-orange-800 mt-1">
                 <span v-if="activeNegotiation.proposer_id === currentUserId">You offered </span>
                 <span v-else>Offered </span>
                 <span class="font-bold">{{ formatCurrency(activeNegotiation.proposed_price) }}</span> per unit.
                 (Original: {{ formatCurrency(order.rice_product.price_per_unit) }})
               </p>
               <p v-if="activeNegotiation.proposer_id === currentUserId" class="text-sm text-orange-700 mt-2">
                 Waiting for response...
               </p>
               <div v-else class="mt-3 flex gap-2">
                 <button 
                   @click="acceptNegotiationProposal(activeNegotiation)"
                   class="bg-green-600 text-white text-xs px-2 py-1 rounded hover:bg-green-700"
                 >
                   Accept
                 </button>
                 <button 
                   @click="openCounterModal(activeNegotiation)"
                   class="bg-blue-600 text-white text-xs px-2 py-1 rounded hover:bg-blue-700"
                 >
                   Counter
                 </button>
                 <button 
                   @click="rejectNegotiationProposal(activeNegotiation)"
                   class="bg-red-600 text-white text-xs px-2 py-1 rounded hover:bg-red-700"
                 >
                   Reject
                 </button>
               </div>
             </div>
            
            <!-- Progress Steps -->
            <div class="flex items-center justify-between">
              <div
                v-for="(step, index) in orderSteps"
                :key="step"
                class="flex flex-col items-center"
              >
                <div
                  :class="getStepClass(index)"
                  class="w-8 h-8 rounded-full flex items-center justify-center text-sm font-medium mb-2"
                >
                  {{ index + 1 }}
                </div>
                <span class="text-xs text-gray-600 text-center">
                  {{ getStepLabel(step) }}
                </span>
              </div>
            </div>
          </div>

          <!-- Order Items -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold mb-4">Order Items</h2>
            <div class="space-y-4">
              <div
                v-for="item in lineItems"
                :key="item.id"
                class="flex items-center space-x-4 p-4 border border-gray-200 rounded-lg"
              >
                <div class="w-16 h-16 bg-gray-100 rounded-lg flex items-center justify-center overflow-hidden">
                  <img 
                    v-if="order.rice_product?.images?.[0]" 
                    :src="order.rice_product.images[0]" 
                    :alt="order.rice_product?.name"
                    class="w-full h-full object-cover"
                  />
                  <span v-else class="text-gray-500 text-2xl">🌾</span>
                </div>
                <div class="flex-1">
                  <h3 class="font-medium text-gray-900">{{ item.name }}</h3>
                  <p class="text-sm text-gray-600">{{ item.description }}</p>
                  <div class="flex items-center space-x-4 mt-2 text-sm text-gray-600">
                    <span>Farmer: {{ item.farmer || 'Pending assignment' }}</span>
                    <span v-if="item.location">•</span>
                    <span v-if="item.location">{{ item.location }}</span>
                  </div>
                </div>
                <div class="text-right">
                  <div class="font-medium">{{ formatCurrency(item.price) }}</div>
                  <div class="text-sm text-gray-600">Qty: {{ item.quantity }}</div>
                  <div class="font-medium text-green-600">
                    {{ formatCurrency(item.price * item.quantity) }}
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Pickup Location -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold mb-4">Pickup Location</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <h3 class="font-medium text-gray-900 mb-2">Pickup Address</h3>
                <div class="text-gray-600 space-y-1">
                  <div>Managok, Malaybalay City</div>
                  <div>Bukidnon, Philippines</div>
                  <div class="mt-2">
                    <span class="font-medium">📞 Phone:</span> 0917-123-4567
                  </div>
                </div>
              </div>
              <div>
                <h3 class="font-medium text-gray-900 mb-2">Pickup Details</h3>
                <div class="space-y-2 text-gray-600">
                  <div class="flex gap-2">
                    <span>Method:</span>
                    <span>{{ order.delivery_method || 'pickup' }}</span>
                  </div>
                  <!-- Preferred Pickup Date (buyer's request) -->
                  <div v-if="order.preferred_pickup_date" class="flex justify-between">
                    <span>Preferred Date:</span>
                    <span>{{ formatDate(order.preferred_pickup_date) }}</span>
                  </div>
                  <!-- Confirmed Pickup Date (farmer confirmed) -->
                  <div v-if="order.confirmed_pickup_date" class="flex justify-between bg-green-50 p-2 rounded-md border border-green-200">
                    <span class="text-green-700 font-medium">📅 Scheduled Pickup:</span>
                    <span class="text-green-700 font-medium">{{ formatDate(order.confirmed_pickup_date) }}</span>
                  </div>
                  <div v-if="order.tracking_number" class="flex justify-between">
                    <span>Tracking:</span>
                    <span class="font-mono">{{ order.tracking_number }}</span>
                  </div>
                  <div v-if="order.available_date" class="flex justify-between">
                    <span>Available:</span>
                    <span>{{ formatDate(order.available_date) }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Order Timeline -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold mb-4">Order Timeline</h2>
            <div v-if="orderTimeline.length" class="space-y-4">
              <div
                v-for="event in orderTimeline"
                :key="event.id"
                class="flex items-start space-x-3"
              >
                <div class="flex-shrink-0">
                  <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                    <span class="text-blue-600 text-sm">{{ event.type === 'cancelled' ? '❌' : '🗓️' }}</span>
                  </div>
                </div>
                <div class="flex-1">
                  <div class="font-medium text-gray-900">{{ event.title }}</div>
                  <div class="text-sm text-gray-600">{{ event.description }}</div>
                  <div class="text-xs text-gray-500 mt-1">{{ formatDateTime(event.date) }}</div>
                </div>
              </div>
            </div>
            <p v-else class="text-sm text-gray-500">Status updates will appear here.</p>
          </div>

          <!-- Order Messages & Negotiations -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex items-center justify-between mb-4">
              <h2 class="text-xl font-semibold">Messages & Negotiations</h2>
              <div class="flex space-x-2">
                <button
                  v-if="canNegotiate"
                  @click="showProposeModal = true"
                  class="text-sm bg-orange-500 text-white px-3 py-1 rounded-md hover:bg-orange-600"
                  type="button"
                >
                  💰 Propose Price
                </button>
                <button
                  @click="loadMessages"
                  class="text-sm text-green-600 hover:text-green-700"
                  type="button"
                >
                  Refresh
                </button>
              </div>
            </div>

            <div v-if="messagesLoading" class="text-sm text-gray-500">Loading messages…</div>
            <div
              v-else
              class="mb-4 max-h-80 space-y-3 overflow-y-auto rounded border border-gray-100 bg-gray-50 p-3"
            >
              <div v-if="!chatTimeline.length" class="text-sm text-gray-500">
                No messages yet. Start the conversation to coordinate pickup or delivery.
              </div>

              <!-- Timeline: Messages + Negotiations -->
              <template v-for="item in chatTimeline" :key="item.id + '-' + item.type">
                <!-- Regular Message -->
                <div
                  v-if="item.type === 'message'"
                  class="max-w-md rounded-lg px-4 py-3 text-sm"
                  :class="item.sender_id == currentUserId ? 'ml-auto bg-green-100 text-right' : 'mr-auto bg-white text-left border border-gray-200'"
                >
                  <div class="text-xs text-gray-500">
                    {{ item.sender?.name || 'Participant' }} • {{ formatDateTime(item.created_at) }}
                  </div>
                  <div class="mt-2 text-gray-800 whitespace-pre-line">{{ item.message }}</div>
                </div>

                <!-- Negotiation Proposal -->
                <div
                  v-else-if="item.type === 'negotiation'"
                  class="mx-auto max-w-sm rounded-lg border-2 p-4 text-center"
                  :class="getNegotiationCardClass(item)"
                >
                  <div class="text-xs text-gray-500 mb-2">
                    {{ item.proposer?.name || 'Someone' }} • {{ formatDateTime(item.created_at) }}
                  </div>
                  <div class="text-lg font-bold text-gray-900 mb-1">
                    💰 Price Proposal
                  </div>
                  <div class="text-2xl font-bold mb-2" :class="item.status === 'accepted' ? 'text-green-600' : item.status === 'rejected' ? 'text-red-600' : 'text-orange-600'">
                    {{ formatCurrency(item.proposed_price) }} <span class="text-sm font-normal text-gray-500">/ unit</span>
                  </div>
                  
                  <!-- Status Badge -->
                  <div v-if="item.status !== 'pending'" class="mb-2">
                    <span
                      class="px-2 py-1 text-xs font-medium rounded-full"
                      :class="{
                        'bg-green-100 text-green-800': item.status === 'accepted',
                        'bg-red-100 text-red-800': item.status === 'rejected',
                        'bg-gray-100 text-gray-600': item.status === 'superseded'
                      }"
                    >
                      {{ item.status === 'superseded' ? 'Superseded' : item.status.charAt(0).toUpperCase() + item.status.slice(1) }}
                    </span>
                    <div v-if="item.response_message" class="text-xs text-gray-500 mt-1 italic">
                      "{{ item.response_message }}"
                    </div>
                  </div>

                  <!-- Action Buttons (only for pending proposals not from current user) -->
                  <div v-if="item.status === 'pending' && item.proposer_id !== currentUserId" class="flex justify-center space-x-2 mt-3">
                    <button
                      @click="acceptNegotiationProposal(item)"
                      :disabled="negotiationProcessing"
                      class="bg-green-600 text-white px-3 py-1 text-sm rounded-md hover:bg-green-700 disabled:opacity-50"
                    >
                      ✓ Accept
                    </button>
                    <button
                      @click="openCounterModal(item)"
                      :disabled="negotiationProcessing"
                      class="bg-blue-600 text-white px-3 py-1 text-sm rounded-md hover:bg-blue-700 disabled:opacity-50"
                    >
                      🔄 Counter
                    </button>
                    <button
                      @click="rejectNegotiationProposal(item)"
                      :disabled="negotiationProcessing"
                      class="bg-red-600 text-white px-3 py-1 text-sm rounded-md hover:bg-red-700 disabled:opacity-50"
                    >
                      ✕ Reject
                    </button>
                  </div>

                  <!-- Waiting indicator for own proposals -->
                  <div v-else-if="item.status === 'pending' && item.proposer_id === currentUserId" class="text-xs text-orange-600 mt-2">
                    ⏳ Waiting for response...
                  </div>
                </div>
              </template>
            </div>

            <form @submit.prevent="sendMessage" class="space-y-3">
              <textarea
                id="order-message-input"
                v-model="messageInput"
                rows="3"
                class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-1 focus:ring-green-500"
                placeholder="Share updates or ask a question"
              ></textarea>
              <div class="flex items-center justify-between">
                <span v-if="messageError" class="text-sm text-red-600">{{ messageError }}</span>
                <button
                  type="submit"
                  :disabled="sendingMessage || !messageInput.trim()"
                  class="rounded-md bg-green-600 px-4 py-2 text-sm font-medium text-white disabled:cursor-not-allowed disabled:opacity-50"
                >
                  {{ sendingMessage ? 'Sending…' : 'Send Message' }}
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Sidebar -->
        <div class="lg:col-span-1 space-y-6">
          <!-- Order Summary -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold mb-4">Order Summary</h3>
              <div class="space-y-3">
              <div class="flex justify-between">
                <span class="text-gray-600">Subtotal:</span>
                <span class="font-medium">{{ formatCurrency(orderSubtotal) }}</span>
              </div>
              <div class="border-t border-gray-200 pt-3">
                <div class="flex justify-between text-lg font-bold">
                  <span>Total:</span>
                  <span>{{ formatCurrency(order.total_amount || orderSubtotal) }}</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Payment Information -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold mb-4">Payment Information</h3>
            <div class="space-y-3">
              <div class="flex justify-between">
                <span class="text-gray-600">Payment Method:</span>
                <span class="font-medium">{{ order.payment_method || 'To be arranged' }}</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Payment Status:</span>
                <span
                  :class="getPaymentStatusColor(order)"
                  class="font-medium"
                >
                  {{ getPaymentStatusLabel(order) }}
                </span>
              </div>
            </div>
          </div>

          <!-- Quick Actions -->
          <div class="bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold mb-4">Quick Actions</h3>
            <div class="space-y-3">
              <!-- Buyer Actions -->
              <button
                v-if="!isFarmer"
                @click="contactSeller"
                class="w-full text-left px-3 py-2 text-sm text-gray-700 hover:bg-gray-100 rounded-md"
              >
                💬 Contact Seller
              </button>
              
              <!-- Farmer Actions -->
              <template v-if="isFarmer">
                <button
                  v-if="order.status === 'pending'"
                  @click="confirmOrder"
                  :disabled="processing"
                  class="w-full bg-green-600 text-white px-3 py-2 rounded-md hover:bg-green-700 disabled:opacity-50 text-sm font-medium"
                >
                  {{ processing ? 'Processing...' : '✓ Confirm Order' }}
                </button>
                <button
                  v-if="order.status === 'confirmed'"
                  @click="markReadyForPickup"
                  :disabled="processing"
                  class="w-full bg-purple-600 text-white px-3 py-2 rounded-md hover:bg-purple-700 disabled:opacity-50 text-sm font-medium"
                >
                  {{ processing ? 'Processing...' : '📦 Mark Ready for Pickup' }}
                </button>
                <button
                  v-if="order.status === 'ready_for_pickup'"
                  @click="confirmPickup"
                  :disabled="processing"
                  class="w-full bg-green-600 text-white px-3 py-2 rounded-md hover:bg-green-700 disabled:opacity-50 text-sm font-medium"
                >
                  {{ processing ? 'Processing...' : '✓ Confirm Pickup' }}
                </button>
                <button
                  v-if="order.payment_status !== 'paid' && isFarmer && !['cancelled', 'refunded'].includes(order.status)"
                  @click="markAsPaid"
                  :disabled="processing"
                  class="w-full bg-emerald-600 text-white px-3 py-2 rounded-md hover:bg-emerald-700 disabled:opacity-50 text-sm font-medium"
                >
                  💵 Mark as Paid
                </button>
                <!--- Negotiation Actions (Farmer) -->
                <div v-if="order.status === 'negotiating' && activeNegotiation && activeNegotiation.proposer_id !== currentUserId" class="grid grid-cols-2 gap-2">
                   <button
                    @click="acceptNegotiationProposal(activeNegotiation)"
                    :disabled="processing"
                    class="bg-green-600 text-white px-3 py-2 rounded-md hover:bg-green-700 disabled:opacity-50 text-sm font-medium"
                  >
                    ✓ Accept Offer
                  </button>
                  <button
                    @click="rejectNegotiationProposal(activeNegotiation)"
                    :disabled="processing"
                    class="bg-red-600 text-white px-3 py-2 rounded-md hover:bg-red-700 disabled:opacity-50 text-sm font-medium"
                  >
                    ✕ Reject
                  </button>
                </div>
                <button
                  v-if="order.status === 'pending'"
                  @click="showRejectModal = true"
                  :disabled="processing"
                  class="w-full bg-red-600 text-white px-3 py-2 rounded-md hover:bg-red-700 disabled:opacity-50 text-sm font-medium"
                >
                  ✕ Reject Order
                </button>
                <button
                  @click="contactBuyer"
                  class="w-full text-left px-3 py-2 text-sm text-gray-700 hover:bg-gray-100 rounded-md"
                >
                  💬 Contact Buyer
                </button>
              </template>
            </div>
          </div>
        </div>
      </div>
      </div>

      <!-- Cancel Order Modal (for buyer) -->
      <div
        v-if="showCancelModal && !isFarmer"
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
        @click.self="showCancelModal = false"
      >
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
          <h3 class="text-xl font-semibold mb-4">Cancel Order</h3>
          <p class="text-gray-600 mb-4">
            Are you sure you want to cancel Order #{{ order?.id }}?
          </p>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Cancellation Reason (required)
            </label>
            <textarea
              v-model="cancelReason"
              rows="4"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500"
              placeholder="Enter reason for cancellation..."
            ></textarea>
          </div>
          <div class="flex space-x-3">
            <button
              @click="cancelOrder"
              :disabled="!cancelReason.trim() || processing"
              class="flex-1 bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 disabled:opacity-50"
            >
              {{ processing ? 'Processing...' : 'Confirm Cancel' }}
            </button>
            <button
              @click="showCancelModal = false; cancelReason = ''"
              class="flex-1 bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>

      <!-- Reject Order Modal (for farmer) -->
      <div
        v-if="showRejectModal && isFarmer"
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
        @click.self="showRejectModal = false"
      >
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
          <h3 class="text-xl font-semibold mb-4">Reject Order</h3>
          <p class="text-gray-600 mb-4">
            Are you sure you want to reject Order #{{ order?.id }}?
          </p>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Rejection Reason (optional)
            </label>
            <textarea
              v-model="rejectReason"
              rows="4"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500"
              placeholder="Enter reason for rejection..."
            ></textarea>
          </div>
          <div class="flex space-x-3">
            <button
              @click="rejectOrder"
              :disabled="processing"
              class="flex-1 bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 disabled:opacity-50"
            >
              {{ processing ? 'Processing...' : 'Confirm Reject' }}
            </button>
            <button
              @click="showRejectModal = false; rejectReason = ''"
              class="flex-1 bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>

      <!-- Propose Price Modal -->
      <div
        v-if="showProposeModal"
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
        @click.self="showProposeModal = false"
      >
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
          <h3 class="text-xl font-semibold mb-4">💰 Propose a Price</h3>
          <p class="text-gray-600 mb-4">
            Current price: <span class="font-bold">{{ formatCurrency(order?.unit_price || order?.rice_product?.price_per_unit) }}</span> per unit
          </p>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Your Proposed Price (per unit)
            </label>
            <input
              v-model="proposedPrice"
              type="number"
              step="0.01"
              min="0.01"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500"
              placeholder="Enter your price"
            />
          </div>
          <div class="flex space-x-3">
            <button
              @click="submitProposal"
              :disabled="!proposedPrice || negotiationProcessing"
              class="flex-1 bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 disabled:opacity-50"
            >
              {{ negotiationProcessing ? 'Submitting...' : 'Submit Proposal' }}
            </button>
            <button
              @click="showProposeModal = false; proposedPrice = ''"
              class="flex-1 bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>

      <!-- Counter-Offer Modal -->
      <div
        v-if="showCounterModal && selectedNegotiation"
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
        @click.self="showCounterModal = false"
      >
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
          <h3 class="text-xl font-semibold mb-4">🔄 Counter-Offer</h3>
          <p class="text-gray-600 mb-4">
            Their offer: <span class="font-bold">{{ formatCurrency(selectedNegotiation.proposed_price) }}</span> per unit
          </p>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Your Counter Price (per unit)
            </label>
            <input
              v-model="counterPrice"
              type="number"
              step="0.01"
              min="0.01"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Enter your counter price"
            />
          </div>
          <div class="flex space-x-3">
            <button
              @click="submitCounter"
              :disabled="!counterPrice || negotiationProcessing"
              class="flex-1 bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 disabled:opacity-50"
            >
              {{ negotiationProcessing ? 'Submitting...' : 'Submit Counter' }}
            </button>
            <button
              @click="showCounterModal = false; counterPrice = ''; selectedNegotiation = null"
              class="flex-1 bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { formatCurrency } from '@/utils/format'
import { riceMarketplaceAPI } from '@/services/api'
import axios from 'axios'
import { useAuthStore } from '@/stores/auth'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const order = ref(null)
const loading = ref(true)
const error = ref('')

const isFarmer = computed(() => authStore.user?.role === 'farmer')
const ordersListRoute = computed(() => (isFarmer.value ? '/marketplace/orders' : '/orders'))

const orderSteps = ['pending', 'confirmed', 'ready_for_pickup', 'picked_up']

const lineItems = computed(() => {
  if (!order.value?.rice_product) return []
  return [
    {
      id: order.value.rice_product.id,
      name: order.value.rice_product.name,
      description: order.value.rice_product.description,
      quantity: order.value.quantity,
      price: order.value.unit_price,
      farmer: order.value.rice_product.farmer?.name,
      location: order.value.rice_product.farmer?.address?.city,
    },
  ]
})

const orderSubtotal = computed(() => {
  if (!order.value) return 0
  return (order.value.unit_price || 0) * (order.value.quantity || 0)
})

const deliveryAddress = computed(() => order.value?.delivery_address || {})
const currentUserId = computed(() => authStore.user?.id)

const messages = ref([])
const messagesLoading = ref(false)
const sendingMessage = ref(false)
const messageInput = ref('')
const messageError = ref('')
const processing = ref(false)
const showCancelModal = ref(false)
const showRejectModal = ref(false)
const cancelReason = ref('')
const rejectReason = ref('')

// Negotiation state
const negotiations = ref([])
const showProposeModal = ref(false)
const showCounterModal = ref(false)
const proposedPrice = ref('')
const counterPrice = ref('')
const selectedNegotiation = ref(null)
const negotiationProcessing = ref(false)

// Computed: Active Negotiation
const activeNegotiation = computed(() => {
  return negotiations.value
    .filter(n => n.status === 'pending')
    .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))[0]
})

// Computed: Can user negotiate on this order?
const canNegotiate = computed(() => {
  if (!order.value) return false
  // Allow negotiation for pending or negotiating orders
  return ['pending', 'negotiating'].includes(order.value.status)
})

// Computed: Combined timeline of messages and negotiations
const chatTimeline = computed(() => {
  const timeline = []
  
  // Add messages with type marker
  messages.value.forEach(msg => {
    timeline.push({ ...msg, type: 'message' })
  })
  
  // Add negotiations with type marker  
  negotiations.value.forEach(neg => {
    timeline.push({ ...neg, type: 'negotiation' })
  })
  
  // Sort by created_at ascending
  timeline.sort((a, b) => new Date(a.created_at) - new Date(b.created_at))
  
  return timeline
})

// Helper: Get negotiation card styling
const getNegotiationCardClass = (negotiation) => {
  switch (negotiation.status) {
    case 'accepted':
      return 'border-green-300 bg-green-50'
    case 'rejected':
      return 'border-red-300 bg-red-50'
    case 'superseded':
      return 'border-gray-300 bg-gray-50 opacity-60'
    default:
      return 'border-orange-300 bg-orange-50'
  }
}

// Load negotiations for the order
const loadNegotiations = async () => {
  if (!order.value) return
  try {
    const response = await riceMarketplaceAPI.getNegotiations(order.value.id)
    negotiations.value = response.data.negotiations || []
  } catch (err) {
    console.error('Failed to load negotiations:', err)
  }
}

// Submit a new price proposal
const submitProposal = async () => {
  if (!proposedPrice.value || !order.value) return
  
  negotiationProcessing.value = true
  try {
    await riceMarketplaceAPI.proposeNegotiation(order.value.id, parseFloat(proposedPrice.value))
    showProposeModal.value = false
    proposedPrice.value = ''
    await loadOrderData(order.value.id)
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to submit proposal')
  } finally {
    negotiationProcessing.value = false
  }
}

// Accept a negotiation proposal
const acceptNegotiationProposal = async (negotiation) => {
  if (!confirm(`Accept the price of ${formatCurrency(negotiation.proposed_price)} per unit?`)) return
  
  negotiationProcessing.value = true
  try {
    await riceMarketplaceAPI.respondToNegotiation(negotiation.id, 'accept')
    await loadOrderData(order.value.id)
    alert('Price accepted! The order price has been updated.')
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to accept proposal')
  } finally {
    negotiationProcessing.value = false
  }
}

// Reject a negotiation proposal
const rejectNegotiationProposal = async (negotiation) => {
  if (!confirm('Reject this price proposal?')) return
  
  negotiationProcessing.value = true
  try {
    await riceMarketplaceAPI.respondToNegotiation(negotiation.id, 'reject')
    await loadOrderData(order.value.id)
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to reject proposal')
  } finally {
    negotiationProcessing.value = false
  }
}

// Open counter-offer modal
const openCounterModal = (negotiation) => {
  selectedNegotiation.value = negotiation
  counterPrice.value = ''
  showCounterModal.value = true
}

// Submit counter-offer
const submitCounter = async () => {
  if (!counterPrice.value || !selectedNegotiation.value) return
  
  negotiationProcessing.value = true
  try {
    await riceMarketplaceAPI.respondToNegotiation(
      selectedNegotiation.value.id, 
      'counter', 
      parseFloat(counterPrice.value)
    )
    showCounterModal.value = false
    counterPrice.value = ''
    selectedNegotiation.value = null
    await loadOrderData(order.value.id)
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to submit counter-offer')
  } finally {
    negotiationProcessing.value = false
  }
}

const getStatusBadgeClass = (status) => {
  const classes = {
    pending: 'bg-yellow-100 text-yellow-800',
    confirmed: 'bg-blue-100 text-blue-800',
    ready_for_pickup: 'bg-purple-100 text-purple-800',
    picked_up: 'bg-green-100 text-green-800',
    picked_up: 'bg-green-100 text-green-800',
    cancelled: 'bg-red-100 text-red-800',
    negotiating: 'bg-orange-100 text-orange-800',
  }
  return classes[status] || 'bg-gray-100 text-gray-800'
}

const getCurrentStepIndex = () => {
  if (!order.value?.status) return 0
  const statusOrder = ['pending', 'confirmed', 'ready_for_pickup', 'picked_up']
  const idx = statusOrder.indexOf(order.value.status)
  return idx >= 0 ? idx : 0
}

const getStepClass = (index) => {
  const currentStep = getCurrentStepIndex()
  if (index < currentStep) return 'bg-green-600 text-white'
  if (index === currentStep) return 'bg-blue-600 text-white'
  return 'bg-gray-200 text-gray-600'
}

const getStepLabel = (step) => {
  const labels = {
    pending: 'Pending',
    confirmed: 'Confirmed',
    ready_for_pickup: 'Ready for Pickup',
    picked_up: 'Picked Up'
  }
  return labels[step] || step
}

const formatDate = (date) => {
  if (!date) return 'N/A'
  return new Date(date).toLocaleDateString()
}

const formatDateTime = (date) => {
  if (!date) return 'N/A'
  return new Date(date).toLocaleString()
}

const formatStatus = (status) => {
  if (!status) return ''
  const labels = {
    negotiating: 'Negotiating',
    pending: 'Pending',
    confirmed: 'Confirmed',
    ready_for_pickup: 'Ready for Pickup',
    picked_up: 'Picked Up',
    cancelled: 'Cancelled',
    disputed: 'Disputed'
  }
  return labels[status] || status.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ')
}

const getPaymentStatusLabel = (order) => {
  if (order.payment_status === 'paid') return 'Paid'
  if (order.status === 'cancelled') return 'Cancelled'
  return formatStatus(order.payment_status || 'pending')
}

const getPaymentStatusColor = (order) => {
  if (order.payment_status === 'paid') return 'text-green-600'
  if (order.status === 'cancelled') return 'text-red-600'
  return 'text-yellow-600'
}

const orderTimeline = computed(() => {
  if (!order.value) return []
  const events = [
    {
      id: 'placed',
      type: 'ordered',
      title: 'Order Placed',
      description: 'Order created by buyer',
      date: order.value.order_date || order.value.created_at,
    },
  ]

  if (['confirmed', 'ready_for_pickup', 'picked_up'].includes(order.value.status)) {
    events.push({
      id: 'confirmed',
      type: 'processing',
      title: 'Order Confirmed',
      description: 'Farmer confirmed the order',
      date: order.value.updated_at,
    })
  }

  if (['ready_for_pickup', 'picked_up'].includes(order.value.status)) {
    events.push({
      id: 'ready',
      type: 'ready',
      title: 'Ready for Pickup',
      description: 'Order is ready to be picked up',
      date: order.value.updated_at,
    })
  }

  if (order.value.status === 'picked_up') {
    events.push({
      id: 'picked_up',
      type: 'delivered',
      title: 'Order Picked Up',
      description: 'Buyer picked up the order',
      date: order.value.actual_delivery_date || order.value.updated_at,
    })
  }

  if (order.value.status === 'cancelled') {
    events.push({
      id: 'cancelled',
      type: 'cancelled',
      title: 'Order Cancelled',
      description: 'Order was cancelled',
      date: order.value.updated_at,
    })
  }

  return events
})

const contactSeller = () => {
  const input = document.getElementById('order-message-input')
  if (input) {
    input.focus()
  }
}

const contactBuyer = () => {
  const input = document.getElementById('order-message-input')
  if (input) {
    input.focus()
  }
}

const confirmOrder = async () => {
  if (!confirm('Are you sure you want to confirm this order?')) return
  
  processing.value = true
  try {
    await riceMarketplaceAPI.confirmOrder(order.value.id)
    await loadOrderData(order.value.id)
    alert('Order confirmed successfully')
  } catch (err) {
    alert(err.userMessage || err.response?.data?.message || 'Failed to confirm order')
  } finally {
    processing.value = false
  }
}

const markReadyForPickup = async () => {
  if (!confirm('Mark this order as ready for pickup?')) return
  
  processing.value = true
  try {
    await riceMarketplaceAPI.markReadyForPickup(order.value.id)
    await loadOrderData(order.value.id)
    alert('Order marked as ready for pickup')
  } catch (err) {
    alert(err.userMessage || err.response?.data?.message || 'Failed to update order')
  } finally {
    processing.value = false
  }
}

const confirmPickup = async () => {
  if (!confirm('Confirm that the order has been picked up?')) return
  
  processing.value = true
  try {
    await riceMarketplaceAPI.confirmPickup(order.value.id)
    await loadOrderData(order.value.id)
    alert('Order pickup confirmed')
  } catch (err) {
    alert(err.userMessage || err.response?.data?.message || 'Failed to update order')
  } finally {
    processing.value = false
  }
}

const markAsPaid = async () => {
  if (!confirm('Mark this order as paid?')) return
  
  processing.value = true
  try {
    await riceMarketplaceAPI.markOrderAsPaid(order.value.id)
    await loadOrderData(order.value.id)
    alert('Order marked as paid')
  } catch (err) {
    alert(err.userMessage || err.response?.data?.message || 'Failed to update payment status')
  } finally {
    processing.value = false
  }
}





const cancelOrder = async () => {
  if (!cancelReason.value.trim()) {
    alert('Please provide a reason for cancellation')
    return
  }

  processing.value = true
  try {
    await riceMarketplaceAPI.cancelOrder(order.value.id, {
      reason: cancelReason.value.trim()
    })
    showCancelModal.value = false
    cancelReason.value = ''
    await loadOrderData(order.value.id)
    alert('Order cancelled successfully')
  } catch (err) {
    alert(err.userMessage || err.response?.data?.message || 'Failed to cancel order')
  } finally {
    processing.value = false
  }
}

const rejectOrder = async () => {
  processing.value = true
  try {
    await axios.post(`/api/rice-marketplace/orders/${order.value.id}/reject`, {
      reason: rejectReason.value.trim() || 'Rejected by farmer'
    })
    showRejectModal.value = false
    rejectReason.value = ''
    await loadOrderData(order.value.id)
    alert('Order rejected successfully')
  } catch (err) {
    alert(err.userMessage || err.response?.data?.message || 'Failed to reject order')
  } finally {
    processing.value = false
  }
}

const printOrder = () => {
  window.print()
}

const loadOrderData = async (id) => {
  loading.value = true
  error.value = ''
  try {
    const response = await riceMarketplaceAPI.getOrderById(id)
    order.value = response.data.order
    await loadMessages()
  } catch (err) {
    error.value = err.userMessage || err.response?.data?.message || 'Failed to load order'
  } finally {
    loading.value = false
  }
}

const loadMessages = async () => {
  if (!order.value) return
  messagesLoading.value = true
  messageError.value = ''
  try {
    const response = await riceMarketplaceAPI.getOrderMessages(order.value.id)
    // Sort messages: Oldest at the top, Newest at the bottom
    messages.value = (response.data.messages || []).sort((a, b) => new Date(a.created_at) - new Date(b.created_at))
    // Also load negotiations
    await loadNegotiations()
    scrollToBottom()
  } catch (err) {
    messageError.value = err.userMessage || err.response?.data?.message || 'Failed to load messages'
  } finally {
    messagesLoading.value = false
  }
}

const scrollToBottom = () => {
  setTimeout(() => {
    const container = document.querySelector('.max-h-80.overflow-y-auto')
    if (container) {
      container.scrollTop = container.scrollHeight
    }
  }, 100)
}

const sendMessage = async () => {
  if (!order.value || !messageInput.value.trim()) {
    return
  }

  sendingMessage.value = true
  messageError.value = ''
  try {
    const response = await riceMarketplaceAPI.sendOrderMessage(order.value.id, {
      message: messageInput.value.trim(),
    })
    messages.value.push(response.data.data)
    messageInput.value = ''
    scrollToBottom()
  } catch (err) {
    messageError.value = err.userMessage || err.response?.data?.message || 'Failed to send message'
  } finally {
    sendingMessage.value = false
  }
}

onMounted(() => {
  loadOrderData(route.params.id)
})
</script>

<style scoped>
.order-detail-page {
  min-height: 100vh;
  background-color: #f8fafc;
}
</style>