<template>
  <div class="min-h-screen bg-[linear-gradient(180deg,#f8fafc_0%,#eef7f1_45%,#f8fafc_100%)]">
  <div class="w-full mx-auto px-6 py-8 space-y-6">
    <section class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
      <div class="grid gap-0 xl:grid-cols-[minmax(0,1.6fr)_minmax(320px,0.9fr)]">
        <div class="bg-slate-950 p-6 text-white">
          <p class="text-xs font-bold uppercase tracking-[0.24em] text-emerald-200">Processing Pipeline</p>
          <h1 class="mt-2 text-3xl font-bold leading-tight">Post-Harvest Processing</h1>
          <p class="mt-2 max-w-3xl text-sm leading-6 text-slate-300">
            {{ harvest ? `Move ${harvest.planting.rice_variety?.name || harvest.planting.riceVariety?.name || harvest.planting.crop_type || 'rice'} from harvest through threshing, drying, and milling.` : 'Move harvested rice through the required processing stages before marketplace release.' }}
          </p>
          <div class="mt-5 flex flex-wrap gap-2">
            <span class="inline-flex items-center rounded-md bg-emerald-500/15 px-3 py-1 text-xs font-semibold text-emerald-100 ring-1 ring-emerald-300/30">
              Fixed sequence
            </span>
            <span class="inline-flex items-center rounded-md bg-white/10 px-3 py-1 text-xs font-semibold text-slate-100 ring-1 ring-white/15">
              Harvest -> Threshing -> Drying -> Milling
            </span>
          </div>
        </div>

        <div class="border-t border-slate-200 bg-white p-6 xl:border-l xl:border-t-0">
          <p class="text-sm font-semibold text-slate-500">Current status</p>
          <p class="mt-1 text-2xl font-bold leading-tight text-slate-950">
            {{ pipelineStatus.is_complete ? 'Ready for marketplace' : pipelineStatus.next_step ? `Next: ${formatStepLabel(pipelineStatus.next_step)}` : 'Processing review' }}
          </p>
          <p class="mt-2 text-sm leading-6 text-slate-500">{{ processes.length }} process record{{ processes.length === 1 ? '' : 's' }} logged for this harvest.</p>
          <div class="mt-4 flex flex-wrap gap-2">
            <button
              v-if="harvest && pipelineStatus.is_complete"
              @click="openMarketplaceCreate"
              class="inline-flex items-center rounded-md bg-emerald-600 px-3 py-2 text-xs font-semibold text-white shadow-sm hover:bg-emerald-700"
            >
              Publish to Marketplace
            </button>
            <button @click="router.push('/harvests')" class="inline-flex items-center rounded-md border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-700 shadow-sm hover:bg-slate-50">
              Back to Harvests
            </button>
          </div>
        </div>
      </div>
    </section>

    <section v-if="summary" class="grid grid-cols-2 gap-3 lg:grid-cols-4">
      <div class="min-w-0 rounded-lg border border-sky-100 bg-white p-4 shadow-sm">
        <p class="break-words text-[11px] font-semibold uppercase leading-tight text-sky-700">Harvest input</p>
        <p class="mt-2 break-words text-xl font-bold leading-tight text-slate-950">{{ summary.original_quantity }} {{ displayUnit(summary.original_unit) }}</p>
      </div>
      <div class="min-w-0 rounded-lg border border-emerald-100 bg-white p-4 shadow-sm">
        <p class="break-words text-[11px] font-semibold uppercase leading-tight text-emerald-700">Processed output</p>
        <p class="mt-2 break-words text-xl font-bold leading-tight text-slate-950">{{ summary.final_quantity }} {{ displayUnit(summary.final_unit) }}</p>
      </div>
      <div class="min-w-0 rounded-lg border border-amber-100 bg-white p-4 shadow-sm">
        <p class="break-words text-[11px] font-semibold uppercase leading-tight text-amber-700">Recovery rate</p>
        <p class="mt-2 break-words text-xl font-bold leading-tight text-slate-950">{{ summary.overall_recovery_rate }}%</p>
      </div>
      <div class="min-w-0 rounded-lg border border-rose-100 bg-white p-4 shadow-sm">
        <p class="break-words text-[11px] font-semibold uppercase leading-tight text-rose-700">Processing cost</p>
        <p class="mt-2 break-words text-xl font-bold leading-tight text-slate-950">₱{{ formatNumber(totalOperationalCost) }}</p>
      </div>
    </section>

    <section class="grid gap-6 xl:grid-cols-[minmax(0,1fr)_340px]">
      <div class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
        <div class="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h2 class="text-lg font-semibold text-slate-950">Processing stages</h2>
            <p class="text-sm text-slate-500">Each step unlocks only after the previous stage is completed.</p>
          </div>
          <span class="inline-flex w-max items-center rounded-md bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">
            Sequential workflow
          </span>
        </div>

        <div class="mt-5 grid gap-3 lg:grid-cols-5">
          <div
            v-for="stage in stageCards"
            :key="stage.key"
            :class="[
              'min-h-44 rounded-lg border p-4 transition',
              getStageCardClass(stage),
            ]"
          >
            <div class="flex items-start justify-between gap-2">
              <div>
                <p class="text-[11px] font-semibold uppercase text-slate-500">{{ stage.kind }}</p>
                <h3 class="mt-1 text-base font-bold capitalize text-slate-950">{{ stage.label }}</h3>
              </div>
              <span :class="['inline-flex h-8 w-8 items-center justify-center rounded-full text-xs font-bold', getStageBadgeClass(stage)]">
                <template v-if="stage.status === 'completed'">✓</template>
                <template v-else-if="stage.status === 'locked'">-</template>
                <template v-else>{{ stage.order }}</template>
              </span>
            </div>

            <p class="mt-4 text-sm leading-5 text-slate-600">{{ getStageDetail(stage) }}</p>

            <div class="mt-4">
              <button
                v-if="stage.action === 'start'"
                @click="openProcessModal(stage.key)"
                class="inline-flex w-full items-center justify-center rounded-md bg-slate-950 px-3 py-2 text-xs font-semibold text-white hover:bg-slate-800"
              >
                Start {{ stage.label }}
              </button>
              <button
                v-else-if="stage.action === 'complete'"
                @click="completeProcess(stage.process)"
                class="inline-flex w-full items-center justify-center rounded-md bg-emerald-600 px-3 py-2 text-xs font-semibold text-white hover:bg-emerald-700"
              >
                Complete {{ stage.label }}
              </button>
              <button
                v-else-if="stage.action === 'view'"
                @click="viewProcess(stage.process)"
                class="inline-flex w-full items-center justify-center rounded-md border border-emerald-200 bg-emerald-50 px-3 py-2 text-xs font-semibold text-emerald-700 hover:bg-emerald-100"
              >
                View record
              </button>
              <button
                v-else-if="stage.action === 'publish'"
                @click="openMarketplaceCreate"
                class="inline-flex w-full items-center justify-center rounded-md bg-emerald-600 px-3 py-2 text-xs font-semibold text-white hover:bg-emerald-700"
              >
                Publish
              </button>
              <span
                v-else
                class="inline-flex w-full items-center justify-center rounded-md bg-slate-100 px-3 py-2 text-xs font-semibold text-slate-500"
              >
                {{ getStageActionLabel(stage) }}
              </span>
            </div>
          </div>
        </div>
      </div>

      <aside class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
        <p class="text-sm font-semibold text-slate-500">Current action</p>
        <h2 class="mt-1 text-xl font-bold text-slate-950">
          {{ pipelineStatus.is_complete ? 'Publish processed rice' : pipelineStatus.next_step ? `Prepare ${formatStepLabel(pipelineStatus.next_step)}` : 'Review processing' }}
        </h2>
        <p class="mt-2 text-sm leading-6 text-slate-500">
          {{ pipelineStatus.is_complete ? 'Milling is complete, so this harvest can now be carried into marketplace product creation.' : pipelineStatus.next_step ? 'Use the next available stage to keep inventory, recovery, cost, and labor records aligned.' : 'Check the processing records before continuing.' }}
        </p>
        <div class="mt-5 space-y-2">
          <button
            v-if="pipelineStatus.is_complete && harvest"
            @click="openMarketplaceCreate"
            class="inline-flex w-full items-center justify-center rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-emerald-700"
          >
            Publish to Marketplace
          </button>
          <button
            v-else-if="pipelineStatus.next_step && !hasActiveProcess(pipelineStatus.next_step)"
            @click="openProcessModal(pipelineStatus.next_step)"
            class="inline-flex w-full items-center justify-center rounded-md bg-slate-950 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-slate-800"
          >
            Start {{ formatStepLabel(pipelineStatus.next_step) }}
          </button>
          <button
            v-else-if="activeNextProcess"
            @click="completeProcess(activeNextProcess)"
            class="inline-flex w-full items-center justify-center rounded-md bg-emerald-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-emerald-700"
          >
            Complete {{ formatStepLabel(activeNextProcess.process_type) }}
          </button>
          <button
            @click="router.push('/harvests')"
            class="inline-flex w-full items-center justify-center rounded-md border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 shadow-sm hover:bg-slate-50"
          >
            Choose Another Harvest
          </button>
        </div>
      </aside>
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

