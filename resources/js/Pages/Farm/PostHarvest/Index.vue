<template>
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-6">
    <div class="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
      <h2 class="text-2xl font-bold tracking-tight text-gray-900">
        Post-Harvest Processing
        <span v-if="harvest" class="text-gray-500 text-lg ml-2 font-normal">
          for {{ harvest.planting.rice_variety?.name || harvest.planting.crop_type }}
        </span>
      </h2>
      <div class="flex flex-wrap items-center gap-2">
        <button
          v-if="harvest"
          @click="openMarketplaceCreate"
          class="inline-flex items-center rounded-md bg-emerald-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-emerald-700"
        >
          Publish to Marketplace
        </button>
        <button @click="router.push('/harvests')" class="text-sm font-medium text-primary hover:text-primary-dark">
          &larr; Back to Harvests
        </button>
      </div>
    </div>

    <div v-if="summary?.final_quantity" class="rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-900">
      Current processed output is ready to carry into the marketplace whenever you want to publish it.
    </div>

    <!-- Error Banner -->
    <div v-if="errorMessage" class="rounded-md bg-red-50 border border-red-200 p-4">
      <div class="flex">
        <div class="flex-shrink-0">
          <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3 flex-1">
          <p class="text-sm text-red-700">{{ errorMessage }}</p>
        </div>
        <div class="ml-auto pl-3">
          <button @click="errorMessage = ''" class="text-red-500 hover:text-red-700">
            <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Summary Cards -->
    <div v-if="summary" class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="bg-white rounded-lg shadow p-4 border-l-4 border-blue-500">
        <h3 class="text-sm font-medium text-gray-500">Original Harvest</h3>
        <p class="mt-1 text-2xl font-semibold text-gray-900">{{ summary.original_quantity }} {{ summary.original_unit }}</p>
      </div>
      <div class="bg-white rounded-lg shadow p-4 border-l-4 border-emerald-500">
        <h3 class="text-sm font-medium text-gray-500">Current Output</h3>
        <p class="mt-1 text-2xl font-semibold text-gray-900">{{ summary.final_quantity }} {{ summary.final_unit }}</p>
      </div>
      <div class="bg-white rounded-lg shadow p-4 border-l-4 border-amber-500">
        <h3 class="text-sm font-medium text-gray-500">Overall Recovery</h3>
        <p class="mt-1 text-2xl font-semibold text-gray-900">{{ summary.overall_recovery_rate }}%</p>
      </div>
      <div class="bg-white rounded-lg shadow p-4 border-l-4 border-rose-500">
        <h3 class="text-sm font-medium text-gray-500">Total Processing Cost</h3>
        <p class="mt-1 text-2xl font-semibold text-gray-900">₱{{ formatNumber(summary.total_cost) }}</p>
      </div>
    </div>

    <!-- Pipeline Visualization -->
    <div class="bg-white shadow rounded-lg p-6">
      <h3 class="text-lg font-medium text-gray-900 mb-4">Processing Pipeline</h3>
      
      <div v-if="processes.length === 0" class="text-center py-8">
        <div class="mx-auto h-12 w-12 text-gray-400">
          <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z" />
          </svg>
        </div>
        <h3 class="mt-2 text-sm font-medium text-gray-900">No processing steps recorded</h3>
        <p class="mt-1 text-sm text-gray-500">Start the post-harvest process by recording a threshing or drying step.</p>
        <div class="mt-6 flex justify-center gap-3">
          <button @click="openProcessModal(null, 'threshing')" class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-primary hover:bg-primary-dark">
            Start Threshing
          </button>
          <button @click="openProcessModal(null, 'drying')" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
            Skip to Drying
          </button>
        </div>
      </div>

      <div v-else class="relative overflow-x-auto pb-2">
        <div class="absolute inset-0 flex items-center" aria-hidden="true">
          <div class="w-full border-t border-gray-300"></div>
        </div>
        <div class="relative flex justify-between">
          <div class="flex flex-col items-center">
            <span class="h-8 w-8 rounded-full bg-emerald-600 flex items-center justify-center ring-8 ring-white">
              <svg class="h-5 w-5 text-white" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
              </svg>
            </span>
            <span class="mt-2 text-sm font-medium text-gray-900">Harvest</span>
            <span class="text-xs text-gray-500">{{ harvest?.quantity }} {{ harvest?.unit }}</span>
          </div>

          <div v-for="(process, index) in processes" :key="process.id" class="flex flex-col items-center relative group">
            <span :class="[
              'h-8 w-8 rounded-full flex items-center justify-center ring-8 ring-white cursor-pointer transition-transform group-hover:scale-110',
              process.status === 'completed' ? 'bg-emerald-600' : 
              process.status === 'cancelled' ? 'bg-red-400' :
              process.status === 'in_progress' ? 'bg-amber-500 border-2 border-white' : 'bg-gray-300'
            ]" @click="viewProcess(process)">
              <span v-if="process.status === 'completed'" class="text-white text-xs font-bold">✓</span>
              <span v-else class="text-white text-xs font-bold">{{ index + 1 }}</span>
            </span>
            <span class="mt-2 text-sm font-medium text-gray-900 capitalize">{{ process.process_type }}</span>
            
            <template v-if="process.status === 'completed'">
              <span class="text-xs text-emerald-600 font-medium">{{ process.output_quantity }} {{ process.output_unit }}</span>
              <span class="text-xs text-gray-500">Loss: {{ process.weight_loss_percentage }}%</span>
            </template>
            <template v-else-if="process.status === 'cancelled'">
              <span class="text-xs text-red-500 font-medium line-through">Cancelled</span>
            </template>
            <template v-else>
              <span class="text-xs text-amber-600 font-medium">{{ process.status.replace('_', ' ') }}</span>
              <button @click="completeProcess(process)" class="mt-1 text-xs text-primary hover:underline">Complete</button>
            </template>
          </div>
          
          <div class="flex flex-col items-center">
            <button @click="openProcessModal(processes[processes.length - 1].id)" class="h-8 w-8 rounded-full border-2 border-dashed border-gray-300 bg-white flex items-center justify-center ring-8 ring-white hover:border-gray-400 hover:bg-gray-50 focus:outline-none">
              <span class="text-gray-500 font-bold">+</span>
            </button>
            <span class="mt-2 text-sm font-medium text-gray-500">Next Step</span>
          </div>
        </div>
      </div>
    </div>

    <!-- History List -->
    <div v-if="processes.length > 0" class="bg-white shadow overflow-hidden sm:rounded-md">
      <div class="px-4 py-5 border-b border-gray-200 sm:px-6 flex justify-between items-center">
        <h3 class="text-lg leading-6 font-medium text-gray-900">Processing History</h3>
        <button @click="openProcessModal(processes[processes.length - 1].id)" class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white bg-primary hover:bg-primary-dark">
          Add Next Step
        </button>
      </div>
      <ul role="list" class="divide-y divide-gray-200">
        <li v-for="process in processes" :key="process.id">
          <div class="px-4 py-4 sm:px-6 hover:bg-gray-50">
            <div class="flex items-center justify-between">
              <div class="flex text-sm font-medium text-primary truncate capitalize">
                {{ process.process_type }}
                <span v-if="process.status === 'completed'" class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                  Completed
                </span>
                <span v-else-if="process.status === 'in_progress'" class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                  In Progress
                </span>
                <span v-else-if="process.status === 'cancelled'" class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                  Cancelled
                </span>
                <span v-else class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                  Pending
                </span>
              </div>
              <div class="ml-2 flex-shrink-0 flex space-x-2">
                <button v-if="process.status !== 'completed' && process.status !== 'cancelled'" @click="completeProcess(process)" class="text-sm text-green-600 hover:text-green-900 font-medium">Complete</button>
                <button v-if="process.status !== 'completed' && process.status !== 'cancelled'" @click="editProcess(process)" class="text-sm text-indigo-600 hover:text-indigo-900 font-medium">Edit</button>
                <button v-if="process.status === 'pending' || process.status === 'cancelled'" @click="deleteProcess(process)" class="text-sm text-red-600 hover:text-red-900 font-medium">Delete</button>
              </div>
            </div>
            <div class="mt-2 sm:flex sm:justify-between">
              <div class="sm:flex">
                <p class="flex items-center text-sm text-gray-500 mr-6">
                  Input: <span class="font-medium text-gray-900 ml-1">{{ process.input_quantity }} {{ process.input_unit }}</span>
                </p>
                <p v-if="process.status === 'completed'" class="flex items-center text-sm text-gray-500 mr-6">
                  Output: <span class="font-medium text-gray-900 ml-1">{{ process.output_quantity }} {{ process.output_unit }}</span>
                </p>
                <p v-if="process.cost > 0" class="flex items-center text-sm text-gray-500">
                  Cost: <span class="font-medium text-gray-900 ml-1">₱{{ formatNumber(process.cost) }}</span>
                  <span v-if="process.service_provider" class="ml-1">({{ process.service_provider }})</span>
                </p>
              </div>
              <div class="mt-2 flex items-center text-sm text-gray-500 sm:mt-0">
                <p>
                  {{ formatDate(process.process_date) }}
                </p>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </div>
    
    <!-- Modal for Process Form will go here in actual implementation -->
    <ProcessForm 
      v-if="showModal" 
      :is-open="showModal"
      :harvest-id="harvestId"
      :parent-process-id="selectedParentId"
      :process-to-edit="selectedProcess"
      :is-completion-mode="isCompletionMode"
      :default-type="defaultProcessType"
      @close="closeModal"
      @saved="fetchData"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import ProcessForm from './ProcessForm.vue';

