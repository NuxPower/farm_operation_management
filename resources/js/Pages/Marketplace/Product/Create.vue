<template>
  <div class="min-h-screen bg-gradient-to-br from-green-50 via-emerald-50 to-teal-50 py-10 px-4 sm:px-6 lg:px-8">
    <div class="w-full mx-auto space-y-8">
      <!-- Header -->
      <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <button
            type="button"
            @click="router.push('/marketplace/my-products')"
            class="inline-flex items-center text-sm font-medium text-emerald-700 hover:text-emerald-900 transition-colors"
          >
            <svg class="h-4 w-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            Back to My Products
          </button>
          <h1 class="mt-4 text-3xl font-bold text-gray-900">Add Rice Product</h1>
          <p class="mt-2 text-base text-gray-600 max-w-2xl">
            Publish a new product to the marketplace.
          </p>
        </div>
      </div>

      <!-- Main Content -->
      <div>
      <!-- Error Alert -->
      <div v-if="formError.message" class="mb-6 rounded-xl bg-red-50 p-4 border border-red-100 flex items-start gap-3">
         <svg class="h-5 w-5 text-red-500 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
         </svg>
         <div>
            <h3 class="text-sm font-medium text-red-800">{{ formError.message }}</h3>
            <ul v-if="Object.keys(formError.fieldErrors).length" class="mt-2 text-xs text-red-700 list-disc list-inside">
               <li v-for="(errs, field) in formError.fieldErrors" :key="field">{{ errs[0] }}</li>
            </ul>
         </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Left Column: Main Info -->
        <div class="lg:col-span-2 space-y-6">
          
          <!-- Basic Info Card -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
            <h2 class="text-lg font-bold text-gray-900 flex items-center gap-2">
              <svg class="w-5 h-5 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              Basic Information
            </h2>
            
            <div class="space-y-4">
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Product Name <span class="text-red-500">*</span></label>
                <input
                  v-model="form.name"
                  type="text"
                  required
                  class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-gray-50 focus:bg-white placeholder-gray-400"
                  placeholder="e.g. Premium Jasmine Rice 50kg"
                />
              </div>

               <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Description <span class="text-red-500">*</span></label>
                <textarea
                  v-model="form.description"
                  rows="4"
                  required
                  class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-gray-50 focus:bg-white placeholder-gray-400 resize-none"
                  placeholder="Describe your rice product, detailed quality, texture, and cooking suggestions..."
                ></textarea>
              </div>
            </div>
          </div>

          <!-- Inventory & Price Card -->
           <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
            <div class="flex items-center justify-between">
               <h2 class="text-lg font-bold text-gray-900 flex items-center gap-2">
                 <svg class="w-5 h-5 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                   <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                 </svg>
                 Inventory & Pricing
               </h2>
               <div class="text-xs text-blue-600 bg-blue-50 px-2 py-1 rounded-md font-medium">
                  Auto-sync enabled
               </div>
            </div>

            <div class="space-y-4">
               <div>
                  <label class="block text-sm font-semibold text-gray-700 mb-1.5">Link to Harvest (Optional)</label>
                  <p class="text-xs text-gray-500 mb-2">Select a harvest to auto-fill quantity, quality details, and the latest post-harvest output when available.</p>
                  <select
                    v-model="form.harvest_id"
                    class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all bg-white"
                  >
                    <option value="">-- No Harvest Linked --</option>
                    <option v-for="harvest in harvests" :key="harvest.id" :value="harvest.id">
                      {{ formatHarvestOption(harvest) }}
                    </option>
                  </select>
               </div>

               <div v-if="form.harvest_id" class="rounded-xl border border-emerald-100 bg-emerald-50/70 p-4">
                  <div v-if="processingLoading" class="text-sm text-emerald-800">
                    Checking post-harvest output for this harvest...
                  </div>
                  <div v-else-if="latestCompletedProcess" class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                    <div>
                      <p class="text-sm font-semibold text-emerald-900">
                        Latest completed output: {{ getProcessStageLabel(latestCompletedProcess.process_type) }}
                      </p>
                      <p class="mt-1 text-sm text-emerald-800">
                        Suggested ready quantity: {{ latestCompletedProcess.output_quantity || processingSummary?.summary?.final_quantity }} {{ displayUnitLabel(latestCompletedProcess.output_unit || processingSummary?.summary?.final_unit || form.unit) }}
                      </p>
                      <p class="mt-2 text-xs text-emerald-700">
                        This form uses the latest completed post-harvest output when available while keeping your processing workflow flexible.
                      </p>
                    </div>
                    <button
                      type="button"
                      @click="openProcessingPipeline"
                      class="inline-flex items-center rounded-lg border border-emerald-200 bg-white px-3 py-2 text-sm font-medium text-emerald-700 hover:bg-emerald-100"
                    >
                      View Processing
                    </button>
                  </div>
                  <div v-else class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                    <div>
                      <p class="text-sm font-semibold text-amber-900">No completed post-harvest output yet</p>
                      <p class="mt-1 text-xs text-amber-800">
                        You can publish directly, or open the processing page first to record threshing, drying, or milling for this harvest.
                      </p>
                    </div>
                    <button
                      type="button"
                      @click="openProcessingPipeline"
                      class="inline-flex items-center rounded-lg border border-amber-200 bg-white px-3 py-2 text-sm font-medium text-amber-700 hover:bg-amber-100"
                    >
                      Open Processing
                    </button>
                  </div>
               </div>

               <div class="grid grid-cols-1 sm:grid-cols-2 gap-5 pt-2">
                  <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Quantity Available <span class="text-red-500">*</span></label>
                    <input
                      v-model="form.quantity_available"
                      type="number"
                      step="0.01"
                      min="0"
                      required
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-gray-50 focus:bg-white"
                      placeholder="0.00"
                    />
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Unit <span class="text-red-500">*</span></label>
                    <div v-if="isUnitLocked" class="flex items-center gap-2">
                      <div class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-gray-700 font-medium">
                        {{ displayUnitLabel(form.unit) }}
                      </div>
                      <span class="text-xs text-emerald-600 whitespace-nowrap">From milling</span>
                    </div>
                    <select
                      v-else
                      v-model="form.unit"
                      required
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-white"
                    >
                      <option v-for="unit in units" :key="unit" :value="unit">
                        {{ displayUnitLabel(unit) }}
                      </option>
                    </select>
                  </div>
               </div>

               <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                   <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">
                       Price per {{ displayUnitLabel(form.unit) }} (₱) <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                       <span class="absolute left-4 top-3.5 text-gray-400">₱</span>
                       <input
                         v-model="form.price_per_unit"
                         type="number"
                         step="0.01"
                         min="0"
                         required
                         class="w-full pl-8 pr-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-gray-50 focus:bg-white font-medium text-gray-900"
                         placeholder="0.00"
                       />
                    </div>
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Min. Order Quantity</label>
                    <input
                      v-model="form.minimum_order_quantity"
                      type="number"
                      step="0.1"
                      min="0"
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-gray-50 focus:bg-white"
                      placeholder="Optional"
                    />
                  </div>
               </div>
            </div>
          </div>

          <!-- Images Card -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
            <h2 class="text-lg font-bold text-gray-900 flex items-center gap-2">
              <svg class="w-5 h-5 text-purple-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
              </svg>
              Product Images
            </h2>
            
             <!-- Upload Area -->
            <div
              @dragover.prevent="isDragging = true"
              @dragleave.prevent="isDragging = false"
              @drop.prevent="handleDrop"
              :class="[
                'border-2 border-dashed rounded-xl p-8 text-center transition-all cursor-pointer group',
                isDragging ? 'border-purple-500 bg-purple-50' : 'border-gray-300 hover:border-purple-400 hover:bg-gray-50'
              ]"
              @click="$refs.fileInput.click()"
            >
              <input
                ref="fileInput"
                type="file"
                accept="image/jpeg,image/jpg,image/png,image/webp"
                multiple
                class="hidden"
                @change="handleFileSelect"
              />
              <div class="h-12 w-12 bg-gray-100 text-gray-400 group-hover:bg-purple-100 group-hover:text-purple-500 rounded-full flex items-center justify-center mx-auto transition-colors mb-3">
                 <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                 </svg>
              </div>
              <p class="text-sm font-medium text-gray-900 group-hover:text-purple-700">Click to upload images</p>
              <p class="text-xs text-gray-500 mt-1">or drag and drop here (Max 5 images)</p>
            </div>

            <!-- Upload Progress -->
            <div v-if="uploadingImages" class="flex items-center justify-center gap-2 py-2">
              <svg class="animate-spin h-5 w-5 text-purple-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              <span class="text-sm text-gray-600">Uploading...</span>
            </div>

             <!-- Image Previews -->
            <div v-if="uploadedImages.length > 0" class="grid grid-cols-2 sm:grid-cols-4 gap-4">
              <div
                v-for="(image, index) in uploadedImages"
                :key="index"
                class="relative group aspect-square rounded-lg overflow-hidden border border-gray-200 bg-gray-100"
              >
                <img :src="image" alt="Product image" class="w-full h-full object-cover" />
                <button
                  type="button"
                  @click.stop="removeImage(index)"
                  class="absolute top-1 right-1 p-1 bg-white/90 text-red-600 rounded-full shadow-sm hover:bg-red-50 opacity-0 group-hover:opacity-100 transition-all"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>
            </div>
             <p v-if="imageError" class="text-sm text-red-600 text-center">{{ imageError }}</p>
          </div>
        </div>

        <!-- Right Column: Meta Info -->
        <div class="space-y-6">
           <!-- Classification Card -->
           <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
              <h2 class="text-lg font-bold text-gray-900">Classification</h2>
              
              <div class="space-y-4">
                 <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Rice Variety <span class="text-red-500">*</span></label>
                    <select
                      v-model="form.rice_variety_id"
                      required
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-white"
                    >
                      <option value="">Select Variety</option>
                      <option v-for="variety in riceVarieties" :key="variety.id" :value="variety.id">
                        {{ variety.name }}
                      </option>
                    </select>
                 </div>
                 
                 <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Quality Grade <span class="text-red-500">*</span></label>
                    <select
                      v-model="form.quality_grade"
                      required
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-white"
                    >
                      <option v-for="(label, value) in qualityGrades" :key="value" :value="value">
                        {{ label }}
                      </option>
                    </select>
                 </div>
              </div>
           </div>

           <!-- Specs Card -->
           <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
              <h2 class="text-lg font-bold text-gray-900">Specifications</h2>
              
              <div class="space-y-4">
                 <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Marketplace Processing Label</label>
                    <p class="text-xs text-gray-500 mb-2">Customer-facing product style. Actual threshing, drying, and milling records stay in the post-harvest module.</p>
                    <select
                      v-model="form.processing_method"
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-all bg-white"
                    >
                       <option value="">Select Method</option>
                       <option v-for="(label, value) in processingMethods" :key="value" :value="value">
                         {{ label }}
                       </option>
                    </select>
                 </div>

                 <div class="grid grid-cols-2 gap-3">
                    <div>
                       <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Moisture (%)</label>
                       <input
                         v-model="form.moisture_content"
                         type="number"
                         min="5" max="25" step="0.1"
                         placeholder="e.g. 14"
                         class="w-full px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                       />
                    </div>
                    <div>
                       <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Purity (%)</label>
                       <input
                         v-model="form.purity_percentage"
                         type="number"
                         min="50" max="100" step="0.1"
                         placeholder="e.g. 98"
                         class="w-full px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                       />
                    </div>
                 </div>

                 <div class="flex items-center justify-between p-4 bg-green-50 rounded-xl border border-green-100 cursor-pointer" @click="form.is_organic = !form.is_organic">
                    <span class="text-sm font-medium text-green-900">Certified Organic</span>
                    <div class="relative inline-flex items-center cursor-pointer">
                      <input type="checkbox" v-model="form.is_organic" class="sr-only peer">
                      <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-green-600"></div>
                    </div>
                 </div>
              </div>
           </div>

           <!-- Extra Info Card -->
           <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
              <h2 class="text-lg font-bold text-gray-900">Additional</h2>
              
              <div class="space-y-4">
                 <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Certification</label>
                    <input
                      v-model="form.certification"
                      type="text"
                      placeholder="e.g. ISO 9001"
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 transition-all bg-gray-50 focus:bg-white"
                    />
                 </div>
                 <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Storage</label>
                    <input
                      v-model="form.storage_conditions"
                      type="text"
                      placeholder="e.g. Cool dry place"
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 transition-all bg-gray-50 focus:bg-white"
                    />
                 </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Internal Notes</label>
                    <textarea
                      v-model="form.notes"
                      rows="2"
                      placeholder="Private notes..."
                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 transition-all bg-gray-50 focus:bg-white resize-none"
                    ></textarea>
                 </div>
              </div>
           </div>
        </div>
      </div>
      
       <!-- Form Actions moved to bottom -->
      <div class="mt-8 flex items-center justify-end gap-3 bg-white p-4 rounded-xl border border-gray-100 shadow-sm sticky bottom-6 z-20">
         <button
          type="button"
          @click="router.push('/marketplace/my-products')"
          class="px-6 py-2.5 text-sm font-medium text-gray-700 hover:text-gray-900 bg-white border border-gray-300 hover:bg-gray-50 rounded-lg transition-colors"
        >
          Cancel
        </button>
        <button
          @click="submit"
          :disabled="submitting"
          class="inline-flex items-center px-6 py-2.5 text-sm font-semibold text-white bg-green-600 hover:bg-green-700 rounded-lg shadow-sm hover:shadow-md transition-all disabled:opacity-70 disabled:cursor-not-allowed gap-2"
        >
          <svg v-if="submitting" class="animate-spin h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
          {{ submitting ? 'Publishing...' : 'Publish Product' }}
        </button>
      </div>
    </div>
  </div>