const activeNextProcess = computed(() => {
  if (!pipelineStatus.value.next_step) return null;
  return processes.value.find(p =>
    p.process_type === pipelineStatus.value.next_step &&
    !['cancelled', 'completed'].includes(p.status)
  ) || null;
});

const formatStepLabel = (stepType) => {
  if (!stepType) return '';
  return stepType.replace(/_/g, ' ').replace(/\b\w/g, char => char.toUpperCase());
};

const stageCards = computed(() => {
  const harvestQuantity = harvest.value
    ? `${harvest.value.quantity || 0} ${displayUnit(harvest.value.unit)}`
    : 'No harvest loaded';
  const harvestDetail = harvest.value?.harvester_share > 0
    ? `Gross ${harvestQuantity}; net ${netHarvestQuantity.value} ${displayUnit(harvest.value.unit)} after harvester share.`
    : `Gross ${harvestQuantity} available for the first process.`;

  const processCards = pipelineOrder.map((stepType, index) => {
    const process = getStepProcess(stepType);
    const status = getStepStatus(stepType);
    let action = 'locked';
    if (status === 'ready') action = 'start';
    if (['pending', 'in_progress'].includes(status)) action = 'complete';
    if (status === 'completed') action = 'view';

    return {
      key: stepType,
      kind: 'Process',
      label: formatStepLabel(stepType),
      order: index + 1,
      status,
      action,
      process,
    };
  });

  return [
    {
      key: 'harvest',
      kind: 'Source',
      label: 'Harvest',
      order: 'H',
      status: 'completed',
      action: 'done',
      detail: harvestDetail,
    },
    ...processCards,
    {
      key: 'marketplace',
      kind: 'Release',
      label: 'Marketplace',
      order: 'M',
      status: pipelineStatus.value.is_complete ? 'ready' : 'locked',
      action: pipelineStatus.value.is_complete ? 'publish' : 'locked',
      detail: pipelineStatus.value.is_complete
        ? `${summary.value?.final_quantity || 0} ${displayUnit(summary.value?.final_unit)} ready for product creation.`
        : 'Locked until milling is complete.',
    },
  ];
});

