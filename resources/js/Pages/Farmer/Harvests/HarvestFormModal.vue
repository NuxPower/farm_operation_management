<template>
  <Modal :modelValue="show" @update:modelValue="handleModelValueUpdate" @close="closeModal" :withHeader="false">
    <div class="w-full mx-auto -mx-6 -my-6">
      <!-- Header with close button -->
      <div class="sticky top-0 z-10 bg-white border-b border-gray-200 px-6 py-5 flex items-center justify-between shadow-sm">
        <div class="flex items-center">
          <div class="h-10 w-10 rounded-xl bg-gradient-to-br from-green-500 to-emerald-600 flex items-center justify-center mr-3 shadow-lg">
            <svg class="h-5 w-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <div>
            <h2 class="text-xl font-bold text-gray-900">
              {{ isTaskCompletion ? 'Complete Harvest Task' : (isEditMode ? 'Edit Harvest Log' : 'Add New Harvest') }}
            </h2>
            <p class="text-xs text-gray-600 mt-0.5">
              {{ isTaskCompletion ? 'Record harvest details to complete the task' : (isEditMode ? 'Update harvest details and records' : 'Record your harvest details and track yield') }}
            </p>
          </div>
        </div>
        <button
          type="button"
          @click="closeModal"
          class="inline-flex items-center justify-center rounded-lg p-2 text-gray-400 transition-all hover:bg-gray-100 hover:text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500"
        >
          <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </button>
      </div>

      <!-- Scrollable content -->
      <div class="px-6 py-10 max-h-[calc(100vh-14rem)] overflow-y-auto">
      <form @submit.prevent="submitForm" class="space-y-6 pb-6">
        <!-- Error Message -->
        <div v-if="form.errors.general" class="bg-red-50 border-l-4 border-red-500 p-4 rounded-lg">
          <div class="flex">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-red-400" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <p class="text-sm text-red-800">{{ form.errors.general }}</p>
            </div>
          </div>
        </div>

        <!-- Planting Selection -->
        <section class="bg-gradient-to-br from-white to-gray-50 rounded-2xl p-6 border border-gray-200 shadow-sm">
          <div class="flex items-center mb-4">
            <div class="h-10 w-10 rounded-lg bg-green-100 flex items-center justify-center mr-3">
              <svg class="h-5 w-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
              </svg>
            </div>
            <div>
              <h3 class="text-lg font-semibold text-gray-900">Select Planting</h3>
              <p class="text-xs text-gray-600">Choose which planting to record harvest for</p>
            </div>
          </div>
          <div>
            <label for="planting_id" class="block text-sm font-semibold text-gray-700 mb-2">
              Planting *
            </label>
            <select
              id="planting_id"
              v-model.number="form.data.planting_id"
              required
              class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm bg-white focus:border-green-500 focus:ring-2 focus:ring-green-500 transition"
              :class="{ 'border-red-500 ring-2 ring-red-200': form.errors.planting_id }"
            >
              <option value="" disabled>
                {{ harvestablePlantings.length === 0 ? 'No plantings available - Please create a planting first' : 'Select the planting to harvest' }}
              </option>
              <option v-for="planting in harvestablePlantings" :key="planting.id" :value="planting.id">
                {{ getPlantingDisplayName(planting) }}
              </option>
            </select>
            <p v-if="harvestablePlantings.length === 0" class="mt-2 text-xs text-amber-600 bg-amber-50 px-3 py-2 rounded-lg">
              <span class="font-medium">Note:</span> Total plantings in store: {{ farmStore.plantings?.length || 0 }}
            </p>
            <p v-if="form.errors.planting_id" class="mt-2 text-xs text-red-600">{{ form.errors.planting_id }}</p>
          </div>
        </section>

        <!-- Harvest Details -->
        <section class="bg-gradient-to-br from-white to-gray-50 rounded-2xl p-6 border border-gray-200 shadow-sm">
          <div class="flex items-center mb-4">
            <div class="h-10 w-10 rounded-lg bg-blue-100 flex items-center justify-center mr-3">
              <svg class="h-5 w-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
              </svg>
            </div>
            <div>
              <h3 class="text-lg font-semibold text-gray-900">Harvest Details</h3>
              <p class="text-xs text-gray-600">Date information</p>
            </div>
          </div>
          <div>
              <label for="harvest_date" class="block text-sm font-semibold text-gray-700 mb-2">
                Harvest Date *
              </label>
              <input
                type="date"
                id="harvest_date"
                v-model="form.data.harvest_date"
                required
                class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm focus:border-green-500 focus:ring-2 focus:ring-green-500 transition"
                :class="{ 'border-red-500 ring-2 ring-red-200': form.errors.harvest_date }"
              />
              <p v-if="form.errors.harvest_date" class="mt-1 text-xs text-red-600">{{ form.errors.harvest_date }}</p>
          </div>
        </section>

        <!-- Quantity & Unit -->
        <section class="bg-gradient-to-br from-white to-gray-50 rounded-2xl p-6 border border-gray-200 shadow-sm">
          <div class="flex items-center mb-4">
            <div class="h-10 w-10 rounded-lg bg-purple-100 flex items-center justify-center mr-3">
              <svg class="h-5 w-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
            </div>
            <div>
              <h3 class="text-lg font-semibold text-gray-900">Quantity & Unit</h3>
              <p class="text-xs text-gray-600">Amount harvested and measurement unit</p>
            </div>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label for="quantity" class="block text-sm font-semibold text-gray-700 mb-2">
                Quantity *
              </label>
              <input
                type="number"
                step="0.01"
                min="0"
                id="quantity"
                v-model.number="form.data.quantity"
                required
                class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm focus:border-green-500 focus:ring-2 focus:ring-green-500 transition"
                :class="{ 'border-red-500 ring-2 ring-red-200': form.errors.quantity }"
                placeholder="0.00"
              />
              <p v-if="form.errors.quantity" class="mt-1 text-xs text-red-600">{{ form.errors.quantity }}</p>
            </div>
            <div>
              <label for="unit" class="block text-sm font-semibold text-gray-700 mb-2">
                Unit *
              </label>
              <select
                id="unit"
                v-model="form.data.unit"
                required
                class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm bg-white focus:border-green-500 focus:ring-2 focus:ring-green-500 transition"
                :class="{ 'border-red-500 ring-2 ring-red-200': form.errors.unit }"
              >
                <option value="bushels">Bushels</option>
              </select>
              <p v-if="form.errors.unit" class="mt-1 text-xs text-red-600">{{ form.errors.unit }}</p>
            </div>
          </div>
        </section>

        <!-- Harvester Share -->
        <section class="bg-gradient-to-br from-white to-gray-50 rounded-2xl p-6 border border-gray-200 shadow-sm">
          <div class="flex items-center mb-4">
             <div class="h-10 w-10 rounded-lg bg-orange-100 flex items-center justify-center mr-3">
               <svg class="h-5 w-5 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                 <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
               </svg>
             </div>
             <div>
               <h3 class="text-lg font-semibold text-gray-900">Harvester Share</h3>
               <p class="text-xs text-gray-600">Deduct share for hired harvesters</p>
             </div>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
             <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Share Percentage (%)</label>
                <div class="relative">
                   <input
                     v-model.number="form.data.harvester_share_percentage"
                     type="number"
                     min="0"
                     max="100"
                     step="0.01"
                     class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm focus:border-green-500 focus:ring-2 focus:ring-green-500"
                     placeholder="e.g. 10"
                   />
                   <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                     <span class="text-gray-500">%</span>
                   </div>
                </div>
                 <p class="text-xs text-gray-500 mt-1.5">
                   <template v-if="shareSourceLabel">{{ shareSourceLabel }}</template>
                   <template v-else>Default: 1 for every 8 farmer keeps (≈11.11%)</template>
                 </p>
                  <p class="text-xs text-gray-400 mt-0.5">Harvester pay is recorded as a crop expense at your harvest price.</p>
             </div>
             <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Share Amount ({{ form.data.unit || 'Units' }})</label>
                <input
                  v-model.number="form.data.harvester_share"
                  type="number"
                  readonly
                   class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm bg-gray-50 text-gray-500 cursor-not-allowed"
                   placeholder="Calculated amount"
                />
             </div>
             <div>
                 <label class="block text-sm font-semibold text-gray-700 mb-2">Your Net Share</label>
                 <div class="px-4 py-3 bg-green-50 border border-green-200 rounded-lg text-green-700 font-bold">
                    {{ (form.data.quantity - (form.data.harvester_share || 0)).toFixed(2) }} {{ form.data.unit }}
                 </div>
             </div>
          </div>
        </section>
        
        <!-- Pricing note -->
        <div class="bg-blue-50 border border-blue-200 rounded-xl px-4 py-3">
          <p class="text-sm text-blue-800">
            <span class="font-medium">💡 Pricing:</span> Price per unit is set when you add the milled rice to 
            <span class="font-semibold">My Products</span> in the marketplace.
          </p>
        </div>
        
        <!-- Notes -->
        <section class="bg-gradient-to-br from-white to-gray-50 rounded-2xl p-6 border border-gray-200 shadow-sm">
          <div class="flex items-center mb-4">
            <div class="h-10 w-10 rounded-lg bg-indigo-100 flex items-center justify-center mr-3">
              <svg class="h-5 w-5 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
              </svg>
            </div>
            <div>
              <h3 class="text-lg font-semibold text-gray-900">Additional Notes</h3>
              <p class="text-xs text-gray-600">Any additional information about this harvest</p>
            </div>
          </div>
          <div>
            <label for="notes" class="block text-sm font-semibold text-gray-700 mb-2">
              Notes
            </label>
            <textarea
              id="notes"
              v-model="form.data.notes"
              rows="4"
              class="w-full rounded-lg border border-gray-300 px-4 py-3 shadow-sm focus:border-green-500 focus:ring-2 focus:ring-green-500 transition resize-none"
              :class="{ 'border-red-500 ring-2 ring-red-200': form.errors.notes }"
              placeholder="e.g., Harvested from the north section. Excellent quality yield."
            ></textarea>
            <p v-if="form.errors.notes" class="mt-1 text-xs text-red-600">{{ form.errors.notes }}</p>
          </div>
        </section>

        <!-- Actions -->
        <div class="flex justify-end gap-3 pt-4 border-t border-gray-200">
          <button
            type="button"
            @click="closeModal"
            class="inline-flex items-center px-6 py-3 text-sm font-semibold rounded-lg border-2 border-gray-300 text-gray-700 bg-white hover:bg-gray-50 transition-colors"
          >
            Cancel
          </button>
          <button
            type="submit"
            :disabled="form.processing"
            class="inline-flex items-center px-6 py-3 text-sm font-semibold rounded-lg bg-gradient-to-r from-green-600 to-emerald-600 text-white hover:from-green-700 hover:to-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg hover:shadow-xl transition-all"
          >
            <LoadingSpinner v-if="form.processing" class="mr-2" />
            <svg v-if="!form.processing" class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
            </svg>
            {{ isEditMode ? 'Save Changes' : 'Create Harvest' }}
          </button>
        </div>
      </form>
      </div>
    </div>
  </Modal>
