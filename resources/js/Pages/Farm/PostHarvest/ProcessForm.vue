<template>
  <div v-if="isOpen" class="relative z-50" aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="fixed inset-0 bg-slate-900/40 backdrop-blur-sm transition-opacity" @click="closeModal" aria-hidden="true"></div>

    <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
      <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
        
        <div class="relative w-full max-w-2xl transform overflow-hidden rounded-2xl bg-white text-left align-middle shadow-2xl ring-1 ring-slate-200 transition-all sm:my-8">
          
          <div class="border-b border-slate-100 bg-white px-6 py-5 sm:px-8 flex items-center justify-between">
            <div class="flex items-center gap-3">
              <div :class="[isCompletionMode ? 'bg-emerald-100 text-emerald-600' : 'bg-blue-100 text-blue-600']" class="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-full sm:h-8 sm:w-8">
                <svg v-if="isCompletionMode" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" /></svg>
                <svg v-else-if="processToEdit" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" /></svg>
                <svg v-else class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" /></svg>
              </div>
              <div>
                <h3 class="text-lg font-semibold leading-6 text-slate-900" id="modal-title">
                  {{ isCompletionMode ? 'Complete Process' : (processToEdit ? 'Edit Process Step' : modalTitle) }}
                </h3>
                <p v-if="isCompletionMode" class="text-sm text-slate-500 mt-0.5">Finalize yields and close this workflow.</p>
                <p v-else class="text-sm text-slate-500 mt-0.5">{{ processTypeLabel }} step</p>
              </div>
            </div>
            <button @click="closeModal" class="rounded-md bg-white text-slate-400 hover:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
              <span class="sr-only">Close</span>
              <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" /></svg>
            </button>
          </div>

          <div class="px-6 py-6 sm:px-8 max-h-[70vh] overflow-y-auto">
            <form @submit.prevent="saveProcess" class="space-y-8">
              
              <!-- Process type is now fixed — show as a read-only badge -->
              <div v-if="!isCompletionMode && !processToEdit">
                <label class="block text-sm font-medium leading-6 text-slate-900 mb-2">Process Type</label>
                <div class="inline-flex items-center px-4 py-2 rounded-lg bg-slate-100 text-slate-900 font-medium text-sm capitalize">
                  {{ form.process_type }}
                </div>
              </div>

              <div class="space-y-5">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  <div>
                    <label class="block text-sm font-medium leading-6" :class="validationErrors.input_quantity ? 'text-red-600' : 'text-slate-900'">
                      Input Material
                      <span v-if="validationErrors.input_quantity" class="ml-1 font-normal">— {{ validationErrors.input_quantity }}</span>
                    </label>
                    <div class="mt-2 relative flex rounded-md shadow-sm">
                      <input type="number" step="0.01" v-model="form.input_quantity" :disabled="isCompletionMode" 
                        @input="clearError('input_quantity')"
                        :class="validationErrors.input_quantity
                          ? 'ring-red-400 focus:ring-red-500'
                          : 'ring-slate-300 focus:ring-blue-600'"
                        class="relative -mr-px block w-full min-w-0 rounded-l-md border-0 px-3 py-2 text-slate-900 ring-1 ring-inset placeholder:text-slate-400 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6 disabled:bg-slate-50 disabled:text-slate-500" placeholder="0.00">
                      <div :class="validationErrors.input_quantity ? 'bg-red-50 text-red-600 ring-red-400' : 'bg-slate-50 text-slate-500 ring-slate-300'" class="relative flex items-center rounded-r-md border-0 py-2 pl-3 pr-4 ring-1 ring-inset sm:text-sm">
                        {{ displayUnit(inputUnitLabel) }}
                      </div>
                    </div>
                    <p v-if="props.processType === 'threshing' && props.harvestQuantity" class="mt-1.5 text-xs text-slate-500">
                      Max: <span class="font-medium">{{ props.harvestQuantity }} {{ displayUnit(inputUnitLabel) }}</span>
                      <span class="text-amber-600"> (after harvester share deduction)</span>
                    </p>
                  </div>

                  <div v-if="!isCompletionMode">
                    <label class="block text-sm font-medium leading-6 text-slate-900">Date Started</label>
                    <input type="date" v-model="form.process_date" 
                      class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6">
                  </div>
                </div>
              </div>

              <div v-if="isCompletionMode" class="rounded-xl bg-slate-50 p-6 ring-1 ring-inset ring-slate-200/50">
                <h4 class="text-sm font-semibold leading-6 text-slate-900 mb-4 flex items-center gap-2">
                  <svg class="h-4 w-4 text-emerald-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clip-rule="evenodd" /></svg>
                  Final Yield Output
                </h4>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  <div>
                    <label class="block text-sm font-medium leading-6" :class="validationErrors.output_quantity ? 'text-red-600' : 'text-slate-700'">
                      Output Quantity
                      <span v-if="validationErrors.output_quantity" class="ml-1 font-normal">— {{ validationErrors.output_quantity }}</span>
                    </label>
                    <div class="mt-2 relative flex rounded-md shadow-sm">
                      <input type="number" step="0.01" v-model="form.output_quantity"
                        @input="clearError('output_quantity')"
                        :class="validationErrors.output_quantity
                          ? 'ring-red-400 focus:ring-red-500'
                          : 'ring-emerald-300 focus:ring-emerald-600'"
                        class="relative -mr-px block w-full min-w-0 rounded-l-md border-0 px-3 py-2 text-slate-900 ring-1 ring-inset placeholder:text-slate-400 focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6" placeholder="0.00">
                      <div :class="validationErrors.output_quantity ? 'bg-red-50 text-red-600 ring-red-400' : 'bg-emerald-50 text-emerald-700 ring-emerald-300'"
                        class="relative flex items-center rounded-r-md border-0 py-2 pl-3 pr-4 ring-1 ring-inset sm:text-sm font-medium">
                        {{ displayUnit(outputUnitLabel) }}
                      </div>
                    </div>
                  </div>
                  <div>
                    <label class="block text-sm font-medium leading-6" :class="validationErrors.completed_date ? 'text-red-600' : 'text-slate-700'">
                      Completion Date
                      <span v-if="validationErrors.completed_date" class="ml-1 font-normal">— {{ validationErrors.completed_date }}</span>
                    </label>
                    <input type="date" v-model="form.completed_date"
                      @change="clearError('completed_date')"
                      :class="validationErrors.completed_date
                        ? 'ring-red-400 focus:ring-red-500'
                        : 'ring-emerald-300 focus:ring-emerald-600'"
                      class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset focus:ring-2 focus:ring-inset sm:text-sm sm:leading-6">
                  </div>
                </div>
              </div>

              <hr class="border-slate-100" />

              <div>
                <div class="flex items-center justify-between mb-4">
                  <h4 class="text-sm font-semibold leading-6 text-slate-900">Provider & Cost</h4>
                </div>
                
                <div class="flex rounded-lg bg-slate-100 p-1 mb-5 sm:w-max">
                  <button v-for="mode in [{id:'self', label:'In-house / Self'}, {id:'service_fixed', label:'Fixed Provider'}, {id:'service_per_unit', label:'Per Unit Provider'}]" 
                    :key="mode.id" type="button" @click="form.cost_type = mode.id"
                    :class="[form.cost_type === mode.id ? 'bg-white shadow-sm ring-1 ring-slate-900/5 text-slate-900' : 'text-slate-500 hover:text-slate-700']"
                    class="px-4 py-1.5 text-sm font-medium rounded-md transition-all duration-200">
                    {{ mode.label }}
                  </button>
                </div>

                <div class="space-y-5">
                  <div v-if="form.cost_type !== 'self'">
                    <label class="block text-sm font-medium leading-6 text-slate-900">Service Provider Name</label>
                    <input type="text" v-model="form.service_provider" placeholder="e.g. Local Mill Co." 
                      class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6">
                  </div>

                  <div v-if="form.cost_type !== 'service_per_unit'" class="sm:w-1/2">
                    <label class="block text-sm font-medium leading-6 text-slate-900">
                      {{ form.cost_type === 'self' ? 'Equipment / Fuel Cost' : 'Total Fixed Cost' }}
                    </label>
                    <div class="mt-2 relative rounded-md shadow-sm">
                      <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                        <span class="text-slate-500 sm:text-sm">₱</span>
                      </div>
                      <input type="number" step="0.01" v-model="form.cost" 
                        class="block w-full rounded-md border-0 py-2 pl-8 pr-3 text-slate-900 ring-1 ring-inset ring-slate-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6" placeholder="0.00">
                    </div>
                  </div>

                  <div v-if="form.cost_type === 'service_per_unit'" class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                      <label class="block text-sm font-medium leading-6 text-slate-900">Cost Per Unit</label>
                      <div class="mt-2 relative rounded-md shadow-sm">
                        <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                          <span class="text-slate-500 sm:text-sm">₱</span>
                        </div>
                        <input type="number" step="0.01" v-model="form.cost_per_unit" 
                          class="block w-full rounded-md border-0 py-2 pl-8 pr-3 text-slate-900 ring-1 ring-inset ring-slate-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6" placeholder="0.00">
                      </div>
                    </div>
                    <div>
                      <label class="block text-sm font-medium leading-6 text-slate-500">Estimated Total</label>
                      <div class="mt-2 py-2 text-lg font-semibold text-slate-900">
                        ₱{{ formatNumber((form.cost_per_unit || 0) * (form.input_quantity || 0)) }}
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <hr class="border-slate-100" />

              <!-- Laborer Assignment (optional, not shown on completion) -->
              <div v-if="!isCompletionMode">
                <div class="relative flex items-start">
                  <div class="flex h-6 items-center">
                    <input id="assign-labor" v-model="assignLaborers" type="checkbox" class="h-4 w-4 rounded border-slate-300 text-blue-600 focus:ring-blue-600">
                  </div>
                  <div class="ml-3 text-sm leading-6">
                    <label for="assign-labor" class="font-medium text-slate-900">Assign Laborers (Optional)</label>
                    <p class="text-slate-500">Automatically generate a task to track worker hours for this process.</p>
                  </div>
                </div>

                <div v-if="assignLaborers" class="mt-4 rounded-xl bg-slate-50 p-5 ring-1 ring-inset ring-slate-200/50 space-y-5">
                  <!-- Laborer or Group Selection -->
                  <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                    <div>
                      <label class="block text-sm font-medium leading-6 text-slate-900">Laborer</label>
                      <select v-model="form.assigned_to"
                        class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6">
                        <option :value="null">-- Select Laborer --</option>
                        <option v-for="laborer in laborers" :key="laborer.id" :value="laborer.id">
                          {{ laborer.name }}
                        </option>
                      </select>
                    </div>
                    <div>
                      <label class="block text-sm font-medium leading-6 text-slate-900">Or Laborer Group</label>
                      <select v-model="form.laborer_group_id"
                        class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6">
                        <option :value="null">-- Select Group --</option>
                        <option v-for="group in laborerGroups" :key="group.id" :value="group.id">
                          {{ group.name }}
                        </option>
                      </select>
                    </div>
                  </div>

                  <!-- Payment Type -->
                  <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                    <div>
                      <label class="block text-sm font-medium leading-6 text-slate-900">Payment Type</label>
                      <select v-model="form.payment_type"
                        class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6">
                        <option value="wage">Wage (Fixed)</option>
                        <option value="piece_rate">Piece Rate</option>
                        <option value="share">Revenue Share</option>
                      </select>
                    </div>
                    <div v-if="form.payment_type !== 'share'">
                      <label class="block text-sm font-medium leading-6 text-slate-900">Wage Amount (₱)</label>
                      <div class="mt-2 relative rounded-md shadow-sm">
                        <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                          <span class="text-slate-500 sm:text-sm">₱</span>
                        </div>
                        <input type="number" step="0.01" v-model="form.wage_amount"
                          class="block w-full rounded-md border-0 py-2 pl-8 pr-3 text-slate-900 ring-1 ring-inset ring-slate-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6" placeholder="0.00">
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <hr class="border-slate-100" />

              <div>
                <label class="block text-sm font-medium leading-6 text-slate-900">Additional Notes</label>
                <div class="mt-2">
                  <textarea v-model="form.notes" rows="2" class="block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6" placeholder="Add any details about conditions, quality, etc..."></textarea>
                </div>
              </div>

              <div v-if="saveError" class="rounded-md bg-red-50 p-4">
                <div class="flex">
                  <div class="flex-shrink-0">
                    <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.28 7.22a.75.75 0 00-1.06 1.06L8.94 10l-1.72 1.72a.75.75 0 101.06 1.06L10 11.06l1.72 1.72a.75.75 0 101.06-1.06L11.06 10l1.72-1.72a.75.75 0 00-1.06-1.06L10 8.94 8.28 7.22z" clip-rule="evenodd" /></svg>
                  </div>
                  <div class="ml-3">
                    <p class="text-sm text-red-800">{{ saveError }}</p>
                  </div>
                </div>
              </div>

            </form>
          </div>

          <div class="bg-slate-50 px-6 py-4 sm:px-8 border-t border-slate-100 sm:flex sm:flex-row-reverse">
            <button type="button" @click="saveProcess" :disabled="loading" 
              class="inline-flex w-full justify-center rounded-md bg-slate-900 px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-slate-700 focus:outline-none focus:ring-2 focus:ring-slate-900 focus:ring-offset-2 sm:ml-3 sm:w-auto transition-colors disabled:opacity-50 disabled:cursor-not-allowed">
              <svg v-if="loading" class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
              {{ isCompletionMode ? 'Confirm & Record' : 'Save Details' }}
            </button>
            <button type="button" @click="closeModal" 
              class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-5 py-2 text-sm font-semibold text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 hover:bg-slate-50 focus:outline-none focus:ring-2 focus:ring-blue-600 focus:ring-offset-2 sm:mt-0 sm:w-auto transition-colors">
              Cancel
            </button>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import axios from 'axios';

