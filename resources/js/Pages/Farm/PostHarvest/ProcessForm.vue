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
                  {{ isCompletionMode ? 'Complete Process' : (processToEdit ? 'Edit Process Step' : 'Add Processing Step') }}
                </h3>
                <p v-if="isCompletionMode" class="text-sm text-slate-500 mt-0.5">Finalize yields and close this workflow.</p>
              </div>
            </div>
            <button @click="closeModal" class="rounded-md bg-white text-slate-400 hover:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
              <span class="sr-only">Close</span>
              <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" /></svg>
            </button>
          </div>

          <div class="px-6 py-6 sm:px-8 max-h-[70vh] overflow-y-auto">
            <form @submit.prevent="saveProcess" class="space-y-8">
              
              <div class="space-y-5">
                <div v-if="!isCompletionMode && !processToEdit">
                  <label class="block text-sm font-medium leading-6 text-slate-900 mb-2">Process Type</label>
                  <div class="flex rounded-lg bg-slate-100 p-1 sm:w-max">
                    <button v-for="type in ['threshing', 'drying', 'milling']" :key="type" type="button" 
                      @click="form.process_type = type"
                      :class="[form.process_type === type ? 'bg-white shadow-sm ring-1 ring-slate-900/5 text-slate-900' : 'text-slate-500 hover:text-slate-700']"
                      class="flex-1 sm:flex-none w-32 px-3 py-1.5 text-sm font-medium rounded-md capitalize transition-all duration-200">
                      {{ type }}
                    </button>
                  </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  <div>
                    <label class="block text-sm font-medium leading-6 text-slate-900">Input Material</label>
                    <div class="mt-2 relative flex rounded-md shadow-sm">
                      <input type="number" step="0.01" v-model="form.input_quantity" :disabled="isCompletionMode" 
                        class="relative -mr-px block w-full min-w-0 rounded-l-md border-0 px-3 py-2 text-slate-900 ring-1 ring-inset ring-slate-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6 disabled:bg-slate-50 disabled:text-slate-500" placeholder="0.00">
                      <select v-model="form.input_unit" :disabled="isCompletionMode" 
                        class="relative block w-1/3 rounded-r-md border-0 bg-transparent py-2 pl-3 pr-7 text-slate-500 ring-1 ring-inset ring-slate-300 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6 disabled:bg-slate-50">
                        <option value="bushels">bushels</option>
                      </select>
                    </div>
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
                    <label class="block text-sm font-medium leading-6 text-slate-700">Output Quantity</label>
                    <div class="mt-2 relative flex rounded-md shadow-sm">
                      <input type="number" step="0.01" v-model="form.output_quantity" required 
                        class="relative -mr-px block w-full min-w-0 rounded-l-md border-0 px-3 py-2 text-slate-900 ring-1 ring-inset ring-emerald-300 placeholder:text-slate-400 focus:ring-2 focus:ring-inset focus:ring-emerald-600 sm:text-sm sm:leading-6" placeholder="0.00">
                      <select v-model="form.output_unit" required 
                        class="relative block w-1/3 rounded-r-md border-0 bg-transparent py-2 pl-3 pr-7 text-slate-700 ring-1 ring-inset ring-emerald-300 focus:ring-2 focus:ring-inset focus:ring-emerald-600 sm:text-sm sm:leading-6">
                        <option value="bushels">bushels</option>
                      </select>
                    </div>
                  </div>
                  <div>
                    <label class="block text-sm font-medium leading-6 text-slate-700">Completion Date</label>
                    <input type="date" v-model="form.completed_date" required 
                      class="mt-2 block w-full rounded-md border-0 px-3 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-emerald-300 focus:ring-2 focus:ring-inset focus:ring-emerald-600 sm:text-sm sm:leading-6">
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

                  <div v-if="form.cost_type === 'self'" class="relative flex items-start mt-4">
                    <div class="flex h-6 items-center">
                      <input id="assign-labor" v-model="assignLaborers" type="checkbox" class="h-4 w-4 rounded border-slate-300 text-blue-600 focus:ring-blue-600">
                    </div>
                    <div class="ml-3 text-sm leading-6">
                      <label for="assign-labor" class="font-medium text-slate-900">Assign Laborers</label>
                      <p class="text-slate-500">Automatically generate a task to track worker hours for this process.</p>
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
import { ref, onMounted, watch } from 'vue';
import axios from 'axios';

const props = defineProps({
  isOpen: Boolean,
  harvestId: [String, Number],
  parentProcessId: [String, Number],
  processToEdit: Object,
  isCompletionMode: Boolean,
  defaultType: String
});

const emit = defineEmits(['close', 'saved']);

const loading = ref(false);
const assignLaborers = ref(false);
const saveError = ref('');

const defaultForm = () => ({
  harvest_id: props.harvestId,
  parent_process_id: props.parentProcessId,
  process_type: props.defaultType || 'threshing',
  process_date: new Date().toISOString().split('T')[0],
  input_quantity: null,
  input_unit: 'bushels',
  output_quantity: null,
  output_unit: 'bushels',
  completed_date: new Date().toISOString().split('T')[0],
  status: 'pending',
  cost_type: 'self',
  cost: null,
  cost_per_unit: null,
  service_provider: '',
  notes: ''
});

const form = ref(defaultForm());

onMounted(() => {
  if (props.processToEdit) {
    const p = props.processToEdit;
    form.value = {
      ...form.value,
      ...p,
      process_date: p.process_date ? p.process_date.split('T')[0] : form.value.process_date,
      completed_date: new Date().toISOString().split('T')[0],
      output_unit: p.input_unit || 'bushels'
    };
  }
});

// Re-sync form fields from latest props when modal reopens
watch(() => props.isOpen, (isOpen) => {
  if (isOpen) {
    saveError.value = '';
    if (props.processToEdit) {
      const p = props.processToEdit;
      form.value = {
        ...defaultForm(),
        ...p,
        harvest_id: props.harvestId,
        process_date: p.process_date ? p.process_date.split('T')[0] : new Date().toISOString().split('T')[0],
        completed_date: new Date().toISOString().split('T')[0],
        output_unit: p.input_unit || 'bushels',
      };
    } else {
      form.value = defaultForm();
      form.value.harvest_id = props.harvestId;
      form.value.parent_process_id = props.parentProcessId;
      if (props.defaultType) {
        form.value.process_type = props.defaultType;
      }
    }
  }
});

const closeModal = () => {
  emit('close');
};

const formatNumber = (num) => {
  return Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
};

const saveProcess = async () => {
  loading.value = true;
  saveError.value = '';
  
  try {
    const payload = { ...form.value, assign_laborers: assignLaborers.value };

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
