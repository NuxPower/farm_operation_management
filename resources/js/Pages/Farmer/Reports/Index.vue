<template>
  <div class="min-h-screen bg-[#f8fafc]">
    <div class="container mx-auto px-4 py-8">
      
      <div class="flex flex-col md:flex-row justify-between items-center mb-8 gap-4">
        <div>
          <div class="flex items-center gap-3">
            <h1 class="text-3xl font-bold text-gray-800">Farm Reports & Analytics</h1>
          </div>
          <p class="text-gray-500 mt-1">Analyze your rice farming performance and financial data</p>
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
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                  <StatCard title="Total Yield" :value="totalYield + ' ' + predominantUnit" sub="Accumulated harvest" icon-bg="bg-green-100" icon-text="text-green-600">
                    <path d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                  </StatCard>
                  
                  <StatCard title="Avg Yield/ha" :value="averageYieldPerHectare + ' ' + predominantUnit" sub="Efficiency metric" icon-bg="bg-blue-100" icon-text="text-blue-600">
                    <path d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                  </StatCard>

                  <StatCard title="Best Variety" :value="bestVariety" sub="Top performing crop" icon-bg="bg-amber-100" icon-text="text-amber-600">
                    <path d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                  </StatCard>

                  <StatCard title="Total Harvests" :value="totalHarvests" sub="Active field cycles" icon-bg="bg-purple-100" icon-text="text-purple-600">
                    <path d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                  </StatCard>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                  <div class="bg-white rounded-2xl border border-gray-100 shadow-sm p-6 hover:shadow-md transition-shadow">
                    <div class="flex justify-between items-center mb-6">
                      <h3 class="text-lg font-bold text-gray-800">Yield Over Time</h3>
                      <span class="text-xs font-medium px-2 py-1 bg-gray-100 text-gray-500 rounded">Timeline</span>
                    </div>
                    <div class="h-72">
                      <LineChart v-if="yieldChartData.labels.length > 0" :data="yieldChartData" :options="chartOptions" />
                      <NoData v-else />
                    </div>
                  </div>

                  <div class="bg-white rounded-2xl border border-gray-100 shadow-sm p-6 hover:shadow-md transition-shadow">
                    <div class="flex justify-between items-center mb-6">
                      <h3 class="text-lg font-bold text-gray-800">Variety Distribution</h3>
                      <span class="text-xs font-medium px-2 py-1 bg-gray-100 text-gray-500 rounded">Categories</span>
                    </div>
                    <div class="h-72">
                      <BarChart v-if="varietyChartData.labels.length > 0" :data="varietyChartData" :options="chartOptions" />
                      <NoData v-else />
                    </div>
                  </div>
                </div>
              </div>

              <div v-if="activeTab === 'financial'" class="space-y-8">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                  <StatCard title="Total Revenue" :value="formatCurrency(totalRevenue)" sub="Gross income" icon-bg="bg-emerald-50" icon-text="text-emerald-600" />
                  <StatCard title="Total Expenses" :value="formatCurrency(totalExpenses)" sub="Operational costs" icon-bg="bg-rose-50" icon-text="text-rose-600" />
                  <StatCard title="Net Profit" :value="formatCurrency(netProfit)" :sub="netProfit >= 0 ? 'Surplus income' : 'Deficit status'" :icon-bg="netProfit >= 0 ? 'bg-blue-50' : 'bg-red-50'" :icon-text="netProfit >= 0 ? 'text-blue-600' : 'text-red-600'" />
                  <StatCard title="Profit Margin" :value="profitMargin + '%'" sub="Revenue efficiency" icon-bg="bg-indigo-50" icon-text="text-indigo-600" />
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                  <div class="lg:col-span-2 bg-white rounded-2xl border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-6">Revenue vs Expenses Flow</h3>
                    <div class="h-80">
                      <LineChart v-if="financialChartData.labels.length > 0" :data="financialChartData" :options="chartOptions" />
                      <NoData v-else />
                    </div>
                  </div>

                  <div class="bg-white rounded-2xl border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-6">Expense Breakdown</h3>
                    <div class="h-80 flex flex-col items-center">
                      <PieChart v-if="expenseChartData.labels.length > 0" :data="expenseChartData" :options="pieChartOptions" />
                      <NoData v-else />
                    </div>
                  </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-8">
                  <h3 class="text-xl font-extrabold text-gray-900 mb-6 flex items-center gap-2">
                    <div class="w-1.5 h-6 bg-green-500 rounded-full"></div>
                    Detailed Profit & Loss Analysis
                  </h3>
                  <ProfitLossDetails :period="selectedPeriod" />
                </div>
              </div>

              <div v-if="activeTab === 'weather'" class="space-y-8">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                  <StatCard title="Avg Rainfall" :value="averageRainfall + ' mm'" sub="Precipitation" icon-bg="bg-cyan-50" icon-text="text-cyan-600" />
                  <StatCard title="Avg Temperature" :value="averageTemperature + ' °C'" sub="Field climate" icon-bg="bg-orange-50" icon-text="text-orange-600" />
                  <StatCard title="Climate Impact" :value="weatherImpact + '%'" sub="Favorable days" icon-bg="bg-green-50" icon-text="text-green-600" />
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-6">
                  <h3 class="text-lg font-bold text-gray-800 mb-6">Yield & Rainfall Correlation</h3>
                  <div class="h-96">
                    <LineChart v-if="weatherCorrelationData.labels.length > 0" :data="weatherCorrelationData" :options="weatherChartOptions" />
                    <NoData v-else />
                  </div>
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
import { useWeatherStore } from '@/stores/weather';
import { useMarketplaceStore } from '@/stores/marketplace';
import LineChart from '@/Components/Charts/LineChart.vue';
import BarChart from '@/Components/Charts/BarChart.vue';
import PieChart from '@/Components/Charts/PieChart.vue';
import ProfitLossDetails from '@/Components/Reports/ProfitLossDetails.vue';