</template>

<script setup>
import { ref, watch, computed, onMounted } from 'vue'
import { useFarmStore } from '@/stores/farm'
import Modal from '@/Components/UI/Modal.vue'
import LoadingSpinner from '@/Components/UI/LoadingSpinner.vue'
import { useFormValidation } from '@/composables/useFormValidation'

const props = defineProps({
  show: {
    type: Boolean,
    default: false,
  },
  initialPlantingId: {
    type: Number,
    default: null,
  },
  harvest: {
    type: Object,
    default: null
  },
  isTaskCompletion: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['close', 'saved'])

const farmStore = useFarmStore()
const { errors: clientErrors, rules, validateForm, sanitizeForm, clearErrors } = useFormValidation()

// Default harvester share: 1 for every 8 farmer keeps → 1/9 ≈ 11.11%
const DEFAULT_HARVESTER_SHARE_PERCENTAGE = 11.11

// Track whether the share % came from a linked task
const shareSourceLabel = ref('')

const isEditMode = computed(() => !!props.harvest)

// Get harvestable plantings from the store
const harvestablePlantings = computed(() => {
  const allPlantings = farmStore.plantings || []
  
  // Filter to only show plantings that are at least "planted" (exclude "planned" status)
  // Allow: planted, growing, ready (but not planned, harvested, or failed)
  const validStatuses = ['planted', 'growing', 'ready']
  
  const plantings = allPlantings.filter(p => {
    if (!p || !p.id) return false
    
    // Always include the planting currently being edited, regardless of status
    if (props.harvest?.planting_id && p.id === props.harvest.planting_id) {
      return true
    }

    const status = String(p.status || '').toLowerCase()
    return validStatuses.includes(status)
  })
  
  // Debug logging when modal is open
  
  return plantings
})

// Helper to format dates for <input type="date">
const formatDateForInput = (dateString) => {
  if (!dateString) return ''
  try {
    const date = new Date(dateString)
    return date.toISOString().split('T')[0]
  } catch (e) {
    return ''
  }
}

const getInitialFormData = () => ({
  planting_id: props.harvest?.planting_id || props.initialPlantingId || '',
  harvest_date: formatDateForInput(props.harvest?.harvest_date),
  quantity: props.harvest?.quantity || '',
  unit: props.harvest?.unit || 'bushels',
  notes: props.harvest?.notes || '',
  harvester_share: props.harvest?.harvester_share || '',
  harvester_share_percentage: props.harvest?.harvester_share_percentage ?? DEFAULT_HARVESTER_SHARE_PERCENTAGE,
})

const form = ref({
  data: getInitialFormData(),
  errors: {},
  processing: false,
})

// Watch for the modal to open and reset the form
watch(() => props.show, async (newVal) => {
  if (newVal) {
    form.value.data = getInitialFormData()
    form.value.errors = {}
    form.value.processing = false
    shareSourceLabel.value = ''
    // Always fetch plantings, fields, and tasks when modal opens
    try {
      await farmStore.fetchPlantings()
      
      if (farmStore.fields.length === 0) {
        await farmStore.fetchFields()
      }

      // Fetch tasks so we can look up share percentages from harvesting tasks
      await farmStore.fetchTasks()
    } catch (err) {
      console.error('Failed to load plantings/fields/tasks:', err)
      form.value.errors.general = "Could not load plantings list. Please try again."
    }

    // If a planting is already selected (e.g. from initialPlantingId), apply task share
    if (form.value.data.planting_id && !isEditMode.value) {
      applyTaskSharePercentage(form.value.data.planting_id)
    }
  }
})

// When planting changes, check for a linked harvesting task with share payment
watch(() => form.value.data.planting_id, (newPlantingId) => {
  if (newPlantingId && !isEditMode.value) {
    applyTaskSharePercentage(newPlantingId)
  }
})

// Look up harvesting tasks with share payment for a given planting
const applyTaskSharePercentage = (plantingId) => {
  const tasks = farmStore.tasks || []
  const shareTask = tasks.find(t =>
    t.planting_id == plantingId &&
    t.task_type === 'harvesting' &&
    t.payment_type === 'share' &&
    t.revenue_share_percentage
  )

  if (shareTask) {
    form.value.data.harvester_share_percentage = parseFloat(shareTask.revenue_share_percentage)
    const laborerName = shareTask.laborer?.name || shareTask.laborer_group?.name
    shareSourceLabel.value = laborerName
      ? `From task: ${laborerName} (${shareTask.revenue_share_percentage}%)`
      : `From linked harvesting task (${shareTask.revenue_share_percentage}%)`
  } else {
    form.value.data.harvester_share_percentage = DEFAULT_HARVESTER_SHARE_PERCENTAGE
    shareSourceLabel.value = ''
  }
}

// Auto-calculate harvester share
watch(() => [form.value.data.quantity, form.value.data.harvester_share_percentage], ([qty, pct]) => {
   if (qty && pct) {
      const share = (parseFloat(qty) * (parseFloat(pct) / 100));
      form.value.data.harvester_share = parseFloat(share.toFixed(2));
   } else {
      form.value.data.harvester_share = 0;
   }
})

const submitForm = async () => {
  form.value.processing = true
  form.value.errors = {}
  
  clearErrors()
  sanitizeForm(form.value.data)
  
  const isValid = validateForm(form.value.data, {
    notes: [rules.maxLength(2000), rules.noEmoji],
    quantity: [rules.required, rules.numeric, rules.minValue(0)],
    harvester_share: [rules.numeric, rules.minValue(0)],
    harvester_share_percentage: [rules.numeric, rules.minValue(0)]
  })
  
  if (!isValid) {
    for (const [key, msg] of Object.entries(clientErrors.value)) {
       form.value.errors[key] = msg;
    }
    form.value.errors.general = 'Please fix the highlighted errors before submitting.';
    form.value.processing = false;
    return;
  }

  // Clean the form data - convert empty strings to null and ensure proper types
  const payload = { ...form.value.data }
  
  // Convert empty strings to null for optional fields
  if (payload.notes === '') payload.notes = null
  if (payload.harvester_share === '') payload.harvester_share = null
  if (payload.harvester_share_percentage === '') payload.harvester_share_percentage = null
  
  // Ensure numeric fields are numbers
  if (payload.quantity) payload.quantity = parseFloat(payload.quantity)
  
  // Ensure planting_id is a number
  if (payload.planting_id) payload.planting_id = Number(payload.planting_id)

  try {
    if (isEditMode.value) {
      await farmStore.updateHarvest(props.harvest.id, payload)
    } else {
      await farmStore.createHarvest(payload)
    }
    // Refresh harvests list after create/update
    await farmStore.fetchHarvests()
    emit('saved')
    closeModal() // Close modal on success
  } catch (err) {
    if (err.response && err.response.status === 422) {
      form.value.errors = err.response.data.errors || {}
      form.value.errors.general = err.response.data.message || 'Validation failed.'
    } else {
      form.value.errors.general = err.response?.data?.message || 'An unexpected error occurred. Please try again.'
    }
    console.error('Form submission error:', err)
  } finally {
    form.value.processing = false
  }
}

const closeModal = () => {
  emit('close')
}

const handleModelValueUpdate = (value) => {
  if (!value) {
    closeModal()
  }
}

// Helper for planting dropdown
const formatDate = (value) => {
  if (!value) return 'N/A'
  try {
    const date = new Date(value)
    return date.toLocaleDateString(undefined, { month: 'short', day: 'numeric' })
  } catch (e) {
    return value
  }
}

// Helper to get display name for planting in dropdown
const getPlantingDisplayName = (planting) => {
  if (!planting) return 'Unknown Planting'
  
  const parts = []
  
  // Add crop type or rice variety name
  if (planting.rice_variety?.name) {
    parts.push(planting.rice_variety.name)
  } else if (planting.crop_type) {
    parts.push(planting.crop_type)
  } else {
    parts.push('Rice')
  }
  
  // Add field name
  if (planting.field?.name) {
    parts.push(`on ${planting.field.name}`)
  } else if (planting.field_id) {
    parts.push(`on Field #${planting.field_id}`)
  }
  
  // Add planting date
  if (planting.planting_date) {
    parts.push(`(Planted: ${formatDate(planting.planting_date)})`)
  }
  
  // Add status if not standard
  if (planting.status && !['growing', 'ready'].includes(planting.status)) {
    parts.push(`[${planting.status}]`)
  }
  
  return parts.join(' ') || `Planting #${planting.id}`
}
</script>