</div>
</template>

<script setup>
import { computed, onMounted, reactive, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useMarketplaceStore } from '@/stores/marketplace'
import { useFarmStore } from '@/stores/farm'
import FormAlert from '@/Components/UI/FormAlert.vue'
import LoadingSpinner from '@/Components/UI/LoadingSpinner.vue'
import { extractFormErrors, resetFormErrors } from '@/utils/form'
import { riceMarketplaceAPI } from '@/services/api'
import { useFormValidation } from '@/composables/useFormValidation'
import axios from 'axios'

const router = useRouter()
const route = useRoute()
const marketplaceStore = useMarketplaceStore()
const farmStore = useFarmStore()
const { errors: clientErrors, rules, validateForm, sanitizeForm, clearErrors } = useFormValidation()

const submitting = ref(false)
const errors = ref({})
const processingLoading = ref(false)
const processingSummary = ref(null)
const formError = reactive({
  message: '',
  fieldErrors: {},
})

// Image upload state
const fileInput = ref(null)
const uploadedImages = ref([])
const uploadingImages = ref(false)
const isDragging = ref(false)
const imageError = ref('')

const form = reactive({
  rice_variety_id: '',
  harvest_id: '',
  name: '',
  description: '',
  quantity_available: '',
  unit: 'kg',
  price_per_unit: '',
  quality_grade: 'premium',
  moisture_content: '',
  purity_percentage: '',
  processing_method: '',
  storage_conditions: '',
  certification: '',
  is_organic: false,
  minimum_order_quantity: '',
  notes: ''
})

