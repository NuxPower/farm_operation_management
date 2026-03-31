<template>
  <div v-if="isOpen" class="fixed z-10 inset-0 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true" @click="closeModal"></div>

      <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

      <div class="inline-block align-bottom bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6 text-gray-900">
        <div>
          <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
            {{ isCompletionMode ? 'Complete Post-Harvest Process' : (processToEdit ? 'Edit Process Step' : 'Add Processing Step') }}
          </h3>
          <div class="mt-4">
            
            <form @submit.prevent="saveProcess" class="space-y-4">
              
              <!-- Process Type -->
              <div>
                <label class="block text-sm font-medium text-gray-700">Process Type</label>
                <select v-model="form.process_type" :disabled="isCompletionMode || processToEdit" class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-primary focus:border-primary sm:text-sm rounded-md">
                  <option value="threshing">Threshing</option>
                  <option value="drying">Drying</option>
                  <option value="milling">Milling</option>
                </select>
              </div>

              <!-- Input Quantity -->
              <div class="grid grid-cols-2 gap-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700">Input Quantity</label>
                  <input type="number" step="0.01" v-model="form.input_quantity" :disabled="isCompletionMode" class="mt-1 focus:ring-primary focus:border-primary block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Input Unit</label>
                  <select v-model="form.input_unit" :disabled="isCompletionMode" class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-primary focus:border-primary sm:text-sm rounded-md">
                    <option value="kg">Kilograms (kg)</option>
                    <option value="sacks">Sacks</option>
                    <option value="tons">Tons</option>
                    <option value="tons">Bags</option>
                  </select>
                </div>
              </div>

              <!-- Output Quantity (Only in Completion Mode) -->
              <div v-if="isCompletionMode" class="p-4 bg-emerald-50 rounded-md border border-emerald-200">
                <h4 class="text-sm font-medium text-emerald-800 mb-3">Record Output Details</h4>
                <div class="grid grid-cols-2 gap-4">
                  <div>
                    <label class="block text-sm font-medium text-gray-700">Final Output Quantity</label>
                    <input type="number" step="0.01" v-model="form.output_quantity" required class="mt-1 focus:ring-emerald-500 focus:border-emerald-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                  </div>
                  <div>
                    <label class="block text-sm font-medium text-gray-700">Final Output Unit</label>
                    <select v-model="form.output_unit" required class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 sm:text-sm rounded-md">
                      <option value="kg">Kilograms (kg)</option>
                      <option value="sacks">Sacks</option>
                      <option value="tons">Tons</option>
                      <option value="bags">Bags</option>
                    </select>
                  </div>
                  <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700">Date Completed</label>
                    <input type="date" v-model="form.completed_date" required class="mt-1 focus:ring-emerald-500 focus:border-emerald-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                  </div>
                </div>
                <p class="text-xs text-emerald-600 mt-2">This will deduct {{ form.input_quantity }} {{ form.input_unit }} from your inventory, and add the output as a new tracked product.</p>
              </div>

              <!-- Date Started -->
              <div v-if="!isCompletionMode">
                <label class="block text-sm font-medium text-gray-700">Date Started</label>
                <input type="date" v-model="form.process_date" class="mt-1 focus:ring-primary focus:border-primary block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
              </div>

              <!-- Cost Options -->
              <div class="border-t border-gray-200 pt-4">
                <h4 class="text-sm font-medium text-gray-900 mb-2">Cost & Provider Details</h4>
                
                <div class="space-y-4">
                  <div>
                    <label class="text-sm font-medium text-gray-700">How was this handled?</label>
                    <div class="mt-2 flex items-center space-x-4">
                      <label class="inline-flex items-center">
                        <input type="radio" v-model="form.cost_type" value="self" class="form-radio text-primary border-gray-300">
                        <span class="ml-2 text-sm text-gray-700">Self/Own Labor</span>
                      </label>
                      <label class="inline-flex items-center">
                        <input type="radio" v-model="form.cost_type" value="service_fixed" class="form-radio text-primary border-gray-300">
                        <span class="ml-2 text-sm text-gray-700">Fixed Cost Provider</span>
                      </label>
                      <label class="inline-flex items-center">
                        <input type="radio" v-model="form.cost_type" value="service_per_unit" class="form-radio text-primary border-gray-300">
                        <span class="ml-2 text-sm text-gray-700">Per-Unit Provider</span>
                      </label>
                    </div>
                  </div>

                  <div v-if="form.cost_type !== 'self'">
                    <label class="block text-sm font-medium text-gray-700">Service Provider / Mill Name</label>
                    <input type="text" v-model="form.service_provider" placeholder="e.g., Juan's Rice Mill" class="mt-1 focus:ring-primary focus:border-primary block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                  </div>

                  <div v-if="form.cost_type === 'self'">
                    <label class="block text-sm font-medium text-gray-700">Equipment / Fuel Cost</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <span class="text-gray-500 sm:text-sm">₱</span>
                      </div>
                      <input type="number" step="0.01" v-model="form.cost" class="focus:ring-primary focus:border-primary block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md" placeholder="0.00">
                    </div>
                  </div>

                  <div v-if="form.cost_type === 'service_fixed'">
                    <label class="block text-sm font-medium text-gray-700">Total Fixed Cost</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <span class="text-gray-500 sm:text-sm">₱</span>
                      </div>
                      <input type="number" step="0.01" v-model="form.cost" class="focus:ring-primary focus:border-primary block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md" placeholder="0.00">
                    </div>
                  </div>

                  <div v-if="form.cost_type === 'service_per_unit'" class="grid grid-cols-2 gap-4">
                    <div>
                      <label class="block text-sm font-medium text-gray-700">Cost per Unit</label>
                      <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                          <span class="text-gray-500 sm:text-sm">₱</span>
                        </div>
                        <input type="number" step="0.01" v-model="form.cost_per_unit" class="focus:ring-primary focus:border-primary block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md" placeholder="0.00">
                      </div>
                    </div>
                    <div>
                      <label class="block text-sm font-medium text-gray-700">Estimated Total</label>
                      <p class="mt-2 text-sm text-gray-900 font-medium">₱{{ formatNumber((form.cost_per_unit || 0) * (form.input_quantity || 0)) }}</p>
                    </div>
                  </div>
                  
                  <div class="flex items-center my-4" v-if="form.cost_type === 'self'">
                    <input id="assign-labor" v-model="assignLaborers" type="checkbox" class="h-4 w-4 text-primary focus:ring-primary border-gray-300 rounded">
                    <label for="assign-labor" class="ml-2 block text-sm text-gray-900">
                      Assign Laborers (creates a Task)
                    </label>
                  </div>
                  
                </div>
              </div>

            </form>

          </div>
        </div>
        
        <div class="mt-5 sm:mt-6 sm:flex sm:flex-row-reverse">
          <button type="button" @click="saveProcess" :disabled="loading" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-primary text-base font-medium text-white hover:bg-primary-dark focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary sm:ml-3 sm:w-auto sm:text-sm disabled:opacity-50">
            {{ isCompletionMode ? 'Complete & Record' : 'Save Details' }}
          </button>
          <button type="button" @click="closeModal" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
            Cancel
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, watch } from 'vue';
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

