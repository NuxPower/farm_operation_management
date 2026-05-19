<template>
  <div class="min-h-screen bg-[linear-gradient(180deg,#f8fafc_0%,#fff7ed_38%,#f8fafc_100%)]">
  <div class="w-full mx-auto px-6 py-8 space-y-6">
    <section class="overflow-hidden rounded-2xl border border-white/80 bg-white shadow-[0_24px_70px_rgba(15,23,42,0.10)]">
      <div class="grid grid-cols-1 lg:grid-cols-[1.25fr_0.75fr]">
        <div class="bg-[linear-gradient(135deg,#78350f_0%,#047857_52%,#0f766e_100%)] p-8 text-white">
          <p class="text-xs font-bold uppercase tracking-[0.24em] text-amber-100">Production Cycle</p>
          <h1 class="mt-3 text-4xl font-bold leading-tight">Post-Harvest Processing</h1>
          <p class="mt-4 max-w-2xl text-sm leading-6 text-white/75">
            {{ harvest ? `Manage ${harvest.planting.rice_variety?.name || harvest.planting.crop_type} through threshing, drying, and milling.` : 'Manage processing steps after harvest before inventory and marketplace release.' }}
          </p>
          <div class="mt-6 flex flex-wrap gap-2">
            <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Threshing</span>
            <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Drying</span>
            <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Milling</span>
          </div>
        </div>
        <div class="flex flex-col justify-between gap-5 bg-white p-8">
          <div>
            <p class="text-sm font-semibold text-gray-500">Pipeline status</p>
            <p class="mt-2 text-2xl font-bold text-gray-900">{{ pipelineStatus.is_complete ? 'Ready for marketplace' : pipelineStatus.next_step ? `Next: ${pipelineStatus.next_step}` : 'Processing review' }}</p>
            <p class="mt-2 text-sm leading-6 text-gray-500">{{ processes.length }} process record{{ processes.length === 1 ? '' : 's' }} logged for this harvest.</p>
          </div>
          <div v-if="summary" class="grid grid-cols-2 gap-3 sm:grid-cols-4">
            <div class="rounded-xl bg-sky-50 p-3">
              <p class="text-xs font-medium text-sky-700">Harvest</p>
              <p class="mt-1 text-lg font-bold text-sky-950">{{ summary.original_quantity }} {{ displayUnit(summary.original_unit) }}</p>
            </div>
            <div class="rounded-xl bg-emerald-50 p-3">
              <p class="text-xs font-medium text-emerald-700">Output</p>
              <p class="mt-1 text-lg font-bold text-emerald-950">{{ summary.final_quantity }} {{ displayUnit(summary.final_unit) }}</p>
            </div>
            <div class="rounded-xl bg-amber-50 p-3">
              <p class="text-xs font-medium text-amber-700">Recovery</p>
              <p class="mt-1 text-lg font-bold text-amber-950">{{ summary.overall_recovery_rate }}%</p>
            </div>
            <div class="rounded-xl bg-rose-50 p-3">
              <p class="text-xs font-medium text-rose-700">Cost</p>
              <p class="mt-1 text-lg font-bold text-rose-950">₱{{ formatNumber(totalOperationalCost) }}</p>
            </div>
          </div>
          <div class="flex flex-wrap gap-2">
            <button
              v-if="harvest && pipelineStatus.is_complete"
              @click="openMarketplaceCreate"
              class="inline-flex items-center rounded-md bg-emerald-600 px-3 py-1.5 text-xs font-semibold text-white shadow-sm hover:bg-emerald-700"
            >
              Publish to Marketplace
            </button>
            <button @click="router.push('/harvests')" class="inline-flex items-center rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 shadow-sm hover:bg-gray-50">
              Back to Harvests
            </button>
          </div>
        </div>
      </div>
    </section>

    <div v-if="pipelineStatus.is_complete && summary?.final_quantity" class="rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-900">
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

    <!-- Fixed Pipeline Visualization -->
    <div class="bg-white border border-gray-200 shadow-sm rounded-xl p-6">
      <h3 class="text-lg font-medium text-gray-900 mb-4">Processing Pipeline</h3>
      
      <div class="relative overflow-x-auto pb-2">
        <div class="absolute inset-0 flex items-center" aria-hidden="true">
          <div class="w-full border-t border-gray-300"></div>
        </div>
        <div class="relative flex justify-between">
          <!-- Harvest node (always completed) -->
          <div class="flex flex-col items-center">
            <span class="h-8 w-8 rounded-full bg-emerald-600 flex items-center justify-center ring-8 ring-white">
              <svg class="h-5 w-5 text-white" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
              </svg>
            </span>
            <span class="mt-2 text-sm font-medium text-gray-900">Harvest</span>
            <span class="text-xs text-gray-500">{{ harvest?.quantity }} {{ displayUnit(harvest?.unit) }}</span>
            <span v-if="harvest?.harvester_share > 0" class="text-xs text-amber-600 font-medium">Net: {{ netHarvestQuantity }} {{ displayUnit(harvest?.unit) }}</span>
          </div>

          <!-- Fixed pipeline steps: Threshing → Drying → Milling -->
          <div v-for="(stepType, index) in pipelineOrder" :key="stepType" class="flex flex-col items-center relative group">
            <span :class="[
              'h-8 w-8 rounded-full flex items-center justify-center ring-8 ring-white transition-transform',
              getStepStatus(stepType) === 'completed' ? 'bg-emerald-600 cursor-pointer group-hover:scale-110' :
              getStepStatus(stepType) === 'in_progress' ? 'bg-amber-500 border-2 border-white cursor-pointer group-hover:scale-110' :
              getStepStatus(stepType) === 'pending' ? 'bg-amber-400 cursor-pointer group-hover:scale-110' :
              getStepStatus(stepType) === 'cancelled' ? 'bg-red-400 cursor-pointer' :
              'bg-gray-200'
            ]" @click="getStepProcess(stepType) ? viewProcess(getStepProcess(stepType)) : null">
              <span v-if="getStepStatus(stepType) === 'completed'" class="text-white text-xs font-bold">✓</span>
              <span v-else-if="getStepStatus(stepType) === 'locked'" class="text-gray-400 text-xs font-bold">
                <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 10-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H6.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z" /></svg>
              </span>
              <span v-else class="text-white text-xs font-bold">{{ index + 1 }}</span>
            </span>
            <span class="mt-2 text-sm font-medium capitalize" :class="getStepStatus(stepType) === 'locked' ? 'text-gray-400' : 'text-gray-900'">{{ stepType }}</span>
            
            <template v-if="getStepStatus(stepType) === 'completed'">
              <span class="text-xs text-emerald-600 font-medium">{{ getStepProcess(stepType)?.output_quantity }} {{ displayUnit(getStepProcess(stepType)?.output_unit) }}</span>
              <span class="text-xs text-gray-500">Loss: {{ getStepProcess(stepType)?.weight_loss_percentage }}%</span>
            </template>
            <template v-else-if="getStepStatus(stepType) === 'cancelled'">
              <span class="text-xs text-red-500 font-medium line-through">Cancelled</span>
            </template>
            <template v-else-if="getStepStatus(stepType) === 'in_progress' || getStepStatus(stepType) === 'pending'">
              <span class="text-xs text-amber-600 font-medium">{{ getStepStatus(stepType).replace('_', ' ') }}</span>
              <button @click="completeProcess(getStepProcess(stepType))" class="mt-1 text-xs text-primary hover:underline">Complete</button>
            </template>
            <template v-else-if="getStepStatus(stepType) === 'locked'">
              <span class="text-xs text-gray-400">Locked</span>
            </template>
            <template v-else-if="getStepStatus(stepType) === 'ready'">
              <button @click="openProcessModal(stepType)" class="mt-1 inline-flex items-center px-3 py-1 text-xs font-medium rounded-full text-white bg-primary hover:bg-primary-dark shadow-sm transition-all">
                Start {{ stepType.charAt(0).toUpperCase() + stepType.slice(1) }}
              </button>
            </template>
          </div>
        </div>
      </div>
    </div>

    <!-- History List -->
    <div v-if="processes.length > 0" class="bg-white border border-gray-200 shadow-sm overflow-hidden sm:rounded-xl">
      <div class="px-4 py-5 border-b border-gray-200 sm:px-6 flex justify-between items-center">
        <h3 class="text-lg leading-6 font-medium text-gray-900">Processing History</h3>
        <button
          v-if="pipelineStatus.next_step && !hasActiveProcess(pipelineStatus.next_step)"
          @click="openProcessModal(pipelineStatus.next_step)"
          class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white bg-primary hover:bg-primary-dark"
        >
          Start {{ pipelineStatus.next_step.charAt(0).toUpperCase() + pipelineStatus.next_step.slice(1) }}
        </button>
        <span v-else-if="pipelineStatus.is_complete" class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-full bg-emerald-100 text-emerald-800">
          ✓ Pipeline Complete
        </span>
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
              <div class="sm:flex sm:flex-wrap sm:gap-x-6 sm:gap-y-1">
                <p class="flex items-center text-sm text-gray-500">
                  Input: <span class="font-medium text-gray-900 ml-1">{{ process.input_quantity }} {{ displayUnit(process.input_unit) }}</span>
                </p>
                <p v-if="process.status === 'completed'" class="flex items-center text-sm text-gray-500">
                  Output: <span class="font-medium text-gray-900 ml-1">{{ process.output_quantity }} {{ displayUnit(process.output_unit) }}</span>
                </p>
                <p v-if="process.cost > 0" class="flex items-center text-sm text-gray-500">
                  Cost: <span class="font-medium text-gray-900 ml-1">₱{{ formatNumber(process.cost) }}</span>
                  <span v-if="process.service_provider" class="ml-1">({{ process.service_provider }})</span>
                </p>
                <p v-if="getAssignedLaborLabel(process)" class="flex items-center text-sm text-gray-500">
                  Laborer: <span class="font-medium text-gray-900 ml-1">{{ getAssignedLaborLabel(process) }}</span>
                </p>
                <p v-if="getLaborCost(process) > 0" class="flex items-center text-sm text-gray-500">
                  Labor Cost: <span class="font-medium text-gray-900 ml-1">₱{{ formatNumber(getLaborCost(process)) }}</span>
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
    
    <!-- Process Form Modal -->
    <ProcessForm 
      v-if="showModal" 
      :is-open="showModal"
      :harvest-id="harvestId"
      :parent-process-id="selectedParentId"
      :process-to-edit="selectedProcess"
      :is-completion-mode="isCompletionMode"
      :process-type="currentProcessType"
      :rice-variety-name="riceVarietyName"
      :harvest-quantity="netHarvestQuantity"
      @close="closeModal"
      @saved="fetchData"
    />
  </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import ProcessForm from './ProcessForm.vue';