const props = defineProps({
  isOpen: Boolean,
  harvestId: [String, Number],
  parentProcessId: [String, Number],
  processToEdit: Object,
  isCompletionMode: Boolean,
  processType: String,        // Fixed process type determined by pipeline position
  riceVarietyName: String,    // Variety name for milling output label
  harvestQuantity: [String, Number],
});

const emit = defineEmits(['close', 'saved']);

const loading = ref(false);
const assignLaborers = ref(false);
const saveError = ref('');
const validationErrors = ref({});

// Laborer data
const laborers = ref([]);
const laborerGroups = ref([]);

// Unit label helpers based on process type
const UNIT_MAP = {
  threshing: { input: 'bushels', output: 'sacks_palay' },
  drying:    { input: 'sacks_palay',   output: 'dried palay' },
  milling:   { input: 'dried palay', output: 'sacks_rice' },
};

// Human-readable display labels
const UNIT_DISPLAY_MAP = {
  sacks_palay: 'sacks (palay)',
  sacks_rice: 'sacks (rice)',
};

const displayUnit = (unit) => {
  return UNIT_DISPLAY_MAP[unit] || unit;
};

const inputUnitLabel = computed(() => {
  const type = form.value.process_type || props.processType;
  return UNIT_MAP[type]?.input || 'bushels';
});