import { formatCurrency } from '@/utils/format';
import { pdfExport } from '@/utils/pdfExport';
import { csvExport } from '@/utils/csvExport';

import { useRoute } from 'vue-router';
import StatCard from '@/Components/StatCard.vue';
import NoData from '@/Components/NoData.vue';

const route = useRoute();
const farmStore = useFarmStore();
const weatherStore = useWeatherStore();
const marketplaceStore = useMarketplaceStore();

const activeTab = ref('yield');
const selectedPeriod = ref('365');
const loading = ref(false);
const loadError = ref('');

const tabs = [
  { id: 'yield', name: 'Yield Report' },
  { id: 'financial', name: 'Financial Report' },
  { id: 'weather', name: 'Weather Correlation' }
];

const chartColors = [
  'rgba(34, 197, 94, 0.5)',
  'rgba(59, 130, 246, 0.5)',
  'rgba(168, 85, 247, 0.5)',
  'rgba(245, 158, 11, 0.5)',
  'rgba(239, 68, 68, 0.5)',
  'rgba(14, 165, 233, 0.5)',
  'rgba(251, 191, 36, 0.5)'
];

const ensureArray = (value) => (Array.isArray(value) ? value : []);
const getColor = (index) => chartColors[index % chartColors.length];

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
  return parsed.toLocaleDateString(undefined, { month: 'short', day: 'numeric' });
};

const monthKey = (date) => {
  const parsed = date ? new Date(date) : null;
  if (!parsed || Number.isNaN(parsed.getTime())) {
    return null;
  }
  return `${parsed.getFullYear()}-${String(parsed.getMonth() + 1).padStart(2, '0')}`;
};

const monthLabelFromKey = (key) => {
  if (!key) return '';
  const [year, month] = key.split('-').map(Number);
  if (!year || !month) return '';
  const date = new Date(year, month - 1, 1);
  return date.toLocaleDateString(undefined, { month: 'short', year: 'numeric' });
};

const computePeriodFilters = (period) => {
  if (period === 'all') {
    return { filters: {}, weatherDays: 365 };
  }

  const days = parseInt(period, 10);
  if (!Number.isFinite(days) || days <= 0) {
    return { filters: {}, weatherDays: 30 };
  }

  const endDate = new Date();
  const startDate = new Date();
  startDate.setDate(endDate.getDate() - (days - 1));

  return {
    filters: {
      date_from: formatDateForApi(startDate),
      date_to: formatDateForApi(endDate),
    },
    weatherDays: Math.min(days, 365),
  };
};

const aggregateByMonth = (records, dateKey, valueKey) => {
  const result = new Map();
  ensureArray(records).forEach((record) => {
    const dateValue = record?.[dateKey];
    const value = Number(record?.[valueKey]);
    if (!dateValue || Number.isNaN(value)) {
      return;
    }

    const key = monthKey(dateValue);
    if (!key) return;

    result.set(key, (result.get(key) || 0) + value);
  });
  return result;
};

