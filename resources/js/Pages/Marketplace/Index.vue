<template>
  <div class="min-h-screen bg-gray-50">
    <div class="container mx-auto px-4 py-8">
      <!-- Standard Header -->
      <div class="mb-8 flex items-start justify-between gap-4">
        <div class="min-w-0 flex-1">
          <h1 class="text-3xl font-bold text-gray-800">Rice Marketplace</h1>
          <p class="text-gray-500 mt-1">Browse and purchase premium rice products</p>
        </div>
        <div class="flex shrink-0 items-start justify-end gap-3">
          <!-- Only show cart for authenticated buyers -->
          <router-link 
            v-if="authStore.isAuthenticated && authStore.user?.role === 'buyer'"
            to="/cart"
            class="relative inline-flex h-11 w-11 items-center justify-center rounded-lg border border-gray-300 bg-white text-gray-500 transition-colors hover:text-gray-700"
          >
            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13l-1.5 4h13M9 21a1 1 0 100-2 1 1 0 000 2zm10 0a1 1 0 100-2 1 1 0 000 2z" />
            </svg>
            <span 
              v-if="marketplaceStore.cartItemsCount > 0"
              class="absolute -top-1 -right-1 h-5 w-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center"
            >
              {{ marketplaceStore.cartItemsCount }}
            </span>
          </router-link>
          <!-- Login button for guests -->
          <router-link
            v-if="!authStore.isAuthenticated"
            to="/login"
            class="inline-flex items-center rounded-lg bg-green-600 px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-green-700 sm:text-base"
          >
            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
            </svg>
            Login to Order
          </router-link>
        </div>
      </div>

      <div>
      <section class="mb-4 rounded-lg border border-gray-200 bg-white shadow-sm sm:mb-6">
        <div class="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <div class="px-4 pt-4 sm:px-5 sm:pt-5">
            <h2 class="text-base font-semibold text-gray-950">Rice Products</h2>
            <p class="text-sm text-gray-500">{{ productCountLabel }}</p>
          </div>
          <div class="flex gap-2 px-4 sm:px-5 sm:pt-5">
            <button
              type="button"
              class="inline-flex w-full items-center justify-center rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50 sm:w-auto"
              @click="filtersOpen = !filtersOpen"
            >
              <svg class="mr-2 h-4 w-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h18M6 12h12M10 20h4" />
              </svg>
              {{ filtersOpen ? 'Hide filters' : 'Show filters' }}
              <span v-if="activeFilterCount" class="ml-2 rounded-full bg-emerald-100 px-2 py-0.5 text-xs font-bold text-emerald-800">
                {{ activeFilterCount }}
              </span>
            </button>
          </div>
        </div>

        <div v-show="filtersOpen" class="border-t border-gray-100 px-4 pb-4 pt-4 sm:px-5 sm:pb-5">
        <div class="grid grid-cols-1 gap-4 md:grid-cols-12">
          <div class="md:col-span-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
            <div class="relative">
              <input
                v-model="filters.search"
                type="text"
                placeholder="Product, description, farmer..."
                class="w-full rounded-md border border-gray-300 py-2 pl-10 pr-4 focus:border-green-500 focus:outline-none focus:ring-green-500"
                @input="debounceLoadProducts"
              />
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
              </div>
            </div>
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
            <select
              v-model="filters.production_status"
              class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-green-500"
              @change="loadProducts()"
            >
              <option value="">All Statuses</option>
              <option v-for="(label, value) in filterOptions.production_statuses" :key="value" :value="value">
                {{ label }}
              </option>
            </select>
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Rice Variety</label>
            <select
              v-model="filters.variety_id"
              class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-green-500"
              @change="loadProducts()"
            >
              <option value="">All Varieties</option>
              <option v-for="variety in filterOptions.varieties" :key="variety.id" :value="variety.id">
                {{ variety.name }}
              </option>
            </select>
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Quality Grade</label>
            <select
              v-model="filters.quality_grade"
              class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-green-500"
              @change="loadProducts()"
            >
              <option value="">All Grades</option>
              <option v-for="(label, value) in filterOptions.grades" :key="value" :value="value">
                {{ label }}
              </option>
            </select>
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Sort By</label>
            <select
              v-model="filters.sort"
              class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-green-500"
              @change="loadProducts()"
            >
              <option value="created_at:desc">Newest</option>
              <option value="price:asc">Price: Low to High</option>
              <option value="price:desc">Price: High to Low</option>
              <option value="rating:desc">Highest Rated</option>
              <option value="available_from:asc">Available Soonest</option>
              <option value="quantity:desc">Most Stock</option>
            </select>
          </div>
        </div>

        <div class="mt-4 grid grid-cols-1 gap-4 md:grid-cols-12">
          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Min Price</label>
            <input
              v-model.number="filters.min_price"
              type="number"
              min="0"
              placeholder="₱ Min"
              class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-green-500"
              @change="loadProducts()"
            />
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Max Price</label>
            <input
              v-model.number="filters.max_price"
              type="number"
              min="0"
              placeholder="₱ Max"
              class="w-full rounded-md border border-gray-300 px-3 py-2 focus:border-green-500 focus:outline-none focus:ring-green-500"
              @change="loadProducts()"
            />
          </div>

          <div class="flex items-end md:col-span-3">
            <label class="flex min-h-10 items-center gap-2 rounded-md border border-gray-300 px-3 py-2 text-sm font-medium text-gray-700">
              <input
                v-model="filters.is_organic"
                type="checkbox"
                class="h-4 w-4 rounded border-gray-300 text-green-600 focus:ring-green-500"
                @change="loadProducts()"
              />
              Organic only
            </label>
          </div>

          <div class="flex items-end gap-2 md:col-span-5 md:justify-end">
            <button
              type="button"
              class="inline-flex w-full items-center justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50 md:w-auto"
              @click="clearFilters"
            >
              Reset filters
            </button>
          </div>
        </div>
        </div>
      </section>

      <!-- Products Grid -->
      <div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div v-for="n in 8" :key="n" class="bg-white rounded-lg shadow p-6 animate-pulse">
          <div class="h-48 bg-gray-200 rounded mb-4"></div>
          <div class="h-4 bg-gray-200 rounded mb-2"></div>
          <div class="h-4 bg-gray-200 rounded w-3/4"></div>
        </div>
      </div>

      <div v-else-if="products.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div 
          v-for="product in products" 
          :key="product.id"
          class="bg-white rounded-lg shadow hover:shadow-md transition-shadow cursor-pointer"
          @click="viewProduct(product)"
        >
          <div class="p-6">
            <!-- Product Image -->
            <div class="h-48 rounded-lg mb-4 overflow-hidden">
              <img 
                v-if="getProductImage(product)" 
                :src="getProductImage(product)" 
                :alt="product.name"
                class="w-full h-full object-cover"
                @error="handleImageError($event)"
              />
              <div v-else class="w-full h-full bg-gradient-to-br from-green-100 to-emerald-100 flex items-center justify-center">
                <svg class="h-20 w-20 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
              </div>
            </div>

            <!-- Product Info -->
            <div class="mb-4">
              <h3 class="text-base font-semibold text-gray-900 mb-2 break-words leading-snug">{{ product.name }}</h3>
              <p class="text-sm text-gray-600 mb-2 line-clamp-2 break-words">{{ product.description || 'Premium rice variety' }}</p>
              
              <!-- Farmer Info -->
              <div class="flex items-center text-sm text-gray-500 mb-2">
                <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
                {{ product.farmer?.name || 'Local Farmer' }}
              </div>

              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="text-xs font-medium px-2 py-1 rounded-full bg-green-100 text-green-800">
                  {{ formatGrade(product.quality_grade) }}
                </span>
                <span
                  class="text-xs font-medium px-2 py-1 rounded-full"
                  :class="getStatusClass(product.production_status)"
                >
                  {{ formatStatus(product.production_status) }}
                </span>
                <span v-if="product.is_organic" class="text-xs font-medium px-2 py-1 rounded-full bg-emerald-100 text-emerald-800">
                  Organic
                </span>
              </div>

              <p v-if="product.production_status === 'in_production' && product.available_from" class="text-xs text-gray-500">
                Available from {{ formatDate(product.available_from) }}
              </p>
            </div>

            <!-- Price and Availability -->
            <div class="flex flex-wrap justify-between items-baseline gap-x-2 gap-y-1 mb-4">
              <span class="text-lg font-bold text-green-600 break-all">
                {{ formatCurrency(product.price_per_unit) }}/{{ formatUnit(product.unit) || 'kg' }}
              </span>
              <span class="text-sm text-gray-500 whitespace-nowrap">
                <template v-if="product.production_status === 'in_production'">Pre-order</template>
                <template v-else>{{ product.quantity_available || 0 }} {{ formatUnit(product.unit) || 'kg' }} available</template>
              </span>
            </div>

            <!-- Actions -->
            <div class="space-y-2">
              <button 
                type="button"
                @click.stop="handlePrimaryProductAction(product)"
                :disabled="product.production_status !== 'in_production' && (!product.quantity_available || product.quantity_available <= 0)"
                class="w-full bg-green-600 text-white py-2 px-4 rounded-lg hover:bg-green-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {{ getPrimaryActionLabel(product) }}
              </button>
              <button 
                type="button"
                @click.stop="viewProduct(product)"
                class="w-full bg-gray-200 text-gray-700 py-2 px-4 rounded-lg hover:bg-gray-300 transition-colors"
              >
                View Details
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-else class="text-center py-12">
        <svg class="h-16 w-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
        </svg>
        <h3 class="text-lg font-medium text-gray-900 mb-2">No products found</h3>
        <p class="text-gray-600 mb-4">Try adjusting your search or filters</p>
        <button 
          type="button"
          @click="clearFilters"
          class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors"
        >
          Clear Filters
        </button>
      </div>

      <!-- Pagination -->
      <div v-if="pagination && pagination.total > pagination.per_page" class="mt-8 flex justify-center">
        <nav class="flex items-center space-x-2">
          <button 
            type="button"
            @click="loadProducts(pagination.current_page - 1)"
            :disabled="pagination.current_page === 1"
            class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Previous
          </button>
          
          <span class="px-3 py-2 text-sm font-medium text-gray-700">
            Page {{ pagination.current_page }} of {{ pagination.last_page }}
          </span>
          
          <button 
            type="button"
            @click="loadProducts(pagination.current_page + 1)"
            :disabled="pagination.current_page === pagination.last_page"
            class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Next
          </button>
        </nav>
      </div>
      </div>
    </div>

    <!-- Toast Notification -->
    <Transition name="toast">
      <div 
        v-if="toast.show" 
        class="fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-4 rounded-xl shadow-lg border"
        :class="{
          'bg-green-50 border-green-200 text-green-800': toast.type === 'success',
          'bg-red-50 border-red-200 text-red-800': toast.type === 'error'
        }"
      >
        <svg v-if="toast.type === 'success'" class="h-6 w-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <svg v-else class="h-6 w-6 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <span class="font-medium">{{ toast.message }}</span>
      </div>
    </Transition>

    <!-- Quantity Selection Modal -->
    <div v-if="showQuantityModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl max-w-md w-full p-6 shadow-2xl">
        <h3 class="text-xl font-bold text-gray-900 mb-4">Add to Cart</h3>
        
        <!-- Product Info -->
        <div class="flex gap-4 mb-6">
          <div class="h-16 w-16 rounded-lg flex items-center justify-center flex-shrink-0 overflow-hidden">
            <img 
              v-if="getProductImage(selectedProduct)" 
              :src="getProductImage(selectedProduct)" 
              :alt="selectedProduct?.name"
              class="w-full h-full object-cover"
            />
            <div v-else class="w-full h-full bg-gradient-to-br from-green-100 to-emerald-100 flex items-center justify-center">
              <svg class="h-8 w-8 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
              </svg>
            </div>
          </div>
          <div>
            <h4 class="font-semibold text-gray-900">{{ selectedProduct?.name }}</h4>
            <p class="text-green-600 font-medium">{{ formatCurrency(selectedProduct?.price_per_unit) }}/{{ formatUnit(selectedProduct?.unit) || 'kg' }}</p>
            <p class="text-sm text-gray-500">{{ selectedProduct?.quantity_available || 0 }} {{ formatUnit(selectedProduct?.unit) || 'kg' }} available</p>
          </div>
        </div>

        <!-- Quantity Selector -->
        <div class="mb-6">
          <label class="block text-sm font-medium text-gray-700 mb-2">Quantity ({{ formatUnit(selectedProduct?.unit) || 'kg' }})</label>
          <div class="flex items-center gap-4">
            <button 
              @click="selectedQuantity = Math.max(1, selectedQuantity - 1)"
              class="h-10 w-10 rounded-full border-2 border-gray-300 flex items-center justify-center hover:bg-gray-50 transition-colors text-xl font-medium"
            >−</button>
            <input 
              v-model.number="selectedQuantity" 
              type="number" 
              min="1" 
              :max="selectedProduct?.quantity_available || 100"
              class="w-24 text-center text-lg font-semibold border-2 border-gray-300 rounded-lg py-2 focus:border-green-500 focus:outline-none"
            />
            <button 
              @click="selectedQuantity = Math.min(selectedProduct?.quantity_available || 100, selectedQuantity + 1)"
              class="h-10 w-10 rounded-full border-2 border-gray-300 flex items-center justify-center hover:bg-gray-50 transition-colors text-xl font-medium"
            >+</button>
          </div>
          <p class="text-sm text-gray-500 mt-2">
            Subtotal: <span class="font-semibold text-gray-900">{{ formatCurrency((selectedProduct?.price_per_unit || 0) * selectedQuantity) }}</span>
          </p>
        </div>

        <!-- Actions -->
        <div class="flex gap-3">
          <button 
            @click="showQuantityModal = false"
            class="flex-1 px-4 py-3 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 font-medium transition-colors"
          >
            Cancel
          </button>
          <button 
            @click="confirmAddToCart"
            :disabled="isAddingToCart"
            class="flex-1 px-4 py-3 bg-green-600 text-white rounded-lg hover:bg-green-700 font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="isAddingToCart" class="flex items-center justify-center gap-2">
              <svg class="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Adding...
            </span>
            <span v-else>Add to Cart</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useMarketplaceStore } from '@/stores/marketplace';
