<template>
  <div class="min-h-screen bg-[#f8fafc]">
    <div class="container mx-auto px-4 py-8">
      
      <div class="flex flex-col md:flex-row justify-between items-center mb-8 gap-4">
        <div>
          <div class="flex items-center gap-3">
            <h1 class="text-3xl font-bold text-gray-800">Farm Reports</h1>
          </div>
          <p class="text-gray-500 mt-1">Exportable tabular data for your farm operations</p>
        </div>
        
        <div class="flex items-center space-x-3">
          <select 
            v-model="selectedPeriod"
            class="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-green-500 focus:border-green-500 bg-white shadow-sm"
          >
            <option value="30">Last 30 Days</option>
            <option value="90">Last 3 Months</option>
            <option value="365">Last Year</option>
            <option value="all">All Time</option>
          </select>
          <div class="relative">
            <button 
              @click="showExportMenu = !showExportMenu"
              :disabled="loading || !!loadError"
              class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors shadow-sm font-medium disabled:opacity-50 disabled:cursor-not-allowed"
            >
              <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
              Export Report
              <svg class="h-4 w-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>

            <div 
              v-if="showExportMenu"
              class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-50 py-1 border border-gray-100"
            >
              <button @click="handleExport('pdf')" class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-green-600">Export as PDF</button>
              <button @click="handleExport('csv')" class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-green-600">Export as CSV</button>
              <button @click="handleExport('json')" class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-green-600">Export as JSON</button>
            </div>
            
            <div v-if="showExportMenu" @click="showExportMenu = false" class="fixed inset-0 z-40"></div>
          </div>
        </div>
      </div>

      <div class="space-y-6">
        <div v-if="loadError" class="bg-red-50 border-l-4 border-red-500 rounded-r-xl p-6 mb-8 transition-all animate-pulse">
          <div class="flex items-start">
            <div class="flex-shrink-0">
              <svg class="h-6 w-6 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z" />
              </svg>
            </div>
            <div class="ml-4">
              <h3 class="text-lg font-bold text-red-800 uppercase tracking-tight">Load Error</h3>
              <p class="text-red-700 font-medium">{{ loadError }}</p>
              <button @click="loadReportData" class="mt-4 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 font-bold transition-all transform hover:scale-105">Retry Request</button>
            </div>
          </div>
        </div>

        <div v-else-if="loading" class="flex flex-col items-center justify-center py-32">
          <div class="relative">
            <div class="h-16 w-16 rounded-full border-4 border-gray-200 border-t-green-600 animate-spin"></div>
            <div class="absolute inset-0 flex items-center justify-center">
              <div class="h-8 w-8 bg-green-50 rounded-full animate-ping"></div>
            </div>
          </div>
          <p class="mt-6 text-gray-500 font-medium tracking-widest uppercase text-sm">Synchronizing Farm Data...</p>
        </div>

        <div v-else>
          <div class="bg-white p-1 rounded-xl shadow-sm border border-gray-200 inline-flex mb-8">
            <button 
              v-for="tab in tabs" 
              :key="tab.id"
              @click="activeTab = tab.id"
              :class="[
                'px-6 py-2.5 text-sm font-semibold rounded-lg transition-all duration-200',
                activeTab === tab.id 
                  ? 'bg-green-600 text-white shadow-md' 
                  : 'text-gray-500 hover:text-gray-900 hover:bg-gray-50'
              ]"
            >
              {{ tab.name }}
            </button>
          </div>

          <transition mode="out-in" name="fade">
            <div :key="activeTab">
              <div v-if="activeTab === 'yield'" class="space-y-8">
                <div class="bg-white rounded-2xl border border-gray-200 p-8">
                  <h3 class="text-xl font-extrabold text-gray-900 mb-6 flex items-center gap-2">
                    <div class="w-1.5 h-6 bg-green-500 rounded-full"></div>
                    Yield Records
                  </h3>
                  <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-gray-500">
                      <thead class="text-xs text-gray-700 uppercase bg-gray-50 border-b">
                        <tr>
                          <th class="px-6 py-3">Date</th>
                          <th class="px-6 py-3">Crop Variety</th>
                          <th class="px-6 py-3">Field</th>
                          <th class="px-6 py-3">Yield</th>
                          <th class="px-6 py-3">Quality</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="harvest in sortedHarvests" :key="harvest.id" class="bg-white border-b hover:bg-gray-50">
                          <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            {{ formatLabelDate(harvest.harvest_date) }}
                          </td>
                          <td class="px-6 py-4">{{ harvest.planting?.crop_type || 'N/A' }}</td>
                          <td class="px-6 py-4">{{ harvest.planting?.field?.name || 'N/A' }}</td>
                          <td class="px-6 py-4 font-semibold text-green-600">{{ harvest.yield }} {{ harvest.unit || 'kg' }}</td>
                          <td class="px-6 py-4">
                            <span :class="{'text-green-600 bg-green-100': harvest.quality === 'A', 'text-yellow-600 bg-yellow-100': harvest.quality === 'B', 'text-gray-600 bg-gray-100': !harvest.quality}" class="px-2 py-1 rounded text-xs font-medium">
                              {{ harvest.quality || 'N/A' }}
                            </span>
                          </td>
                        </tr>
                        <tr v-if="!sortedHarvests.length">
                          <td colspan="5" class="px-6 py-8 text-center text-gray-500">No harvest records found for this period.</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>

              <div v-if="activeTab === 'financial'" class="space-y-8">
                <div class="bg-white rounded-2xl border border-gray-200 p-8">
                  <h3 class="text-xl font-extrabold text-gray-900 mb-6 flex items-center gap-2">
                    <div class="w-1.5 h-6 bg-green-500 rounded-full"></div>
                    Detailed Profit & Loss Statement
                  </h3>
                  <ProfitLossDetails :period="selectedPeriod" />
                </div>
              </div>
            </div>
          </transition>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useFarmStore } from '@/stores/farm';