const units = ['kg', 'tons', 'sacks', 'sacks_palay', 'sacks_rice', 'bushels', 'pounds', 'grams']
const qualityGrades = {
  premium: 'Premium',
  grade_a: 'Grade A',
  grade_b: 'Grade B',
  commercial: 'Commercial'
}
const processingMethods = {
  milled: 'White Rice',
  organic: 'Organic Rice'
}

const riceVarieties = computed(() => marketplaceStore.riceVarieties || [])
const PROCESS_WEIGHT = {
  milling: 3,
  drying: 2,
  threshing: 1
}

const harvests = computed(() => farmStore.harvests || [])
const latestCompletedProcess = computed(() => {
  const completed = (processingSummary.value?.processes || []).filter(process => process.status === 'completed')

  if (completed.length === 0) {
    return null
  }

  return completed.sort((a, b) => {
    const timeA = new Date(a.completed_date || a.process_date || 0).getTime()
    const timeB = new Date(b.completed_date || b.process_date || 0).getTime()
    if (timeA !== timeB) {
      return timeB - timeA
    }
    const weightA = PROCESS_WEIGHT[a.process_type] || 0
    const weightB = PROCESS_WEIGHT[b.process_type] || 0
    return weightB - weightA
  })[0]
})

const formatHarvestOption = (harvest) => {
  const crop = harvest?.planting?.crop_type || 'Harvest'
  const date = harvest?.harvest_date ? new Date(harvest.harvest_date).toLocaleDateString() : 'Undated'
  
  // Find the latest completed post-harvest process (e.g. milling)
  let latestOutputQuantity = harvest?.quantity
  let latestOutputUnit = harvest?.unit || 'kg'
  
  if (harvest?.post_harvest_processes?.length) {
    const completedProcesses = harvest.post_harvest_processes.filter(p => p.status === 'completed')
    if (completedProcesses.length > 0) {
      // Sort by latest completed date, then by process logical order
      completedProcesses.sort((a, b) => {
        const timeA = new Date(a.completed_date || a.process_date || 0).getTime()
        const timeB = new Date(b.completed_date || b.process_date || 0).getTime()
        if (timeA !== timeB) {
          return timeB - timeA
        }
        const weightA = PROCESS_WEIGHT[a.process_type] || 0
        const weightB = PROCESS_WEIGHT[b.process_type] || 0
        return weightB - weightA
      })
      const latest = completedProcesses[0]
      if (latest.output_quantity) {
        latestOutputQuantity = latest.output_quantity
        latestOutputUnit = latest.output_unit || 'kg'
      }
    }
  }

  const yieldKg = latestOutputQuantity ? `${Number(latestOutputQuantity).toLocaleString()} ${displayUnitLabel(latestOutputUnit)}` : ''
  return `${crop} • ${date}${yieldKg ? ` • ${yieldKg}` : ''}`
}