const route = useRoute();
const router = useRouter();
const harvestId = route.params.harvest_id;

const harvest = ref(null);
const processes = ref([]);
const summary = ref(null);
const pipelineStatus = ref({ completed_types: [], next_step: 'threshing', is_complete: false });
const riceVarietyName = ref('Rice');

const pipelineOrder = ['threshing', 'drying', 'milling'];

// Net quantity the farmer can actually process = gross minus harvester share
const netHarvestQuantity = computed(() => {
  if (!harvest.value) return null;
  const gross = parseFloat(harvest.value.quantity || 0);
  const share = parseFloat(harvest.value.harvester_share || 0);
  return parseFloat((gross - share).toFixed(2));
});

const showModal = ref(false);
const selectedParentId = ref(null);
const selectedProcess = ref(null);
const isCompletionMode = ref(false);
const currentProcessType = ref('threshing');
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
    pipelineStatus.value = response.data.pipeline_status || { completed_types: [], next_step: 'threshing', is_complete: false };
    riceVarietyName.value = response.data.rice_variety_name || 'Rice';
  } catch (error) {
    console.error('Failed to fetch post-harvest data', error);
    errorMessage.value = error.response?.data?.message || 'Failed to load post-harvest data. Please try refreshing the page.';
  }
};

// Get the status of a pipeline step
const getStepStatus = (stepType) => {
  const process = processes.value.find(p => p.process_type === stepType && p.status !== 'cancelled');
  if (process) {
    return process.status; // 'completed', 'in_progress', 'pending'
  }
  
  // No process exists — is it ready (predecessor completed) or locked?
  const stepIndex = pipelineOrder.indexOf(stepType);
  if (stepIndex === 0) return 'ready'; // Threshing is always ready if not started
  
  const predecessorType = pipelineOrder[stepIndex - 1];
  const predecessorProcess = processes.value.find(p => p.process_type === predecessorType && p.status === 'completed');
  return predecessorProcess ? 'ready' : 'locked';
};

