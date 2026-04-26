<template>
  <div class="min-h-screen bg-gray-50/50 font-sans text-gray-900">
    <div class="container mx-auto px-4 py-8 max-w-7xl">

      <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
          <h1 class="text-3xl font-bold text-gray-800">My Products</h1>
          <p class="text-gray-500 mt-1">Manage your inventory and marketplace listings</p>
        </div>
        <div class="flex items-center gap-3 w-full md:w-auto">
          <button type="button" @click="refresh" :disabled="marketplaceStore.loading"
            class="flex items-center justify-center gap-2 px-4 py-2 bg-white text-gray-700 border border-gray-200 rounded-lg hover:bg-gray-50 hover:border-gray-300 transition-all shadow-sm font-medium text-sm disabled:opacity-50 disabled:cursor-not-allowed w-full md:w-auto">
            <svg :class="['h-4 w-4', { 'animate-spin': marketplaceStore.loading }]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
            </svg>
            <span class="hidden sm:inline">Refresh Data</span>
          </button>
          <button type="button" @click="router.push('/marketplace/product/create')"
            class="flex items-center justify-center gap-2 px-5 py-2 bg-emerald-600 text-white border border-transparent rounded-lg hover:bg-emerald-700 active:bg-emerald-800 transition-all shadow-sm font-medium text-sm w-full md:w-auto">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
            Add Product
          </button>
        </div>
      </div>

      <!-- Filter Bar -->
      <div class="bg-white p-4 rounded-xl border border-gray-200 shadow-sm mb-6 flex flex-col md:flex-row gap-3 items-center">
        <div class="flex-1 relative w-full">
          <span class="absolute left-3 top-2.5 text-gray-400">🔍</span>
          <input v-model="searchQuery" type="text" placeholder="Search product name…"
            class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-sm" />
        </div>
        <select v-model="varietyFilter" class="w-full md:w-48 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white text-sm">
          <option value="">All Varieties</option>
          <option v-for="v in varietyOptions" :key="v" :value="v">{{ v }}</option>
        </select>
        <select v-model="qualityFilter" class="w-full md:w-44 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white text-sm">
          <option value="">All Quality</option>
          <option value="premium">Premium</option>
          <option value="grade_a">Grade A</option>
          <option value="grade_b">Grade B</option>
          <option value="commercial">Commercial</option>
        </select>
        <select v-model="statusFilter" class="w-full md:w-44 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white text-sm">
          <option value="">All Availability</option>
          <option value="available">Available</option>
          <option value="in_production">In Production</option>
          <option value="pre_order">Pre-order</option>
        </select>
        <select v-model.number="pageSize" class="w-full md:w-24 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white text-sm">
          <option :value="10">10</option>
          <option :value="25">25</option>
          <option :value="50">50</option>
        </select>
        <button v-if="searchQuery || varietyFilter || qualityFilter || statusFilter" @click="clearFilters"
          class="whitespace-nowrap text-sm text-gray-500 hover:text-red-600 transition-colors px-3 py-2 rounded-lg border border-gray-200 hover:border-red-300 hover:bg-red-50">
          ✕ Clear
        </button>
      </div>

      <div class="space-y-6">
        <!-- Error -->
        <div v-if="marketplaceStore.error" class="bg-red-50 border border-red-200 rounded-xl p-4 flex items-start gap-3">
          <svg class="h-5 w-5 text-red-500 mt-0.5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          <div class="flex-1">
            <h3 class="text-sm font-medium text-red-800">Unable to load products</h3>
            <p class="text-sm text-red-600 mt-1">{{ marketplaceStore.error }}</p>
            <button type="button" @click="refresh" class="mt-2 text-sm font-medium text-red-700 hover:text-red-900 underline">Try again</button>
          </div>
        </div>

        <!-- Loading skeleton -->
        <div v-else-if="marketplaceStore.loading && products.length === 0" class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="border-b border-gray-100 bg-gray-50/50 px-6 py-4">
            <div class="flex gap-4">
              <div class="h-4 bg-gray-200 rounded w-24 animate-pulse"></div>
              <div class="h-4 bg-gray-200 rounded w-24 animate-pulse"></div>
            </div>
          </div>
          <div class="divide-y divide-gray-100">
            <div v-for="n in 5" :key="n" class="px-6 py-4 flex items-center justify-between">
              <div class="flex flex-col gap-2 w-1/3">
                <div class="h-4 bg-gray-100 rounded w-3/4 animate-pulse"></div>
                <div class="h-3 bg-gray-100 rounded w-1/2 animate-pulse"></div>
              </div>
              <div class="h-4 bg-gray-100 rounded w-24 animate-pulse"></div>
              <div class="h-4 bg-gray-100 rounded w-24 animate-pulse"></div>
              <div class="h-8 bg-gray-100 rounded w-8 animate-pulse"></div>
            </div>
          </div>
        </div>

        <!-- Empty: no products -->
        <div v-else-if="products.length === 0" class="bg-white rounded-xl shadow-sm border border-gray-200 p-12 text-center">
          <div class="w-16 h-16 bg-emerald-50 rounded-full flex items-center justify-center mx-auto mb-4">
            <span class="text-3xl">🌾</span>
          </div>
          <h2 class="text-lg font-semibold text-gray-900 mb-1">No products listed yet</h2>
          <p class="text-gray-500 mb-6 max-w-sm mx-auto">Start building your marketplace presence by adding your first rice variety.</p>
          <button type="button" @click="router.push('/marketplace/product/create')"
            class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium rounded-lg bg-emerald-600 text-white hover:bg-emerald-700 transition-colors shadow-sm">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
            Add First Product
          </button>
        </div>

        <!-- Empty: filter returned nothing -->
        <div v-else-if="filteredProducts.length === 0" class="bg-white rounded-xl shadow-sm border border-gray-200 p-12 text-center">
          <div class="text-4xl mb-3">🌾</div>
          <h2 class="text-lg font-semibold text-gray-900 mb-1">No products match your filters</h2>
          <p class="text-gray-500 mb-4">Try adjusting or clearing the filters above.</p>
          <button @click="clearFilters" class="text-sm text-emerald-700 hover:underline font-medium">Clear filters</button>
        </div>

        <!-- Table -->
        <div v-else class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-100">
              <thead class="bg-gray-50/50">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">Product Info</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">Status</th>
                  <th scope="col"
                    class="px-6 py-3 text-right text-xs font-semibold text-gray-500 uppercase tracking-wider cursor-pointer select-none hover:text-emerald-700 transition-colors"
                    @click="toggleSort('quantity_available')">
                    Inventory <span class="ml-1">{{ sortKey === 'quantity_available' ? (sortDir === 'asc' ? '↑' : '↓') : '↕' }}</span>
                  </th>
                  <th scope="col"
                    class="px-6 py-3 text-right text-xs font-semibold text-gray-500 uppercase tracking-wider cursor-pointer select-none hover:text-emerald-700 transition-colors"
                    @click="toggleSort('price_per_unit')">
                    Price <span class="ml-1">{{ sortKey === 'price_per_unit' ? (sortDir === 'asc' ? '↑' : '↓') : '↕' }}</span>
                  </th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">Quality</th>
                  <th scope="col" class="px-6 py-3 text-right text-xs font-semibold text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 bg-white">
                <tr v-for="product in paginatedProducts" :key="product.id" class="group hover:bg-gray-50/80 transition-colors">
                  <td class="px-6 py-4">
                    <div class="text-sm font-semibold text-gray-900">{{ product.name }}</div>
                    <div class="text-xs text-gray-500 mt-0.5">
                      {{ product.rice_variety?.name || product.riceVariety?.name || 'Unknown Variety' }}
                      <span class="text-gray-300 mx-1">•</span>
                      Updated {{ formatDate(product.updated_at) }}
                    </div>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap">
                    <span :class="[
                      'inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium border',
                      product.production_status === 'available' ? 'bg-emerald-50 text-emerald-700 border-emerald-100' :
                      product.production_status === 'in_production' ? 'bg-blue-50 text-blue-700 border-blue-100' :
                      'bg-gray-50 text-gray-600 border-gray-200'
                    ]">
                      <span :class="['h-1.5 w-1.5 rounded-full',
                        product.production_status === 'available' ? 'bg-emerald-500' :
                        product.production_status === 'in_production' ? 'bg-blue-500' : 'bg-gray-400']"></span>
                      {{ formatStatus(product.production_status) }}
                    </span>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-right">
                    <div class="text-sm font-medium text-gray-900">{{ formatQuantity(product.quantity_available) }}</div>
                    <div class="text-xs text-gray-500 uppercase">{{ formatUnit(product.unit) || 'units' }}</div>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-right">
                    <div class="text-sm font-bold text-gray-900">{{ formatCurrency(product.price_per_unit) }}</div>
                    <div class="text-xs text-gray-500">per {{ formatUnit(product.unit) || 'unit' }}</div>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-700 flex items-center gap-1.5">
                      <svg v-if="product.quality_grade === 'premium' || product.quality_grade === 'grade_a'" class="w-4 h-4 text-amber-400" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                      </svg>
                      {{ qualityMap[product.quality_grade] || product.quality_grade }}
                    </div>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <div class="flex items-center justify-end gap-2 opacity-100 sm:opacity-0 sm:group-hover:opacity-100 transition-opacity">
                      <button type="button" @click="router.push(`/marketplace/product/${product.id}/edit`)"
                        class="p-1.5 text-gray-500 hover:text-emerald-600 hover:bg-emerald-50 rounded-lg transition-colors" title="Edit Product">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                      </button>
                      <button type="button" @click="router.push(`/marketplace/my-products/${product.id}`)"
                        class="p-1.5 text-gray-500 hover:text-emerald-600 hover:bg-emerald-50 rounded-lg transition-colors" title="View Product">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                        </svg>
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Pagination bar -->
          <div class="px-6 py-4 border-t border-gray-100 flex flex-col sm:flex-row items-center justify-between gap-3 bg-gray-50/30">
            <p class="text-sm text-gray-500">
              Showing {{ paginationInfo.from }}–{{ paginationInfo.to }} of {{ filteredProducts.length }} products
            </p>
            <div class="flex items-center gap-1">
              <button @click="currentPage--" :disabled="currentPage === 1"
                class="px-3 py-1.5 text-sm rounded-lg border border-gray-200 text-gray-600 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors">
                ← Prev
              </button>
              <button v-for="page in visiblePages" :key="page"
                @click="page !== '…' && (currentPage = page)"
                :class="[
                  'px-3 py-1.5 text-sm rounded-lg border transition-colors',
                  page === currentPage ? 'bg-emerald-600 text-white border-emerald-600' :
                  page === '…' ? 'border-transparent text-gray-400 cursor-default' :
                  'border-gray-200 text-gray-600 hover:bg-gray-100'
                ]">{{ page }}</button>
              <button @click="currentPage++" :disabled="currentPage === totalPages"
                class="px-3 py-1.5 text-sm rounded-lg border border-gray-200 text-gray-600 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors">
                Next →
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useMarketplaceStore } from '@/stores/marketplace'
import { useAuthStore } from '@/stores/auth'
import { formatCurrency, formatUnit } from '@/utils/format'