const getStageCardClass = (stage) => {
  if (stage.status === 'completed') return 'border-emerald-200 bg-emerald-50/60';
  if (stage.action === 'publish') return 'border-emerald-200 bg-emerald-50/60';
  if (['pending', 'in_progress', 'ready'].includes(stage.status)) return 'border-amber-200 bg-amber-50/70';
  return 'border-slate-200 bg-slate-50';
};

const getStageBadgeClass = (stage) => {
  if (stage.status === 'completed') return 'bg-emerald-600 text-white';
  if (stage.action === 'publish') return 'bg-emerald-600 text-white';
  if (['pending', 'in_progress', 'ready'].includes(stage.status)) return 'bg-amber-500 text-white';
  return 'bg-slate-200 text-slate-500';
};

const getStageDetail = (stage) => {
  if (stage.detail) return stage.detail;
  if (stage.process && stage.status === 'completed') {
    return `${stage.process.output_quantity} ${displayUnit(stage.process.output_unit)} output, ${stage.process.weight_loss_percentage || 0}% loss.`;
  }
  if (stage.process) {
    return `${stage.process.input_quantity} ${displayUnit(stage.process.input_unit)} input is recorded and waiting for completion.`;
  }
  if (stage.status === 'ready') return 'Ready to start from the latest available inventory.';
  return 'Complete the previous stage first.';
};

const getStageActionLabel = (stage) => {
  if (stage.status === 'completed') return 'Completed';
  if (stage.status === 'locked') return 'Locked';
  return formatStepLabel(stage.status);
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