// Get the process record for a step
const getStepProcess = (stepType) => {
  return processes.value.find(p => p.process_type === stepType && p.status !== 'cancelled') || null;
};

// Check if there's an active (non-cancelled, non-completed) process for a step
const hasActiveProcess = (stepType) => {
  return processes.value.some(p => p.process_type === stepType && !['cancelled', 'completed'].includes(p.status));
};

const openProcessModal = (processType) => {
  // Find parent (predecessor) process id
  const stepIndex = pipelineOrder.indexOf(processType);
  let parentId = null;
  if (stepIndex > 0) {
    const predecessorType = pipelineOrder[stepIndex - 1];
    const predecessorProcess = processes.value.find(p => p.process_type === predecessorType && p.status === 'completed');
    parentId = predecessorProcess?.id || null;
  }
  
  selectedParentId.value = parentId;
  currentProcessType.value = processType;
  selectedProcess.value = null;
  isCompletionMode.value = false;
  showModal.value = true;
};

const editProcess = (process) => {
  selectedProcess.value = process;
  selectedParentId.value = process.parent_process_id;
  currentProcessType.value = process.process_type;
  isCompletionMode.value = false;
  showModal.value = true;
};

const viewProcess = (process) => {
  editProcess(process);
};

const completeProcess = (process) => {
  selectedProcess.value = process;
  currentProcessType.value = process.process_type;
  isCompletionMode.value = true;
  showModal.value = true;
};

const deleteProcess = async (process) => {
  if (confirm('Are you sure you want to delete this process?')) {
    try {
      const response = await axios.delete(`/api/post-harvest/${process.id}`);
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
};

const formatNumber = (num) => {
  return Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
};

const formatDate = (dateString) => {
  if (!dateString) return '';
  return new Date(dateString).toLocaleDateString();
};

const displayUnit = (unit) => {
  const map = {
    sacks_palay: 'sacks (palay)',
    sacks_rice: 'sacks (rice)',
  };
  return map[unit] || unit;
};

const getAssignedLaborLabel = (process) => {
  const task = process?.task;
  if (!task) return '';
  if (task.laborer?.name) return task.laborer.name;
  if (task.laborer_group?.name) return `${task.laborer_group.name} (group)`;
  return '';
};

const getLaborCost = (process) => {
  return Number(process?.task?.wage_amount || 0);
};

const totalLaborCost = computed(() => {
  return (processes.value || []).reduce((total, process) => {
    return total + getLaborCost(process);
  }, 0);
});

const totalOperationalCost = computed(() => {
  const processingCost = Number(summary.value?.total_cost || 0);
  return processingCost + totalLaborCost.value;
});
</script>