const outputUnitLabel = computed(() => {
  const type = form.value.process_type || props.processType;
  if (type === 'milling' && props.riceVarietyName) {
    return UNIT_MAP[type]?.output || 'sacks_rice';
  }
  return UNIT_MAP[type]?.output || 'sacks_palay';
});

const processTypeLabel = computed(() => {
  const type = form.value.process_type || props.processType;
  return type ? type.charAt(0).toUpperCase() + type.slice(1) : '';
});

const modalTitle = computed(() => {
  const type = form.value.process_type || props.processType;
  return type ? `Start ${type.charAt(0).toUpperCase() + type.slice(1)}` : 'Add Processing Step';
});

const defaultForm = () => ({
  harvest_id: props.harvestId,
  parent_process_id: props.parentProcessId,
  process_type: props.processType || 'threshing',
  process_date: new Date().toISOString().split('T')[0],
  input_quantity: null,
  input_unit: UNIT_MAP[props.processType]?.input || 'bushels',
  output_quantity: null,
  output_unit: UNIT_MAP[props.processType]?.output || 'sacks_palay',
  completed_date: new Date().toISOString().split('T')[0],
  status: 'pending',
  cost_type: 'self',
  cost: null,
  cost_per_unit: null,
  service_provider: '',
  notes: '',
  // Laborer fields
  assigned_to: null,
  laborer_group_id: null,
  payment_type: 'wage',
  wage_amount: null,
});