const harvests = computed(() => ensureArray(farmStore.harvests));
const fields = computed(() => ensureArray(farmStore.fields));
const sales = computed(() => ensureArray(farmStore.sales));
const expensesList = computed(() => ensureArray(farmStore.expenses));
const weatherHistoryRecords = computed(() => ensureArray(weatherStore.weatherHistory));
// Marketplace orders for revenue calculation
const farmerOrders = computed(() => ensureArray(marketplaceStore.orders));

const loadReportData = async () => {
  if (loading.value) {
    // Allow data refresh even if already loading to keep data current
    console.warn('Reloading farmer reports data...');
  }

  loading.value = true;
  loadError.value = '';

  try {
    await Promise.all([
      farmStore.fetchFarmProfile(),
      farmStore.fetchFields(),
      farmStore.fetchHarvests()
    ]);

    const { filters, weatherDays } = computePeriodFilters(selectedPeriod.value);

    await Promise.all([
      farmStore.fetchSales(filters),
      farmStore.fetchExpenses(filters),
      marketplaceStore.fetchFarmerOrders() // Fetch marketplace orders for revenue
    ]);

    const farmId = farmStore.farmProfile?.id;

    if (farmId) {
      await weatherStore.fetchWeatherHistory(farmId, weatherDays);
    } else {
      console.warn('No farm profile found for weather analytics');
    }
  } catch (error) {
    console.error('Failed to load report data:', error);
    loadError.value = error.userMessage || error.response?.data?.message || 'Unable to load report data. Please try again.';
  } finally {
    loading.value = false;
  }
};

// Yield Report Data
const totalYield = computed(() => {
  const total = harvests.value.reduce((sum, harvest) => sum + (Number(harvest?.yield) || 0), 0);
  return total.toFixed(0);
});

const averageYieldPerHectare = computed(() => {
  if (!harvests.value.length || !fields.value.length) {
    return '0';
  }

  const totalYieldKg = harvests.value.reduce((sum, harvest) => sum + (Number(harvest?.yield) || 0), 0);
  const totalArea = fields.value.reduce((sum, field) => sum + (Number(field?.size) || 0), 0);

  if (totalArea <= 0) {
    return '0';
  }

  return (totalYieldKg / totalArea).toFixed(0);
});

const bestVariety = computed(() => {
  if (!harvests.value.length) {
    return 'N/A';
  }

  const varietyTotals = harvests.value.reduce((acc, harvest) => {
    const variety = harvest?.planting?.crop_type || 'Unknown Variety';
    const yieldValue = Number(harvest?.yield) || 0;
    acc[variety] = (acc[variety] || 0) + yieldValue;
    return acc;
  }, {});

  const entries = Object.entries(varietyTotals);
  if (!entries.length) {
    return 'N/A';
  }

  const [topVariety] = entries.reduce((best, current) => (current[1] > best[1] ? current : best));
  return topVariety;
});

const totalHarvests = computed(() => harvests.value.length);

// Determine the most common unit across all harvests (default to 'kg')
const predominantUnit = computed(() => {
  if (!harvests.value.length) return 'kg';
  const unitCounts = harvests.value.reduce((acc, h) => {
    const unit = h?.unit || 'kg';
    acc[unit] = (acc[unit] || 0) + 1;
    return acc;
  }, {});
  const entries = Object.entries(unitCounts);
  if (!entries.length) return 'kg';
  return entries.reduce((best, current) => (current[1] > best[1] ? current : best))[0];
});

const yieldChartData = computed(() => {
  const ordered = harvests.value
    .filter(harvest => harvest?.harvest_date && !Number.isNaN(new Date(harvest.harvest_date).getTime()))
    .sort((a, b) => new Date(a.harvest_date) - new Date(b.harvest_date))
    .slice(-12);

  if (!ordered.length) {
    return { labels: [], datasets: [] };
  }

  return {
    labels: ordered.map((harvest) => formatLabelDate(harvest.harvest_date)),
    datasets: [{
      label: `Yield (${predominantUnit.value})`,
      data: ordered.map((harvest) => Number(harvest?.yield) || 0),
      borderColor: 'rgb(34, 197, 94)',
      backgroundColor: 'rgba(34, 197, 94, 0.1)',
      tension: 0.1
    }]
  };
});