import { useAuthStore } from '@/stores/auth';
import { formatCurrency, formatUnit } from '@/utils/format';

const router = useRouter();
const route = useRoute();
const marketplaceStore = useMarketplaceStore();
const authStore = useAuthStore();

const loading = ref(false);
const searchTimeout = ref(null);
const filtersOpen = ref(true);

const filters = ref({
  search: '',
  production_status: '',
  variety_id: '',
  quality_grade: '',
  min_price: null,
  max_price: null,
  is_organic: false,
  sort: 'created_at:desc',
});

const filterOptions = ref({
  varieties: [],
  grades: {
    premium: 'Premium',
    grade_a: 'Grade A',
    grade_b: 'Grade B',
    commercial: 'Commercial',
  },
  production_statuses: {
    available: 'Available',
    in_production: 'In Production',
  },
});

const products = computed(() => marketplaceStore.products || []);
const pagination = computed(() => marketplaceStore.productsPagination);
const productCountLabel = computed(() => {
  if (pagination.value?.total !== undefined) {
    return `${pagination.value.total} product${pagination.value.total === 1 ? '' : 's'}`;
  }

  return `${products.value.length} product${products.value.length === 1 ? '' : 's'}`;
});
const activeFilterCount = computed(() => {
  return [
    filters.value.search?.trim(),
    filters.value.production_status,
    filters.value.variety_id,
    filters.value.quality_grade,
    filters.value.min_price !== null && filters.value.min_price !== '',
    filters.value.max_price !== null && filters.value.max_price !== '',
    filters.value.is_organic,
    filters.value.sort !== 'created_at:desc',
  ].filter(Boolean).length;
});