const router = useRouter()
const marketplaceStore = useMarketplaceStore()
const authStore = useAuthStore()

const qualityMap = {
  premium: 'Premium',
  grade_a: 'Grade A',
  grade_b: 'Grade B',
  commercial: 'Commercial'
}

const products = computed(() => marketplaceStore.farmerProducts || [])

// --- Filters ---
const searchQuery = ref('')
const varietyFilter = ref('')
const qualityFilter = ref('')
const statusFilter = ref('')

const varietyOptions = computed(() => [
  ...new Set(products.value.map(p => p.rice_variety?.name || p.riceVariety?.name).filter(Boolean))
].sort())

const clearFilters = () => {
  searchQuery.value = ''
  varietyFilter.value = ''
  qualityFilter.value = ''
  statusFilter.value = ''
}

// --- Sorting ---
const sortKey = ref('')
const sortDir = ref('asc')

const toggleSort = (key) => {
  if (sortKey.value === key) {
    sortDir.value = sortDir.value === 'asc' ? 'desc' : 'asc'
  } else {
    sortKey.value = key
    sortDir.value = 'asc'
  }
  currentPage.value = 1
}

// --- Filtered + Sorted ---
const filteredProducts = computed(() => {
  let list = products.value.filter(p => {
    const search = searchQuery.value.toLowerCase().trim()
    if (search && !(p.name || '').toLowerCase().includes(search)) return false
    if (varietyFilter.value) {
      const v = p.rice_variety?.name || p.riceVariety?.name || ''
      if (v !== varietyFilter.value) return false
    }
    if (qualityFilter.value && p.quality_grade !== qualityFilter.value) return false
    if (statusFilter.value && p.production_status !== statusFilter.value) return false
    return true
  })

  if (sortKey.value) {
    list = [...list].sort((a, b) => {
      const av = Number(a[sortKey.value] ?? 0)
      const bv = Number(b[sortKey.value] ?? 0)
      return sortDir.value === 'asc' ? av - bv : bv - av
    })
  }

  return list
})