const varietyChartData = computed(() => {
  const varietyTotals = harvests.value.reduce((acc, harvest) => {
    const variety = harvest?.planting?.crop_type || 'Unknown Variety';
    const yieldValue = Number(harvest?.yield) || 0;
    acc[variety] = (acc[variety] || 0) + yieldValue;
    return acc;
  }, {});

  const entries = Object.entries(varietyTotals).sort((a, b) => b[1] - a[1]);

  if (!entries.length) {
    return { labels: [], datasets: [] };
  }

  const labels = entries.map(([variety]) => variety);
  const data = entries.map(([, total]) => total);

  return {
    labels,
    datasets: [{
      label: `Yield (${predominantUnit.value})`,
      data,
      backgroundColor: labels.map((_, index) => getColor(index))
    }]
  };
});

// Financial Report Data
const totalRevenue = computed(() => {
  // Traditional sales revenue
  const salesTotal = sales.value.reduce((sum, sale) => sum + (Number(sale?.total_amount) || 0), 0);
  // Marketplace orders revenue (paid orders)
  const ordersTotal = farmerOrders.value
    .filter(order => order?.payment_status === 'paid')
    .reduce((sum, order) => sum + (Number(order?.total_amount) || 0), 0);
  return Number((salesTotal + ordersTotal).toFixed(2));
});

const totalExpenses = computed(() => {
  const total = expensesList.value.reduce((sum, expense) => sum + (Number(expense?.amount) || 0), 0);
  return Number(total.toFixed(2));
});

const netProfit = computed(() => {
  const profit = Number(totalRevenue.value) - Number(totalExpenses.value);
  return Number(profit.toFixed(2));
});

const profitMargin = computed(() => {
  const revenue = Number(totalRevenue.value);
  if (revenue <= 0) {
    return '0.0';
  }
  const profit = Number(netProfit.value);
  return ((profit / revenue) * 100).toFixed(1);
});

// Aggregate sales revenue by month
const salesByMonth = computed(() => aggregateByMonth(sales.value, 'sale_date', 'total_amount'));
// Aggregate marketplace orders revenue by month (only paid orders)
const ordersByMonth = computed(() => {
  const confirmedOrders = farmerOrders.value.filter(order => 
    order?.payment_status === 'paid'
  );
  return aggregateByMonth(confirmedOrders, 'order_date', 'total_amount');
});
// Combined revenue by month (sales + orders)
const revenueByMonth = computed(() => {
  const combined = new Map();
  // Add sales
  salesByMonth.value.forEach((value, key) => {
    combined.set(key, (combined.get(key) || 0) + value);
  });
  // Add orders
  ordersByMonth.value.forEach((value, key) => {
    combined.set(key, (combined.get(key) || 0) + value);
  });
  return combined;
});
const expensesByMonth = computed(() => aggregateByMonth(expensesList.value, 'date', 'amount'));

const monthLabels = computed(() => {
  const keys = new Set([
    ...revenueByMonth.value.keys(),
    ...expensesByMonth.value.keys()
  ]);
  return Array.from(keys).sort();
});

const financialChartData = computed(() => {
  if (!monthLabels.value.length) {
    return { labels: [], datasets: [] };
  }

  const labels = monthLabels.value.map(monthLabelFromKey);

  const revenueData = monthLabels.value.map((key) => parseFloat((revenueByMonth.value.get(key) || 0).toFixed(2)));
  const expensesData = monthLabels.value.map((key) => parseFloat((expensesByMonth.value.get(key) || 0).toFixed(2)));

  return {
    labels,
    datasets: [
      {
        label: 'Revenue',
        data: revenueData,
        borderColor: 'rgb(34, 197, 94)',
        backgroundColor: 'rgba(34, 197, 94, 0.15)',
        tension: 0.2,
        fill: true
      },
      {
        label: 'Expenses',
        data: expensesData,
        borderColor: 'rgb(239, 68, 68)',
        backgroundColor: 'rgba(239, 68, 68, 0.15)',
        tension: 0.2,
        fill: true
      }
    ]
  };
});