// Toast notification state
const toast = ref({
  show: false,
  message: '',
  type: 'success'
});

// Quantity modal state
const showQuantityModal = ref(false);
const selectedProduct = ref(null);
const selectedQuantity = ref(1);
const isAddingToCart = ref(false);

const showToast = (message, type = 'success') => {
  toast.value = { show: true, message, type };
  setTimeout(() => {
    toast.value.show = false;
  }, 3000);
};

const buildProductParams = (page = 1) => {
  const [sortBy, sortOrder] = filters.value.sort.split(':');
  const params = {
    page,
    per_page: 12,
    sort_by: sortBy || 'created_at',
    sort_order: sortOrder || 'desc',
  };

  if (filters.value.search?.trim()) {
    params.search = filters.value.search.trim();
  }

  if (filters.value.production_status) {
    params.production_status = filters.value.production_status;
  }

  if (filters.value.variety_id) {
    params.variety_id = filters.value.variety_id;
  }

  if (filters.value.quality_grade) {
    params.quality_grade = filters.value.quality_grade;
  }

  if (filters.value.min_price !== null && filters.value.min_price !== '') {
    params.min_price = filters.value.min_price;
  }

  if (filters.value.max_price !== null && filters.value.max_price !== '') {
    params.max_price = filters.value.max_price;
  }

  if (filters.value.is_organic) {
    params.is_organic = 1;
  }

  return params;
};