const getProcessStageLabel = (type) => {
  const labels = {
    threshing: 'Threshed Palay',
    drying: 'Dried Palay',
    milling: 'Milled Rice',
  }

  return labels[type] || 'Processed Rice'
}

// Unit display helper
const UNIT_DISPLAY_LABELS = {
  sacks_palay: 'Sacks (Palay)',
  sacks_rice: 'Sacks (Rice)',
  kg: 'Kg',
  tons: 'Tons',
  sacks: 'Sacks',
  bushels: 'Bushels',
  pounds: 'Pounds',
  grams: 'Grams',
}

const displayUnitLabel = (unit) => {
  return UNIT_DISPLAY_LABELS[unit] || (unit ? unit.charAt(0).toUpperCase() + unit.slice(1) : '')
}

// Lock unit when milling is completed and harvest is linked
const isUnitLocked = computed(() => {
  if (!form.harvest_id || !latestCompletedProcess.value) return false
  return latestCompletedProcess.value.process_type === 'milling'
})

const applyProcessingSuggestions = () => {
  if (!latestCompletedProcess.value) {
    return
  }

  const latestQty = latestCompletedProcess.value.output_quantity || processingSummary.value?.summary?.final_quantity
  if (!latestQty) return

  form.quantity_available = Number(latestQty)

  const latestUnit = latestCompletedProcess.value.output_unit || processingSummary.value?.summary?.final_unit

  // Lock unit to the milling output unit type when milling is completed
  if (latestCompletedProcess.value.process_type === 'milling') {
    form.unit = 'sacks_rice'
  } else if (latestUnit && units.includes(latestUnit)) {
    form.unit = latestUnit
  }

  if (!form.processing_method) {
    if (latestCompletedProcess.value.process_type === 'milling') {
      form.processing_method = 'milled'
    } else if (latestCompletedProcess.value.process_type === 'threshing') {
      form.processing_method = 'threshed'
    } else if (latestCompletedProcess.value.process_type === 'drying') {
      form.processing_method = 'dried'
    }
  }

  if (!form.name && latestCompletedProcess.value.process_type === 'milling') {
    const linkedHarvest = harvests.value.find(h => Number(h.id) === Number(form.harvest_id))
    const varietyLabel = linkedHarvest?.planting?.riceVariety?.name || linkedHarvest?.planting?.crop_type || 'Rice'
    form.name = `${varietyLabel} Milled Rice`
  }
}