const expenseChartData = computed(() => {
  if (!expensesList.value.length) {
    return { labels: [], datasets: [] };
  }

  const categoryTotals = expensesList.value.reduce((acc, expense) => {
    const category = expense?.category || 'Uncategorized';
    const amount = Number(expense?.amount) || 0;
    acc[category] = (acc[category] || 0) + amount;
    return acc;
  }, {});

  const entries = Object.entries(categoryTotals).sort((a, b) => b[1] - a[1]);
  const labels = entries.map(([category]) => category);
  const data = entries.map(([, amount]) => Number(amount.toFixed(2)));

  return {
    labels,
    datasets: [{
      data,
      backgroundColor: labels.map((_, index) => getColor(index)),
      borderWidth: 1
    }]
  };
});

// Weather Correlation Data
const weatherByMonth = computed(() => {
  const map = new Map();
  weatherHistoryRecords.value.forEach((record) => {
    const key = monthKey(record?.recorded_at);
    if (!key) return;

    const rainfall = Number(record?.rainfall) || 0;
    const temperature = Number(record?.temperature) || 0;
    const entry = map.get(key) || { rainfall: 0, temperature: 0, count: 0 };

    entry.rainfall += rainfall;
    entry.temperature += temperature;
    entry.count += 1;

    map.set(key, entry);
  });
  return map;
});

const averageRainfall = computed(() => {
  if (!weatherHistoryRecords.value.length) {
    return '0.0';
  }
  const total = weatherHistoryRecords.value.reduce((sum, record) => sum + (Number(record?.rainfall) || 0), 0);
  return (total / weatherHistoryRecords.value.length).toFixed(1);
});

const averageTemperature = computed(() => {
  if (!weatherHistoryRecords.value.length) {
    return '0.0';
  }
  const total = weatherHistoryRecords.value.reduce((sum, record) => sum + (Number(record?.temperature) || 0), 0);
  return (total / weatherHistoryRecords.value.length).toFixed(1);
});

const weatherImpact = computed(() => {
  if (!weatherHistoryRecords.value.length) {
    return '0';
  }
  const favorable = weatherHistoryRecords.value.filter((record) => {
    const rainfall = Number(record?.rainfall);
    const temperature = Number(record?.temperature);
    if (Number.isNaN(rainfall) || Number.isNaN(temperature)) {
      return false;
    }
    return rainfall >= 60 && rainfall <= 140 && temperature >= 20 && temperature <= 35;
  }).length;

  return ((favorable / weatherHistoryRecords.value.length) * 100).toFixed(0);
});

const yieldByMonth = computed(() => aggregateByMonth(harvests.value, 'harvest_date', 'yield'));

const weatherCorrelationData = computed(() => {
  const keys = new Set([
    ...weatherByMonth.value.keys(),
    ...yieldByMonth.value.keys()
  ]);

  const orderedKeys = Array.from(keys).sort();

  if (!orderedKeys.length) {
    return { labels: [], datasets: [] };
  }

  const labels = orderedKeys.map(monthLabelFromKey);
  const rainfallData = orderedKeys.map((key) => {
    const entry = weatherByMonth.value.get(key);
    if (!entry || entry.count === 0) return 0;
    return Number((entry.rainfall / entry.count).toFixed(1));
  });
  const yieldData = orderedKeys.map((key) => {
    const totalYield = yieldByMonth.value.get(key) || 0;
    return Number(totalYield.toFixed(1));
  });

  return {
    labels,
    datasets: [
      {
        label: 'Avg Rainfall (mm)',
        data: rainfallData,
        borderColor: 'rgb(59, 130, 246)',
        backgroundColor: 'rgba(59, 130, 246, 0.1)',
        tension: 0.2,
        yAxisID: 'y'
      },
      {
        label: `Yield (${predominantUnit.value})`,
        data: yieldData,
        borderColor: 'rgb(34, 197, 94)',
        backgroundColor: 'rgba(34, 197, 94, 0.1)',
        tension: 0.2,
        yAxisID: 'y1'
      }
    ]
  };
});

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      display: true
    }
  },
  scales: {
    y: {
      beginAtZero: true
    }
  }
};

const weatherChartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      display: true,
      position: 'bottom'
    }
  },
  scales: {
    y: {
      beginAtZero: true,
      position: 'left'
    },
    y1: {
      beginAtZero: true,
      position: 'right',
      grid: {
        drawOnChartArea: false
      }
    }
  }
};

const pieChartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'bottom'
    }
  }
};



  // Export Button State
  const showExportMenu = ref(false);

  const handleExport = (type) => {
    showExportMenu.value = false;
    
    if (loading.value || loadError.value) return;

    // JSON Export
    if (type === 'json') {
      const payload = {
        generated_at: new Date().toISOString(),
        period: selectedPeriod.value,
        totals: {
          total_yield: Number(totalYield.value) || 0,
          yield_unit: predominantUnit.value,
          average_yield_per_hectare: Number(averageYieldPerHectare.value) || 0,
          best_variety: bestVariety.value,
          harvest_count: totalHarvests.value,
          revenue: Number(totalRevenue.value) || 0,
          expenses: Number(totalExpenses.value) || 0,
          net_profit: Number(netProfit.value) || 0,
          profit_margin: Number(profitMargin.value) || 0,
        },
        weather: {
          average_rainfall_mm: Number(averageRainfall.value) || 0,
          average_temperature_c: Number(averageTemperature.value) || 0,
          favorable_conditions_percent: Number(weatherImpact.value) || 0,
        },
        generated_from: 'FarmerReportsIndex',
      };

      const blob = new Blob([JSON.stringify(payload, null, 2)], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const anchor = document.createElement('a');
      anchor.href = url;
      anchor.download = `farmer-report-${selectedPeriod.value}-${Date.now()}.json`;
      document.body.appendChild(anchor);
      anchor.click();
      document.body.removeChild(anchor);
      URL.revokeObjectURL(url);
      return;
    }

    // PDF or CSV Export
    if (activeTab.value === 'financial') {
      const data = {
        totalRevenue: formatCurrency(totalRevenue.value),
        totalExpenses: formatCurrency(totalExpenses.value),
        netProfit: formatCurrency(netProfit.value),
        expensesByCategory: expensesList.value.reduce((acc, expense) => {
             // Simple grouping for display
             const cat = expense.category || 'Uncategorized';
             const existing = acc.find(i => i.category === cat);
             if (existing) {
                 existing.amount += Number(expense.amount);
             } else {
                 acc.push({ category: cat, amount: Number(expense.amount), percentage: 0 }); // calc percentage later
             }
             return acc;
        }, []).map(item => {
            item.percentage = totalExpenses.value > 0 ? (item.amount / totalExpenses.value) * 100 : 0;
            return item;
        })
      };
      
      if (type === 'pdf') {
        pdfExport.exportFinancialReport(data, { title: 'Financial Report', period: selectedPeriod.value });
      } else if (type === 'csv') {
        csvExport.exportFinancialReport(data, { title: 'Financial Report' });
      }
      
    } else if (activeTab.value === 'yield') {
      const data = {
        totalHarvests: totalHarvests.value,
        totalYield: totalYield.value,
        avgYieldPerHa: Number(averageYieldPerHectare.value),
        harvests: harvests.value.map(h => ({
            harvest_date: h.harvest_date,
            field_name: h.planting?.field?.name || 'Unknown',
            variety_name: h.planting?.crop_type || 'Unknown',
            yield: h.yield,
            quality_grade: h.quality || 'N/A'
        }))
      };

      if (type === 'pdf') {
        pdfExport.exportCropYieldReport(data, { title: 'Yield Report', unit: predominantUnit.value });
      } else if (type === 'csv') {
        csvExport.exportCropYieldReport(data, { title: 'Yield Report', unit: predominantUnit.value });
      }

    } else if (activeTab.value === 'weather') {
      const data = {
          current: {
              // Mock current as we iterate over history usually
             temperature: averageTemperature.value,
             humidity: 'N/A', // Not in current aggregations
             wind_speed: 'N/A',
             conditions: 'N/A'
          }, 
          gdd: {
              total: 0, // Placeholder
              weekly_avg: 0
          }
      };
      
      if (type === 'pdf') {
        pdfExport.exportWeatherReport(data, { title: 'Weather Report' });
      } else if (type === 'csv') {
        csvExport.exportWeatherReport(data, { title: 'Weather Report' });
      }
    }
  };

  /*
  const exportReport = () => {
    // ... removed old implementation
  };
  */


watch(selectedPeriod, () => {
  loadReportData();
});

onMounted(() => {
  if (route.query.tab) {
    const targetTab = tabs.find(t => t.id === route.query.tab);
    if (targetTab) {
      activeTab.value = targetTab.id;
    }
  }
  loadReportData();
});
</script>
<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease, transform 0.2s ease; }
.fade-enter-from { opacity: 0; transform: translateY(10px); }
.fade-leave-to { opacity: 0; transform: translateY(-10px); }
</style>