const route = useRoute();
const router = useRouter();
const harvestId = route.params.harvest_id;

const harvest = ref(null);
const processes = ref([]);
const summary = ref(null);

const showModal = ref(false);
const selectedParentId = ref(null);
const selectedProcess = ref(null);
const isCompletionMode = ref(false);
const defaultProcessType = ref(null);
const errorMessage = ref('');

onMounted(() => {
  fetchData();
});

const fetchData = async () => {
  try {
    errorMessage.value = '';
    const response = await axios.get(`/api/post-harvest/harvest/${harvestId}`);
    harvest.value = response.data.harvest;
    processes.value = response.data.processes;
    summary.value = response.data.summary;
  } catch (error) {
    console.error('Failed to fetch post-harvest data', error);
    errorMessage.value = error.response?.data?.message || 'Failed to load post-harvest data. Please try refreshing the page.';
  }
};

const openProcessModal = (parentId = null, type = null) => {
  selectedParentId.value = parentId;
  defaultProcessType.value = type;
  selectedProcess.value = null;
  isCompletionMode.value = false;
  showModal.value = true;
};

const editProcess = (process) => {
  selectedProcess.value = process;
  selectedParentId.value = process.parent_process_id;
  isCompletionMode.value = false;
  showModal.value = true;
};

const viewProcess = (process) => {
  // Can just use edit modal optionally disabled, or a separate viewing logic
  editProcess(process);
};

const completeProcess = (process) => {
  selectedProcess.value = process;
  isCompletionMode.value = true;
  showModal.value = true;
};

const deleteProcess = async (process) => {
  if (confirm('Are you sure you want to delete this process?')) {
    try {
      const response = await axios.delete(`/api/post-harvest/${process.id}`);
      // Use returned summary to avoid extra round-trip
      if (response.data.summary) {
        summary.value = response.data.summary;
      }
      await fetchData();
    } catch (error) {
      console.error('Failed to delete process', error);
      errorMessage.value = error.response?.data?.message || 'Failed to delete process';
    }
  }
};

const openMarketplaceCreate = () => {
  router.push({
    path: '/marketplace/product/create',
    query: {
      harvest_id: harvestId,
    },
  });
};

const closeModal = () => {
  showModal.value = false;
  selectedProcess.value = null;
  selectedParentId.value = null;
  isCompletionMode.value = false;
  defaultProcessType.value = null;
};

const formatNumber = (num) => {
  return Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
};

const formatDate = (dateString) => {
  if (!dateString) return '';
  return new Date(dateString).toLocaleDateString();
};
</script>