const form = ref(defaultForm());

// Fetch laborers and groups
const fetchLaborers = async () => {
  try {
    const [laborerRes, groupRes] = await Promise.all([
      axios.get('/api/laborers'),
      axios.get('/api/laborers/groups'),
    ]);
    laborers.value = laborerRes.data.laborers || laborerRes.data || [];
    laborerGroups.value = groupRes.data.groups || groupRes.data || [];
  } catch (error) {
    console.warn('Failed to fetch laborers:', error);
  }
};

onMounted(() => {
  fetchLaborers();
  if (props.processToEdit) {
    const p = props.processToEdit;
    form.value = {
      ...form.value,
      ...p,
      process_date: p.process_date ? p.process_date.split('T')[0] : form.value.process_date,
      completed_date: new Date().toISOString().split('T')[0],
      output_unit: UNIT_MAP[p.process_type]?.output || p.input_unit || 'sacks_palay',
      assigned_to: null,
      laborer_group_id: null,
      payment_type: 'wage',
      wage_amount: null,
    };
  }
});

// Re-sync form fields from latest props when modal reopens
watch(() => props.isOpen, (isOpen) => {
  if (isOpen) {
    saveError.value = '';
    validationErrors.value = {};
    assignLaborers.value = false;
    fetchLaborers();
    if (props.processToEdit) {
      const p = props.processToEdit;
      form.value = {
        ...defaultForm(),
        ...p,
        harvest_id: props.harvestId,
        process_type: props.processType || p.process_type,
        process_date: p.process_date ? p.process_date.split('T')[0] : new Date().toISOString().split('T')[0],
        completed_date: new Date().toISOString().split('T')[0],
        output_unit: UNIT_MAP[props.processType || p.process_type]?.output || p.input_unit || 'sacks_palay',
        assigned_to: null,
        laborer_group_id: null,
        payment_type: 'wage',
        wage_amount: null,
      };
    } else {
      form.value = defaultForm();
      form.value.harvest_id = props.harvestId;
      form.value.parent_process_id = props.parentProcessId;
      if (props.processType) {
        form.value.process_type = props.processType;
        form.value.input_unit = UNIT_MAP[props.processType]?.input || 'bushels';
        form.value.output_unit = UNIT_MAP[props.processType]?.output || 'sacks_palay';
      }
    }
  }
});