const form = ref({
  harvest_id: props.harvestId,
  parent_process_id: props.parentProcessId,
  process_type: props.defaultType || 'threshing',
  process_date: new Date().toISOString().split('T')[0],
  input_quantity: null,
  input_unit: 'kg',
  output_quantity: null,
  output_unit: 'kg',
  completed_date: new Date().toISOString().split('T')[0],
  status: 'pending',
  cost_type: 'self',
  cost: null,
  cost_per_unit: null,
  service_provider: '',
  notes: ''
});

onMounted(() => {
  if (props.processToEdit) {
    const p = props.processToEdit;
    form.value = {
      ...form.value,
      ...p,
      process_date: p.process_date ? p.process_date.split('T')[0] : form.value.process_date,
      completed_date: new Date().toISOString().split('T')[0],
      output_unit: p.input_unit || 'kg'
    };
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
  
  try {
    if (props.isCompletionMode) {
      await axios.post(`/api/post-harvest/${props.processToEdit.id}/complete`, form.value);
    } else if (props.processToEdit) {
      await axios.put(`/api/post-harvest/${props.processToEdit.id}`, form.value);
    } else {
      await axios.post('/api/post-harvest', form.value);
    }
    emit('saved');
    emit('close');
  } catch (error) {
    console.error('Failed to save process', error);
    alert(error.response?.data?.message || 'Failed to save');
  } finally {
    loading.value = false;
  }
};

</script>