import { useMarketplaceStore } from '@/stores/marketplace';
import ProfitLossDetails from '@/Components/Reports/ProfitLossDetails.vue';

import { pdfExport } from '@/utils/pdfExport';
import { csvExport } from '@/utils/csvExport';

const farmStore = useFarmStore();
const marketplaceStore = useMarketplaceStore();

const activeTab = ref('yield');
const selectedPeriod = ref('365');
const loading = ref(false);
const loadError = ref('');
const showExportMenu = ref(false);

const tabs = [
  { id: 'yield', name: 'Yield Report' },
  { id: 'financial', name: 'Financial Report' }
];

const ensureArray = (value) => (Array.isArray(value) ? value : []);

const formatDateForApi = (date) => {
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) {
    return '';
  }
  return date.toISOString().split('T')[0];
};

const formatLabelDate = (date) => {
  const parsed = date ? new Date(date) : null;
  if (!parsed || Number.isNaN(parsed.getTime())) {
    return '';
  }
  return parsed.toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' });
};

const computePeriodFilters = (period) => {
  if (period === 'all') {
    return { filters: {} };
  }

  const days = parseInt(period, 10);
  if (!Number.isFinite(days) || days <= 0) {
    return { filters: {} };
  }

  const endDate = new Date();
  const startDate = new Date();
  startDate.setDate(endDate.getDate() - (days - 1));

  return {
    filters: {
      date_from: formatDateForApi(startDate),
      date_to: formatDateForApi(endDate),
    }
  };
};

const harvests = computed(() => ensureArray(farmStore.harvests));
const sortedHarvests = computed(() => {
  return [...harvests.value].sort((a, b) => new Date(b.harvest_date) - new Date(a.harvest_date));
});

const loadReportData = async () => {
  loading.value = true;
  loadError.value = '';

  try {
    const { filters } = computePeriodFilters(selectedPeriod.value);
    
    const orderFilters = {
      from_date: filters.date_from,
      to_date: filters.date_to
    };

    await Promise.all([
      farmStore.fetchFarmProfile(),
      farmStore.fetchFields(),
      farmStore.fetchHarvests(filters),
      farmStore.fetchSales(filters),
      farmStore.fetchExpenses(filters),
      marketplaceStore.fetchFarmerOrders(orderFilters)
    ]);
  } catch (error) {
    console.error('Failed to load report data:', error);
    loadError.value = 'Unable to load report data. Please try again.';
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  loadReportData();
});

watch(selectedPeriod, () => {
  loadReportData();
});

const getExportData = () => {
  if (activeTab.value === 'financial') {
    const sales = ensureArray(farmStore.sales);
    const orders = ensureArray(marketplaceStore.orders).filter(o => o.payment_status === 'paid');
    const expenses = ensureArray(farmStore.expenses);
    
    return {
      type: 'financial',
      data: {
        sales: sales.map(s => ({ date: formatLabelDate(s.sale_date), item: s.notes || 'Sale', amount: s.total_amount })),
        orders: orders.map(o => ({ date: formatLabelDate(o.order_date), item: `Order #${o.id}`, amount: o.total_amount })),
        expenses: expenses.map(e => ({ date: formatLabelDate(e.date), category: e.category, amount: e.amount }))
      }
    };
  } else if (activeTab.value === 'yield') {
    return {
      type: 'yield',
      data: sortedHarvests.value.map(h => ({
        date: formatLabelDate(h.harvest_date),
        crop: h.planting?.crop_type || 'Unknown',
        field: h.planting?.field?.name || 'Unknown',
        yield: `${h.yield} ${h.unit || 'kg'}`,
        quality: h.quality || 'N/A'
      }))
    };
  }
  return { type: 'unknown', data: [] };
};

const handleExport = async (format) => {
  showExportMenu.value = false;
  try {
    const { type, data } = getExportData();
    const title = `Farm ${activeTab.value.charAt(0).toUpperCase() + activeTab.value.slice(1)} Report`;
    
    if (format === 'pdf') {
      await pdfExport.export(data, title);
    } else if (format === 'csv') {
      await csvExport.export(data, title);
    } else if (format === 'json') {
      const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `${title.toLowerCase().replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.json`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
    }
  } catch (error) {
    console.error(`Export to ${format} failed:`, error);
    alert(`Failed to export report as ${format.toUpperCase()}. Please try again.`);
  }
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease, transform 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
</style>