// Clear laborer_group when laborer is selected and vice versa
watch(() => form.value.assigned_to, (val) => {
  if (val) form.value.laborer_group_id = null;
});
watch(() => form.value.laborer_group_id, (val) => {
  if (val) form.value.assigned_to = null;
});

const closeModal = () => {
  emit('close');
};

const formatNumber = (num) => {
  return Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
};

const clearError = (field) => {
  if (validationErrors.value[field]) {
    const errs = { ...validationErrors.value };
    delete errs[field];
    validationErrors.value = errs;
  }
};

const validate = () => {
  const errors = {};
  const type = form.value.process_type || props.processType;
  
  if (props.isCompletionMode) {
    if (!form.value.output_quantity || Number(form.value.output_quantity) <= 0) {
      errors.output_quantity = 'Required';
    }
    if (!form.value.completed_date) {
      errors.completed_date = 'Required';
    }
  } else {
    if (!form.value.input_quantity || Number(form.value.input_quantity) <= 0) {
      errors.input_quantity = 'Required';
    } else if (type === 'threshing' && props.harvestQuantity && Number(form.value.input_quantity) > Number(props.harvestQuantity)) {
      errors.input_quantity = `Cannot exceed net harvest quantity (${props.harvestQuantity} — after harvester share deduction)`;
    }
    if (!form.value.process_date) {
      errors.process_date = 'Required';
    }
  }
  validationErrors.value = errors;
  return Object.keys(errors).length === 0;
};

const saveProcess = async () => {
  saveError.value = '';
  if (!validate()) return;

  loading.value = true;
  
  try {
    // Set the correct units before saving
    const processType = form.value.process_type;
    const payload = {
      ...form.value,
      assign_laborers: assignLaborers.value,
      input_unit: UNIT_MAP[processType]?.input || 'bushels',
      output_unit: UNIT_MAP[processType]?.output || 'sacks_palay',
    };

    // Include laborer fields if assigning
    if (assignLaborers.value) {
      payload.assigned_to = form.value.assigned_to;
      payload.laborer_group_id = form.value.laborer_group_id;
      payload.payment_type = form.value.payment_type;
      payload.wage_amount = form.value.wage_amount;
    }

    if (props.isCompletionMode) {
      await axios.post(`/api/post-harvest/${props.processToEdit.id}/complete`, payload);
    } else if (props.processToEdit) {
      await axios.put(`/api/post-harvest/${props.processToEdit.id}`, payload);
    } else {
      await axios.post('/api/post-harvest', payload);
    }
    form.value = defaultForm();
    emit('saved');
    emit('close');
  } catch (error) {
    console.error('Failed to save process', error);
    saveError.value = error.response?.data?.message || 'Failed to save. Please check your inputs and try again.';
  } finally {
    loading.value = false;
  }
};

</script>
