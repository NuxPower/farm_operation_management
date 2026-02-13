<template>
  <div class="min-h-screen bg-gray-50/50 font-sans text-gray-900">
    <div class="container mx-auto px-4 py-8 max-w-7xl">
      <!-- Standard Header -->
      <div class="mb-8">
        <div class="mb-4">
          <button
            @click="router.push('/marketplace/my-products')"
            class="flex items-center text-sm text-gray-500 hover:text-gray-700 transition-colors"
          >
            <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            Back to My Products
          </button>
        </div>

        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
          <div>
            <h1 class="text-3xl font-bold text-gray-800">{{ product.name || 'Product Details' }}</h1>
            <p class="text-gray-500 mt-1">Manage your product listing details.</p>
          </div>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-emerald-600"></div>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="bg-red-50 border border-red-200 rounded-xl p-6 text-center">
        <svg class="mx-auto h-12 w-12 text-red-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        </svg>
        <h3 class="mt-2 text-sm font-medium text-red-800">Error Loading Product</h3>
        <p class="mt-1 text-sm text-red-500">{{ error }}</p>
        <div class="mt-6">
          <button @click="loadProduct" class="text-sm font-medium text-red-600 hover:text-red-500">
            Try again
          </button>
        </div>
      </div>

      <!-- Content -->
      <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Left Column: Images -->
        <div class="lg:col-span-1 space-y-6">
          <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden p-4">
             <div class="aspect-w-16 aspect-h-12 bg-gray-100 rounded-lg overflow-hidden mb-4 relative group">
                <img 
                  v-if="product.images && product.images.length > 0" 
                  :src="product.images[selectedImageIndex]" 
                  class="w-full h-full object-cover"
                  alt="Product Image"
                />
                <div v-else class="w-full h-full flex items-center justify-center bg-gray-50">
                  <span class="text-6xl">🌾</span>
                </div>
             </div>
             
             <!-- Thumbnails -->
             <div v-if="product.images && product.images.length > 1" class="flex gap-2 overflow-x-auto pb-2">
                <button
                  v-for="(image, index) in product.images"
                  :key="index"
                  @click="selectedImageIndex = index"
                  :class="[
                    'w-16 h-16 rounded-md overflow-hidden border-2 flex-shrink-0 transition-all',
                     selectedImageIndex === index ? 'border-emerald-500 ring-2 ring-emerald-100' : 'border-gray-200 hover:border-emerald-300'
                  ]"
                >
                  <img :src="image" class="w-full h-full object-cover" />
                </button>
             </div>
          </div>

          <!-- Status Card -->
          <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">Availability Status</h3>
            <div class="space-y-4">
               <div>
                  <span class="text-sm text-gray-500 block mb-1">Production Status</span>
                  <span 
                    :class="[
                      'inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-sm font-medium border',
                      product.production_status === 'available' ? 'bg-emerald-50 text-emerald-700 border-emerald-100' :
                      product.production_status === 'in_production' ? 'bg-blue-50 text-blue-700 border-blue-100' :
                      'bg-gray-50 text-gray-600 border-gray-200'
                    ]"
                  >
                    {{ formatStatus(product.production_status) }}
                  </span>
               </div>
               <div class="grid grid-cols-2 gap-4">
                  <div>
                    <span class="text-sm text-gray-500 block mb-1">Quantity</span>
                    <span class="text-lg font-semibold text-gray-900">{{ formatNumber(product.quantity_available) }}</span>
                    <span class="text-xs text-gray-500 ml-1">{{ product.unit }}</span>
                  </div>
                  <div>
                    <span class="text-sm text-gray-500 block mb-1">Price</span>
                    <span class="text-lg font-semibold text-gray-900">{{ formatCurrency(product.price_per_unit) }}</span>
                    <span class="text-xs text-gray-500 ml-1">/ {{ product.unit }}</span>
                  </div>
               </div>
            </div>
          </div>
        </div>

        <!-- Right Column: Details -->
        <div class="lg:col-span-2 space-y-6">
          <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="border-b border-gray-100 bg-gray-50/50 px-6 py-4 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
               <div>
                 <h1 class="text-2xl font-bold text-gray-900">{{ product.name }}</h1>
                 <p class="text-sm text-gray-500 mt-1">Listed on {{ formatDate(product.created_at) }}</p>
               </div>
               <div>
                 <button
                   @click="router.push(`/marketplace/product/${product.id}/edit`)"
                   class="inline-flex items-center gap-2 px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors shadow-sm text-sm font-medium"
                 >
                   <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                   Edit Product
                 </button>
               </div>
            </div>
            
            <div class="p-6 space-y-8">
              <!-- Description -->
              <div>
                <h3 class="text-lg font-semibold text-gray-900 mb-3">Description</h3>
                <div class="prose prose-emerald max-w-none text-gray-600">
                  <p class="whitespace-pre-line">{{ product.description }}</p>
                </div>
              </div>

              <!-- Product Attributes Grid -->
              <div>
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Product Specifications</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-y-6 gap-x-8 bg-gray-50 rounded-xl p-6 border border-gray-100">
                   <div class="flex flex-col">
                      <span class="text-xs uppercase tracking-wider text-gray-500 font-semibold mb-1">Rice Variety</span>
                      <span class="text-gray-900 font-medium">{{ product.rice_variety?.name || 'N/A' }}</span>
                   </div>
                   <div class="flex flex-col">
                      <span class="text-xs uppercase tracking-wider text-gray-500 font-semibold mb-1">Quality Grade</span>
                      <span class="text-gray-900 font-medium flex items-center gap-2">
                        {{ formatStatus(product.quality_grade) }}
                        <span v-if="['premium', 'grade_a'].includes(product.quality_grade)" class="text-amber-500">
                           <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/></svg>
                        </span>
                      </span>
                   </div>
                   <div class="flex flex-col">
                      <span class="text-xs uppercase tracking-wider text-gray-500 font-semibold mb-1">Processing Method</span>
                      <span class="text-gray-900 font-medium">{{ formatStatus(product.processing_method) || 'N/A' }}</span>
                   </div>
                   <div class="flex flex-col">
                      <span class="text-xs uppercase tracking-wider text-gray-500 font-semibold mb-1">Moisture Content</span>
                      <span class="text-gray-900 font-medium">{{ product.moisture_content ? product.moisture_content + '%' : 'N/A' }}</span>
                   </div>
                   <div class="flex flex-col">
                      <span class="text-xs uppercase tracking-wider text-gray-500 font-semibold mb-1">Purity</span>
                      <span class="text-gray-900 font-medium">{{ product.purity_percentage ? product.purity_percentage + '%' : 'N/A' }}</span>
                   </div>
                   <div class="flex flex-col">
                      <span class="text-xs uppercase tracking-wider text-gray-500 font-semibold mb-1">Organic Certified</span>
                      <span :class="['font-medium', product.is_organic ? 'text-emerald-600' : 'text-gray-900']">
                        {{ product.is_organic ? 'Yes' : 'No' }}
                      </span>
                   </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { riceMarketplaceAPI } from '@/services/api'
import { useAuthStore } from '@/stores/auth'
import { formatCurrency } from '@/utils/format'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const loading = ref(true)
const error = ref(null)
const product = ref({})
const selectedImageIndex = ref(0)

const loadProduct = async () => {
  loading.value = true
  error.value = null
  try {
    const id = route.params.id
    const response = await riceMarketplaceAPI.getProductById(id)
    product.value = response.data.product || response.data
    
    // Verify ownership
    if (authStore.user && product.value.farmer_id !== authStore.user.id) {
       // Ideally backend should handle this, but as a safety check
       error.value = "You do not have permission to view this product."
    }
  } catch (err) {
    console.error('Failed to load product:', err)
    error.value = err.response?.data?.message || 'Failed to load product details.'
  } finally {
    loading.value = false
  }
}

// formatPrice removed in favor of formatCurrency

const formatNumber = (value) => {
  const num = Number(value)
  return Number.isNaN(num) ? value : num.toLocaleString('en-US')
}

const formatStatus = (status) => {
  if (!status) return ''
  return status.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())
}

const formatDate = (value) => {
  if (!value) return 'N/A'
  return new Date(value).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

onMounted(() => {
  if (!authStore.user) return // Router guard should handle, but safety check
  loadProduct()
})
</script>