watch([searchQuery, varietyFilter, qualityFilter, statusFilter], () => {
  currentPage.value = 1
})

// --- Pagination ---
const pageSize = ref(10)
const currentPage = ref(1)

const totalPages = computed(() => Math.ceil(filteredProducts.value.length / pageSize.value) || 1)

const paginatedProducts = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  return filteredProducts.value.slice(start, start + pageSize.value)
})

const paginationInfo = computed(() => {
  const from = filteredProducts.value.length === 0 ? 0 : (currentPage.value - 1) * pageSize.value + 1
  const to = Math.min(currentPage.value * pageSize.value, filteredProducts.value.length)
  return { from, to }
})

const visiblePages = computed(() => {
  const total = totalPages.value
  const cur = currentPage.value
  if (total <= 7) return Array.from({ length: total }, (_, i) => i + 1)
  const pages = []
  if (cur <= 4) {
    pages.push(1, 2, 3, 4, 5, '…', total)
  } else if (cur >= total - 3) {
    pages.push(1, '…', total - 4, total - 3, total - 2, total - 1, total)
  } else {
    pages.push(1, '…', cur - 1, cur, cur + 1, '…', total)
  }
  return pages
})

watch(pageSize, () => { currentPage.value = 1 })

const refresh = () => marketplaceStore.fetchFarmerProducts({ per_page: 100 })

const formatQuantity = (value) => {
  const num = Number(value)
  return Number.isNaN(num) ? value : num.toLocaleString('en-US')
}

const formatStatus = (status) => {
  if (!status) return 'Available'
  return status.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())
}

const formatDate = (value) => {
  if (!value) return 'Recently'
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? 'Recently' : date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
}

onMounted(async () => {
  if (!authStore.user) return
  try {
    await refresh()
  } catch (error) {
    console.error('Error loading products:', error)
  }
})
</script>