const loadProcessingSummary = async (harvestId) => {
  processingSummary.value = null

  if (!harvestId) {
    return
  }

  processingLoading.value = true

  try {
    const response = await axios.get(`/api/post-harvest/harvest/${harvestId}`)
    processingSummary.value = response.data
    applyProcessingSuggestions()
  } catch (error) {
    console.warn('Failed to load post-harvest summary for marketplace form:', error)
  } finally {
    processingLoading.value = false
  }
}

const openProcessingPipeline = () => {
  if (!form.harvest_id) return

  router.push(`/harvests/${form.harvest_id}/processing`)
}

// Watch for Harvest selection to auto-fill data
watch(() => form.harvest_id, async (newId) => {
  if (!newId) {
    processingSummary.value = null
    return
  }

  const harvest = harvests.value.find(h => Number(h.id) === Number(newId))
  if (harvest) {
    // 1. Auto-fill Unit
    if (harvest.unit && units.includes(harvest.unit)) {
      form.unit = harvest.unit
    }

    // 2. Auto-fill Quantity (Net Quantity = Gross - Harvester Share)
    const grossQty = Number(harvest.quantity || 0)
    const shareQty = Number(harvest.harvester_share || 0)
    const netQty = Math.max(0, grossQty - shareQty)
    
    // Only update if currently empty or if user just switched harvests
    form.quantity_available = netQty

    // 3. Auto-fill Rice Variety if linked planting has it
    if (harvest.planting?.rice_variety_id) {
       form.rice_variety_id = harvest.planting.rice_variety_id
    }
    
    // 4. Auto-fill Quality Grade if available
    if (harvest.quality_grade) {
       // Map harvest grades (A, B, C, D) to product grades
       const gradeMap = {
          'A': 'premium',
          'B': 'grade_a',
          'C': 'grade_b',
          'D': 'commercial'
       }
       if (gradeMap[harvest.quality_grade]) {
          form.quality_grade = gradeMap[harvest.quality_grade]
       }
    }

    // Note: Price is NOT auto-filled from harvest — it's set here in the product form
  }

  await loadProcessingSummary(newId)
})