const loadProducts = async (page = 1) => {
  loading.value = true;

  try {
    const response = await marketplaceStore.fetchProducts(buildProductParams(page));
    const options = response?.filters;

    if (options) {
      const buyerStatuses = Object.fromEntries(
        Object.entries(options.production_statuses || filterOptions.value.production_statuses)
          .filter(([value]) => ['available', 'in_production'].includes(value))
      );

      filterOptions.value = {
        varieties: options.varieties || [],
        grades: options.grades || filterOptions.value.grades,
        production_statuses: buyerStatuses,
      };
    }
  } catch (error) {
    console.error('Failed to load products:', error);
  } finally {
    loading.value = false;
  }
};

const debounceLoadProducts = () => {
  clearTimeout(searchTimeout.value);
  searchTimeout.value = setTimeout(() => {
    loadProducts(1);
  }, 400);
};

const addToCart = (product) => {
  // Check if user is authenticated
  if (!authStore.isAuthenticated) {
    // Redirect to login with return URL
    router.push({ path: '/login', query: { redirect: router.currentRoute.value.fullPath } });
    return;
  }
  selectedProduct.value = product;
  selectedQuantity.value = 1;
  showQuantityModal.value = true;
};

const handlePrimaryProductAction = (product) => {
  if (product.production_status === 'in_production') {
    viewProduct(product);
    return;
  }

  addToCart(product);
};