// Image upload handlers
const handleFileSelect = (event) => {
  const files = Array.from(event.target.files)
  uploadImages(files)
  event.target.value = '' // Reset input
}

const handleDrop = (event) => {
  isDragging.value = false
  const files = Array.from(event.dataTransfer.files).filter(file => file.type.startsWith('image/'))
  uploadImages(files)
}

const uploadImages = async (files) => {
  imageError.value = ''
  
  // Check total count
  if (uploadedImages.value.length + files.length > 5) {
    imageError.value = 'You can upload a maximum of 5 images.'
    return
  }
  
  // Validate file sizes
  const oversizedFiles = files.filter(f => f.size > 2 * 1024 * 1024)
  if (oversizedFiles.length > 0) {
    imageError.value = 'Some files are larger than 2MB and were not uploaded.'
    files = files.filter(f => f.size <= 2 * 1024 * 1024)
  }
  
  if (files.length === 0) return
  
  uploadingImages.value = true
  
  try {
    const formData = new FormData()
    files.forEach(file => formData.append('images[]', file))
    
    const response = await riceMarketplaceAPI.uploadImages(formData)
    
    uploadedImages.value.push(...response.data.urls)
  } catch (error) {
    console.error('Upload error:', error)
    imageError.value = error.response?.data?.message || 'Failed to upload images. Please try again.'
  } finally {
    uploadingImages.value = false
  }
}

const removeImage = async (index) => {
  const url = uploadedImages.value[index]
  
  try {
    await riceMarketplaceAPI.deleteImage(url)
  } catch (error) {
    console.warn('Failed to delete image from server:', error)
  }
  
  uploadedImages.value.splice(index, 1)
}

const submit = async () => {
  if (submitting.value) return
  
  clearErrors()
  sanitizeForm(form)
  
  const isValid = validateForm(form, {
    name: [rules.required, rules.maxLength(255), rules.noEmoji],
    description: [rules.required, rules.maxLength(2000), rules.noEmoji],
    quantity_available: [rules.required, rules.numeric],
    price_per_unit: [rules.required, rules.numeric],
    rice_variety_id: [rules.required],
    quality_grade: [rules.required],
    storage_conditions: [rules.maxLength(500), rules.noEmoji],
    certification: [rules.maxLength(255), rules.noEmoji],
    notes: [rules.maxLength(1000), rules.noEmoji]
  })
  
  if (!isValid) {
    formError.message = 'Please fix the errors below.'
    const mappedErrors = {}
    for (const [key, msg] of Object.entries(clientErrors.value)) {
       mappedErrors[key] = [msg]
    }
    formError.fieldErrors = mappedErrors
    return
  }
  
  submitting.value = true
  errors.value = {}
  resetFormErrors(formError)

  try {
    const payload = {
      ...form,
      rice_variety_id: Number(form.rice_variety_id),
      harvest_id: form.harvest_id || null,
      quantity_available: Number(form.quantity_available),
      price_per_unit: Number(form.price_per_unit),
      moisture_content: form.moisture_content ? Number(form.moisture_content) : null,
      purity_percentage: form.purity_percentage ? Number(form.purity_percentage) : null,
      minimum_order_quantity: form.minimum_order_quantity ? Number(form.minimum_order_quantity) : null,
      is_organic: Boolean(form.is_organic),
    }

    if (!payload.harvest_id) delete payload.harvest_id
    if (!payload.moisture_content) delete payload.moisture_content
    if (!payload.purity_percentage) delete payload.purity_percentage
    if (!payload.minimum_order_quantity) delete payload.minimum_order_quantity
    if (!payload.processing_method) delete payload.processing_method
    if (!payload.storage_conditions) delete payload.storage_conditions
    if (!payload.certification) delete payload.certification
    if (!payload.notes) delete payload.notes
    
    // Add uploaded images
    if (uploadedImages.value.length > 0) {
      payload.images = uploadedImages.value
    }

    const result = await marketplaceStore.createRiceProduct(payload)
    console.log('Product created, result:', result)
    resetFormErrors(formError)
    
    // Backfill harvest price_per_unit if linked — enables deferred harvester share expense calculation
    if (form.harvest_id && form.price_per_unit) {
      try {
        await axios.put(`/api/harvests/${form.harvest_id}`, {
          price_per_unit: Number(form.price_per_unit),
        })
        console.log('Backfilled harvest price_per_unit:', form.price_per_unit)
      } catch (backfillError) {
        console.warn('Failed to backfill harvest price:', backfillError)
      }
    }
    
    // Small delay to ensure state is updated before navigation
    await new Promise(resolve => setTimeout(resolve, 100))
    
    router.push('/marketplace/my-products')
  } catch (error) {
    const parsed = extractFormErrors(error)
    formError.message = parsed.message
    formError.fieldErrors = parsed.fieldErrors
    errors.value = parsed.fieldErrors
  } finally {
    submitting.value = false
  }
}

onMounted(async () => {
  await Promise.all([
    marketplaceStore.fetchRiceVarieties(),
    farmStore.fetchHarvests()
  ])

  const requestedHarvestId = Number(route.query.harvest_id || 0)
  if (requestedHarvestId && harvests.value.some(h => Number(h.id) === requestedHarvestId)) {
    form.harvest_id = requestedHarvestId
  }
})
</script>