const confirmAddToCart = async () => {
  if (selectedProduct.value && selectedQuantity.value > 0 && !isAddingToCart.value) {
    isAddingToCart.value = true;
    try {
      // Use await to handle potential asynchronous store actions (e.g. backend sync)
      await marketplaceStore.addToCart(selectedProduct.value, selectedQuantity.value);
      showQuantityModal.value = false;
      showToast(`Added ${selectedQuantity.value} ${formatUnit(selectedProduct.value.unit) || 'kg'} of ${selectedProduct.value.name} to cart!`, 'success');
    } catch (err) {
      console.error('Failed to add to cart:', err);
      showToast(err.message || 'Failed to add item to cart. Please try again.', 'error');
    } finally {
      isAddingToCart.value = false;
    }
  }
};

const viewProduct = (product) => {
  router.push(`/marketplace/products/${product.id}`);
};

const clearFilters = () => {
  filters.value = {
    search: '',
    production_status: '',
    variety_id: '',
    quality_grade: '',
    min_price: null,
    max_price: null,
    is_organic: false,
    sort: 'created_at:desc',
  };
  loadProducts(1);
};

const formatGrade = (grade) => {
  return filterOptions.value.grades?.[grade] || 'Grade A';
};

const formatStatus = (status) => {
  return filterOptions.value.production_statuses?.[status] || 'Available';
};

const getStatusClass = (status) => {
  const classes = {
    available: 'bg-blue-100 text-blue-800',
    in_production: 'bg-amber-100 text-amber-800',
  };

  return classes[status] || 'bg-gray-100 text-gray-700';
};

const formatDate = (date) => {
  if (!date) return '';

  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
};

const getPrimaryActionLabel = (product) => {
  if (!authStore.isAuthenticated) return 'Login to Add';
  if (product.production_status === 'in_production') return 'Pre-order';
  if (!product.quantity_available || product.quantity_available <= 0) return 'Out of Stock';
  return 'Add to Cart';
};

onMounted(async () => {
  if (route.query.variety) {
    filters.value.variety_id = route.query.variety;
    filtersOpen.value = true;
  }

  await loadProducts();
});

const getProductImage = (product) => {
  // Check for images array (from API response)
  if (product.images && Array.isArray(product.images) && product.images.length > 0) {
    return product.images[0];
  }
  // Check for single image property
  if (product.image) {
    return product.image;
  }
  // Check for thumbnail
  if (product.thumbnail) {
    return product.thumbnail;
  }
  return null;
};

const handleImageError = (event) => {
  // Hide broken image and let v-else show the fallback
  event.target.style.display = 'none';
};
</script>

<style scoped>
.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}
.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateX(100px);
}
</style>
