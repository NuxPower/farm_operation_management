<template>
  <div class="min-h-screen bg-gray-50/50 font-sans text-gray-900">
    <div class="w-full mx-auto px-6 py-8">

      <!-- Header & Date Controls -->
      <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
          <h1 class="text-3xl font-bold text-gray-800">
            Data Analytics Hub
          </h1>
          <p class="text-gray-500 mt-1">Comprehensive insights from your farm data</p>
        </div>

        <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 bg-white p-3 rounded-xl shadow-sm border border-gray-200 w-full md:w-auto">
          <select 
            v-model="selectedPeriod"
            class="px-3 py-1.5 border border-gray-200 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 bg-gray-50 outline-none transition-all mr-2"
          >
            <option value="30">Last 30 Days</option>
            <option value="90">Last 3 Months</option>
            <option value="365">Last Year</option>
            <option value="all">All Time</option>
          </select>
          <div class="flex items-center gap-2">
            <label class="text-sm font-medium text-gray-600 w-10 sm:w-auto">From</label>
            <input
              v-model="startDate"
              type="date"
              class="flex-1 sm:flex-none w-full sm:w-auto px-3 py-1.5 border border-gray-200 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-all"
            />
          </div>
          <div class="flex items-center gap-2">
            <label class="text-sm font-medium text-gray-600 w-10 sm:w-auto">To</label>
            <input
              v-model="endDate"
              type="date"
              class="flex-1 sm:flex-none w-full sm:w-auto px-3 py-1.5 border border-gray-200 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-all"
            />
          </div>
          <button
            @click="fetchAnalytics"
            :disabled="isLoading"
            class="w-full sm:w-auto mt-1 sm:mt-0 px-5 py-2 sm:py-1.5 bg-emerald-600 text-white rounded-lg text-sm font-medium hover:bg-emerald-700 active:bg-emerald-800 transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-sm flex justify-center items-center"
          >
            <span v-if="isLoading" class="flex items-center gap-2">
              <svg class="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Updating...
            </span>
            <span v-else>Update</span>
          </button>
        </div>
      </div>

      <!-- Main Navigation Tabs -->
      <div class="bg-white p-1 rounded-xl shadow-sm border border-gray-200 inline-flex flex-wrap mb-8 w-full md:w-auto overflow-x-auto">
        <button 
          v-for="tab in tabs" 
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="[
            'px-5 py-2.5 text-sm font-semibold rounded-lg transition-all duration-200 flex items-center gap-2 whitespace-nowrap',
            activeTab === tab.id 
              ? 'bg-emerald-600 text-white shadow-md' 
              : 'text-gray-500 hover:text-gray-900 hover:bg-gray-50'
          ]"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="tab.icon"></path>
          </svg>
          {{ tab.name }}
        </button>
      </div>

      <div v-if="isLoading && !analyticsData" class="flex items-center justify-center py-32">
        <div class="text-center">
          <div class="animate-spin rounded-full h-12 w-12 border-[3px] border-emerald-100 border-t-emerald-600 mx-auto"></div>
          <p class="mt-4 text-gray-500 font-medium animate-pulse">Gathering insights...</p>
        </div>
      </div>

      <div v-else-if="analyticsData" class="space-y-6">
        <transition mode="out-in" name="fade">
          <div :key="activeTab">

            <!-- TAB 1: OVERVIEW -->
            <div v-if="activeTab === 'overview'" class="space-y-6">
              <!-- Executive Summary -->
              <div
                v-if="analyticsData.executive_summary"
                class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden"
              >
                <div class="flex flex-col md:flex-row">
                  <div
                    :class="[
                      'w-full md:w-1.5 h-2 md:h-auto',
                      analyticsData.executive_summary.tone === 'positive' ? 'bg-emerald-500' :
                      analyticsData.executive_summary.tone === 'concern' ? 'bg-amber-500' :
                      'bg-blue-500'
                    ]"
                  ></div>

                  <div class="p-6 flex-1">
                    <div class="flex items-start gap-4">
                      <div
                        :class="[
                          'p-2.5 rounded-lg shrink-0',
                          analyticsData.executive_summary.tone === 'positive' ? 'bg-emerald-50 text-emerald-600' :
                          analyticsData.executive_summary.tone === 'concern' ? 'bg-amber-50 text-amber-600' :
                          'bg-blue-50 text-blue-600'
                        ]"
                      >
                        <svg v-if="analyticsData.executive_summary.tone === 'positive'" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path></svg>
                        <svg v-else-if="analyticsData.executive_summary.tone === 'concern'" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
                        <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                      </div>
                      <div>
                        <h2 class="text-base font-semibold text-gray-900 mb-1">Executive Summary</h2>
                        <p class="text-gray-600 text-sm leading-relaxed max-w-4xl">
                          {{ analyticsData.executive_summary.text }}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Recommended Actions -->
              <div v-if="analyticsData.action_suggestions?.length">
                <div class="flex items-center justify-between mb-4 px-1">
                  <h2 class="text-lg font-semibold text-gray-900 flex items-center gap-2">
                    Recommended Actions
                  </h2>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4 items-stretch">
                  <div
                    v-for="(suggestion, index) in analyticsData.action_suggestions"
                    :key="index"
                    @click="navigateTo(suggestion.action_url)"
                    class="group bg-white rounded-xl p-5 border border-gray-200 shadow-sm hover:shadow-md hover:border-emerald-300 transition-all cursor-pointer relative overflow-hidden min-h-[172px]"
                  >
                    <div :class="[
                      'absolute top-0 left-0 w-full h-1',
                      ['urgent', 'high'].includes(suggestion.priority) ? 'bg-rose-500' :
                      suggestion.priority === 'medium' ? 'bg-amber-500' :
                      'bg-emerald-400'
                    ]"></div>

                    <div class="flex flex-col h-full">
                      <div class="flex justify-between items-start gap-3 mb-3">
                        <svg class="w-6 h-6 shrink-0 text-gray-700 group-hover:text-emerald-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" :d="getSuggestionIcon(suggestion.icon)"></path>
                        </svg>
                        <span
                          :class="[
                            'text-[10px] font-bold uppercase tracking-wider px-2 py-1 rounded-full whitespace-nowrap',
                            ['urgent', 'high'].includes(suggestion.priority) ? 'bg-rose-50 text-rose-700' :
                            suggestion.priority === 'medium' ? 'bg-amber-50 text-amber-700' :
                            'bg-emerald-50 text-emerald-700'
                          ]"
                        >
                          {{ suggestion.priority }}
                        </span>
                      </div>

                      <h3 class="text-sm font-semibold text-gray-900 mb-1 break-words">{{ suggestion.category }}</h3>
                      <p class="text-sm text-gray-500 mb-4 leading-relaxed break-words flex-grow">{{ suggestion.message }}</p>

                      <div class="flex items-center gap-1 text-xs font-medium text-emerald-600 group-hover:text-emerald-700 transition-colors">
                        <span class="break-words">{{ suggestion.action_label }}</span>
                        <svg class="w-3 h-3 shrink-0 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Financial Flow Chart -->
                <div class="lg:col-span-2 bg-white rounded-xl border border-gray-200 p-6 shadow-sm">
                  <h3 class="text-lg font-bold text-gray-800 mb-6">Financial Overview Flow</h3>
                  <div class="h-72">
                    <LineChart v-if="financialChartData.labels.length > 0" :data="financialChartData" :options="chartOptions" />
                    <NoData v-else />
                  </div>
                </div>

                <!-- Quick Stats -->
                <div class="flex flex-col gap-4">
                   <div class="bg-white rounded-lg p-5 shadow-sm border border-gray-200">
                      <p class="text-xs font-medium text-gray-500 uppercase tracking-wide">Pending Tasks</p>
                      <p class="text-3xl font-bold text-gray-900 mt-1">{{ analyticsData.tasks?.total_tasks - analyticsData.tasks?.completed_tasks }}</p>
                   </div>
                   <div class="bg-white rounded-lg p-5 shadow-sm border border-gray-200">
                      <p class="text-xs font-medium text-gray-500 uppercase tracking-wide">Pest Alerts</p>
                      <p class="text-3xl font-bold mt-1" :class="(analyticsData.pests?.active_incidents ?? 0) > 0 ? 'text-rose-600' : 'text-emerald-600'">{{ analyticsData.pests?.active_incidents ?? 0 }}</p>
                   </div>
                   <div class="bg-white rounded-lg p-5 shadow-sm border border-gray-200 flex-1">
                      <p class="text-xs font-medium text-gray-500 uppercase tracking-wide">Net Profit</p>
                      <p class="text-3xl font-bold mt-1" :class="netProfit >= 0 ? 'text-emerald-600' : 'text-rose-600'">{{ formatCurrency(netProfit) }}</p>
                      <div class="mt-4 pt-4 border-t border-gray-100 flex justify-between text-sm">
                        <span class="text-gray-500">Margin</span>
                        <span class="font-medium text-gray-900" v-if="(analyticsData.sales?.total_revenue ?? 0) > 0">
                          {{ ((netProfit / analyticsData.sales.total_revenue) * 100).toFixed(1) }}%
                        </span>
                        <span v-else>0%</span>
                      </div>
                   </div>
                </div>
              </div>
            </div>

            <!-- TAB 2: CROP & PRODUCTION -->
            <div v-if="activeTab === 'production'" class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Fields Area -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 flex flex-col justify-between">
                  <div>
                    <p class="text-sm font-medium text-gray-500">Total Fields Area</p>
                    <h3 class="text-3xl font-bold text-gray-900 mt-2">{{ analyticsData.fields?.total_area ?? 0 }} <span class="text-lg font-normal text-gray-500">ha</span></h3>
                  </div>
                  <div class="mt-4">
                    <div class="flex justify-between text-sm mb-1">
                      <span class="text-gray-500">Utilization Rate</span>
                      <span class="font-medium text-emerald-600">{{ analyticsData.fields?.utilization_rate ?? 0 }}%</span>
                    </div>
                    <div class="w-full bg-gray-100 rounded-full h-2">
                      <div class="bg-emerald-500 h-2 rounded-full" :style="{ width: `${analyticsData.fields?.utilization_rate ?? 0}%` }"></div>
                    </div>
                  </div>
                </div>

                <!-- Seedbed Nursery -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 flex flex-col justify-between">
                  <div>
                    <p class="text-sm font-medium text-gray-500">Seedbed Nursery</p>
                    <h3 class="text-3xl font-bold text-gray-900 mt-2">{{ analyticsData.nursery?.active_batches ?? 0 }} <span class="text-lg font-normal text-gray-500">active batches</span></h3>
                  </div>
                  <div class="mt-4">
                    <div class="flex items-center gap-2 text-sm text-emerald-600 font-medium">
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                      {{ analyticsData.nursery?.ready_for_transplant ?? 0 }} ready for transplant
                    </div>
                  </div>
                </div>

                <!-- Crop Failures -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 flex flex-col justify-between">
                  <div>
                    <p class="text-sm font-medium text-gray-500">Crop Failure Rate</p>
                    <h3 class="text-3xl font-bold text-rose-600 mt-2">{{ analyticsData.failure_analysis?.failure_rate_pct ?? 0 }}%</h3>
                  </div>
                  <div class="mt-4 text-sm text-gray-600">
                    <span class="font-medium">{{ analyticsData.failure_analysis?.total_failed ?? 0 }}</span> plantings failed
                    <div class="text-rose-600 font-medium mt-1">Loss: {{ formatCurrency(analyticsData.failure_analysis?.total_crop_loss_value ?? 0) }}</div>
                  </div>
                </div>
              </div>

              <!-- Crop Charts -->
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6 hover:shadow-md transition-shadow">
                  <div class="flex justify-between items-center mb-6">
                    <h3 class="text-lg font-bold text-gray-800">Yield Over Time</h3>
                    <span class="text-xs font-medium px-2 py-1 bg-gray-100 text-gray-500 rounded">Timeline</span>
                  </div>
                  <div class="h-72">
                    <LineChart v-if="yieldChartData.labels.length > 0" :data="yieldChartData" :options="chartOptions" />
                    <NoData v-else />
                  </div>
                </div>

                <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6 hover:shadow-md transition-shadow">
                  <div class="flex justify-between items-center mb-6">
                    <h3 class="text-lg font-bold text-gray-800">Variety Distribution</h3>
                    <span class="text-xs font-medium px-2 py-1 bg-gray-100 text-gray-500 rounded">Yield Categories</span>
                  </div>
                  <div class="h-72">
                    <BarChart v-if="varietyChartData.labels.length > 0" :data="varietyChartData" :options="chartOptions" />
                    <NoData v-else />
                  </div>
                </div>
              </div>

              <!-- Post-Harvest Processing Analytics -->
              <div v-if="analyticsData.post_harvest?.total_processes > 0" class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                <div class="p-6 border-b border-gray-100 flex justify-between items-center">
                    <h3 class="text-lg font-bold text-gray-900">Post-Harvest Processing</h3>
                    <span class="text-xs font-medium text-gray-500 bg-gray-100 px-3 py-1 rounded-full">{{ analyticsData.post_harvest.total_processes }} processes</span>
                </div>
                <div class="p-6">
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                      <div class="text-center p-4 bg-emerald-50 rounded-xl border border-emerald-100">
                          <div class="text-2xl font-bold text-emerald-700">{{ analyticsData.post_harvest.average_recovery_rate }}%</div>
                          <div class="text-xs text-gray-500 mt-1 uppercase tracking-wider">Avg Recovery</div>
                      </div>
                      <div class="text-center p-4 bg-amber-50 rounded-xl border border-amber-100">
                          <div class="text-2xl font-bold text-amber-700">{{ formatCurrency(analyticsData.post_harvest.cost_optimization?.self_avg_cost ?? 0) }}</div>
                          <div class="text-xs text-gray-500 mt-1 uppercase tracking-wider">Self Cost/Unit</div>
                      </div>
                      <div class="text-center p-4 bg-blue-50 rounded-xl border border-blue-100">
                          <div class="text-2xl font-bold text-blue-700">{{ formatCurrency(analyticsData.post_harvest.cost_optimization?.provider_avg_cost ?? 0) }}</div>
                          <div class="text-xs text-gray-500 mt-1 uppercase tracking-wider">Provider Cost</div>
                      </div>
                      <div class="text-center p-4 bg-violet-50 rounded-xl border border-violet-100">
                          <div class="text-2xl font-bold text-violet-700">{{ analyticsData.post_harvest.total_processes }}</div>
                          <div class="text-xs text-gray-500 mt-1 uppercase tracking-wider">Completed</div>
                      </div>
                    </div>
                </div>
              </div>
            </div>

            <!-- TAB 3: FINANCIALS -->
            <div v-if="activeTab === 'financials'" class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Revenue -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 border-t-4 border-t-emerald-500">
                  <div class="flex justify-between items-start mb-4">
                    <div>
                      <p class="text-sm font-medium text-gray-500">Total Revenue</p>
                      <h3 class="text-2xl font-bold text-gray-900 mt-1">{{ formatCurrency(analyticsData.sales?.total_revenue ?? 0) }}</h3>
                    </div>
                  </div>
                  <div class="space-y-2 pt-2 border-t border-gray-50">
                    <div class="flex justify-between text-sm">
                      <span class="text-gray-500">Total Orders</span>
                      <span class="font-medium text-gray-900">{{ analyticsData.sales?.total_orders ?? 0 }}</span>
                    </div>
                    <div class="flex justify-between text-sm">
                      <span class="text-gray-500">Pending Orders</span>
                      <span class="font-medium text-amber-600">{{ analyticsData.sales?.pending_orders ?? 0 }}</span>
                    </div>
                  </div>
                </div>

                <!-- Expenses -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 border-t-4 border-t-rose-500">
                  <div class="flex justify-between items-start mb-4">
                    <div>
                      <p class="text-sm font-medium text-gray-500">Total Expenses</p>
                      <h3 class="text-2xl font-bold text-gray-900 mt-1">{{ formatCurrency(analyticsData.expenses?.total_expenses ?? 0) }}</h3>
                    </div>
                  </div>
                  <div class="space-y-2 pt-2 border-t border-gray-50">
                    <div class="flex justify-between text-sm">
                      <span class="text-gray-500">Trend</span>
                      <span :class="['font-medium flex items-center gap-1', (analyticsData.expenses?.trend_percentage ?? 0) > 0 ? 'text-rose-600' : 'text-emerald-600']">
                        {{ (analyticsData.expenses?.trend_percentage ?? 0) > 0 ? '+' : '' }}{{ analyticsData.expenses?.trend_percentage ?? 0 }}%
                      </span>
                    </div>
                    <div class="flex justify-between text-sm">
                      <span class="text-gray-500">Expense Records</span>
                      <span class="font-medium text-gray-900">{{ analyticsData.expenses?.expense_count ?? 0 }}</span>
                    </div>
                  </div>
                </div>

                <!-- Net Profit -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 border-t-4 border-t-blue-500">
                  <div class="flex justify-between items-start mb-4">
                    <div>
                      <p class="text-sm font-medium text-gray-500">Net Profit</p>
                      <h3 class="text-2xl font-bold mt-1" :class="netProfit >= 0 ? 'text-blue-600' : 'text-rose-600'">
                        {{ formatCurrency(netProfit) }}
                      </h3>
                    </div>
                  </div>
                  <div class="space-y-2 pt-2 border-t border-gray-50">
                    <div class="flex justify-between text-sm">
                      <span class="text-gray-500">Margin</span>
                      <span class="font-medium text-gray-900" v-if="(analyticsData.sales?.total_revenue ?? 0) > 0">
                        {{ ((netProfit / analyticsData.sales.total_revenue) * 100).toFixed(1) }}%
                      </span>
                      <span v-else>0%</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Financial Forecast & Expense Breakdown Charts -->
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Financial Forecast -->
                <div v-if="analyticsData.financial_forecast" class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                  <div class="mb-8 flex justify-between items-center">
                    <h3 class="text-lg font-bold text-gray-900">Projected Cash Flow</h3>
                    <div class="flex gap-4 text-xs">
                        <div class="flex items-center gap-1.5"><span class="w-3 h-3 rounded bg-emerald-400"></span> Rev</div>
                        <div class="flex items-center gap-1.5"><span class="w-3 h-3 rounded bg-rose-400"></span> Exp</div>
                    </div>
                  </div>
                  <div class="h-64 flex items-end justify-between gap-2 md:gap-4 overflow-x-auto pb-2">
                    <div v-for="(month, index) in analyticsData.financial_forecast.months" :key="index" class="flex flex-col items-center gap-2 flex-1 min-w-[60px]">
                        <div class="w-full flex items-end justify-center gap-1 h-48 relative border-b border-gray-100">
                          <div class="w-3 md:w-6 bg-emerald-400 rounded-t-sm hover:bg-emerald-500 transition-all relative group"
                              :style="{ height: `${Math.min((analyticsData.financial_forecast.projected_revenue[index] / (Math.max(...analyticsData.financial_forecast.projected_revenue, ...analyticsData.financial_forecast.projected_expenses) || 1)) * 100, 100)}%` }">
                              <div class="opacity-0 group-hover:opacity-100 absolute bottom-full left-1/2 -translate-x-1/2 mb-1 bg-gray-900 text-white text-[10px] px-2 py-1 rounded whitespace-nowrap z-20 shadow-lg pointer-events-none">
                                {{ formatCurrency(analyticsData.financial_forecast.projected_revenue[index]) }}
                              </div>
                          </div>
                          <div class="w-3 md:w-6 bg-rose-400 rounded-t-sm hover:bg-rose-500 transition-all relative group"
                              :style="{ height: `${Math.min((analyticsData.financial_forecast.projected_expenses[index] / (Math.max(...analyticsData.financial_forecast.projected_revenue, ...analyticsData.financial_forecast.projected_expenses) || 1)) * 100, 100)}%` }">
                              <div class="opacity-0 group-hover:opacity-100 absolute bottom-full left-1/2 -translate-x-1/2 mb-1 bg-gray-900 text-white text-[10px] px-2 py-1 rounded whitespace-nowrap z-20 shadow-lg pointer-events-none">
                                {{ formatCurrency(analyticsData.financial_forecast.projected_expenses[index]) }}
                              </div>
                          </div>
                        </div>
                        <span class="text-xs font-medium text-gray-500 truncate w-full text-center">{{ month }}</span>
                    </div>
                  </div>
                </div>

                <!-- Expense Breakdown Pie Chart -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
                  <h3 class="text-lg font-bold text-gray-800 mb-6">Historical Expense Breakdown</h3>
                  <div class="h-72 flex flex-col items-center">
                    <PieChart v-if="expenseChartData.labels.length > 0" :data="expenseChartData" :options="pieChartOptions" />
                    <NoData v-else />
                  </div>
                </div>
              </div>
            </div>

            <!-- TAB 4: OPERATIONS & TASKS -->
            <div v-if="activeTab === 'operations'" class="space-y-6">
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Task Distribution -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
                  <h3 class="text-lg font-bold text-gray-900 mb-6">Task Distribution</h3>
                  <div class="flex items-center justify-center">
                      <div class="relative w-40 h-40 mr-8 flex-shrink-0">
                        <svg viewBox="0 0 100 100" class="w-full h-full transform -rotate-90">
                          <circle cx="50" cy="50" r="40" fill="transparent" stroke="#e5e7eb" stroke-width="12" />
                          <circle cx="50" cy="50" r="40" fill="transparent" stroke="#10b981" stroke-width="12"
                            :stroke-dasharray="`${completedPercent * 2.51} 251.2`" class="transition-all duration-1000 ease-out" />
                          <circle cx="50" cy="50" r="40" fill="transparent" stroke="#f59e0b" stroke-width="12"
                            :stroke-dasharray="`${pendingPercent * 2.51} 251.2`" :stroke-dashoffset="`${-completedPercent * 2.51}`" class="transition-all duration-1000 ease-out" />
                          <circle cx="50" cy="50" r="40" fill="transparent" stroke="#f43f5e" stroke-width="12"
                            :stroke-dasharray="`${overduePercent * 2.51} 251.2`" :stroke-dashoffset="`${-(completedPercent + pendingPercent) * 2.51}`" class="transition-all duration-1000 ease-out" />
                        </svg>
                        <div class="absolute inset-0 flex flex-col items-center justify-center">
                            <span class="text-3xl font-bold text-gray-900">{{ analyticsData.tasks?.total_tasks ?? 0 }}</span>
                            <span class="text-[10px] text-gray-500 uppercase tracking-widest mt-1">Tasks</span>
                        </div>
                      </div>

                      <div class="flex-1 space-y-4">
                        <div class="flex justify-between items-center bg-emerald-50/50 p-3 rounded-lg border border-emerald-100">
                            <div class="flex items-center gap-2">
                              <span class="w-3 h-3 rounded-full bg-emerald-500"></span>
                              <span class="font-medium text-emerald-800">Completed</span>
                            </div>
                            <span class="font-bold text-emerald-900 text-lg">{{ analyticsData.tasks?.completed_tasks ?? 0 }}</span>
                        </div>
                          <div class="flex justify-between items-center bg-amber-50/50 p-3 rounded-lg border border-amber-100">
                            <div class="flex items-center gap-2">
                              <span class="w-3 h-3 rounded-full bg-amber-500"></span>
                              <span class="font-medium text-amber-800">Pending</span>
                            </div>
                            <span class="font-bold text-amber-900 text-lg">{{ analyticsData.tasks?.pending_tasks ?? 0 }}</span>
                        </div>
                          <div class="flex justify-between items-center bg-rose-50/50 p-3 rounded-lg border border-rose-100">
                            <div class="flex items-center gap-2">
                              <span class="w-3 h-3 rounded-full bg-rose-500"></span>
                              <span class="font-medium text-rose-800">Overdue</span>
                            </div>
                            <span class="font-bold text-rose-900 text-lg">{{ analyticsData.tasks?.overdue_tasks ?? 0 }}</span>
                        </div>
                      </div>
                  </div>
                </div>

                <!-- Inventory Stock -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
                  <div class="flex justify-between items-start mb-6">
                    <div>
                      <p class="text-sm font-medium text-gray-500">Total Stock Value</p>
                      <h3 class="text-2xl font-bold text-gray-900 mt-1">{{ formatCurrency(analyticsData.inventory?.total_value ?? 0) }}</h3>
                    </div>
                    <div class="w-12 h-12 rounded-lg bg-emerald-50 flex items-center justify-center text-emerald-600">
                      <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path></svg>
                    </div>
                  </div>
                  <!-- Alert badges -->
                  <div class="flex flex-col gap-2 mb-4" v-if="(analyticsData.inventory?.low_stock_count ?? 0) > 0 || (analyticsData.inventory?.expiring_soon_count ?? 0) > 0">
                    <span v-if="analyticsData.inventory?.low_stock_count > 0" class="inline-flex items-center px-3 py-1.5 rounded-md text-sm font-medium bg-rose-50 text-rose-700 border border-rose-100">
                      <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
                      {{ analyticsData.inventory.low_stock_count }} items running low
                    </span>
                    <span v-if="analyticsData.inventory?.expiring_soon_count > 0" class="inline-flex items-center px-3 py-1.5 rounded-md text-sm font-medium bg-amber-50 text-amber-700 border border-amber-100">
                      <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                      {{ analyticsData.inventory.expiring_soon_count }} items expiring soon
                    </span>
                  </div>
                  
                  <div class="pt-4 border-t border-gray-100 space-y-3">
                    <div class="flex justify-between items-center text-sm">
                      <span class="text-gray-500">Usage (Last 90d)</span>
                      <span class="font-bold text-gray-900">{{ formatNumber(analyticsData.inventory?.historical_usage?.total_consumed ?? 0) }} units used</span>
                    </div>
                    <div v-if="analyticsData.inventory?.historical_usage?.most_consumed_item" class="flex justify-between items-center text-sm bg-gray-50 p-2 rounded-md">
                      <span class="text-gray-500">Top Item Consumed</span>
                      <span class="font-bold text-emerald-600">
                        {{ analyticsData.inventory.historical_usage.most_consumed_item.name }}
                      </span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Laborers Info -->
              <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
                <h3 class="text-lg font-bold text-gray-900 mb-6">Labor Workforce</h3>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 divide-x divide-gray-100">
                    <div class="px-4 text-center">
                      <div class="text-xs text-gray-500 uppercase tracking-wide mb-1">Total Laborers</div>
                      <div class="text-3xl font-bold text-gray-900">{{ analyticsData.laborers?.total_laborers ?? 0 }}</div>
                    </div>
                    <div class="px-4 text-center">
                      <div class="text-xs text-gray-500 uppercase tracking-wide mb-1">Active Now</div>
                      <div class="text-3xl font-bold text-emerald-600">{{ analyticsData.laborers?.active_laborers ?? 0 }}</div>
                    </div>
                    <div class="px-4 text-center">
                      <div class="text-xs text-gray-500 uppercase tracking-wide mb-1">Payroll Est.</div>
                      <div class="text-3xl font-bold text-gray-900">{{ formatCurrency(analyticsData.laborers?.total_labor_cost ?? 0) }}</div>
                    </div>
                    <div class="px-4 text-center border-none">
                      <div class="text-xs text-gray-500 uppercase tracking-wide mb-1">Efficiency</div>
                      <div class="text-3xl font-bold text-emerald-600">{{ analyticsData.laborers?.completion_rate ?? 0 }}%</div>
                    </div>
                </div>
              </div>
            </div>

            <!-- TAB 5: WEATHER & PESTS -->
            <div v-if="activeTab === 'weather'" class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Weather Stats -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200 flex items-center justify-between col-span-1 md:col-span-2 bg-gradient-to-br from-emerald-50 to-white">
                  <div>
                    <p class="text-sm font-semibold text-emerald-800 uppercase tracking-wider mb-2">Average Farm Climate</p>
                    <div class="flex gap-8 mt-4">
                      <div>
                        <span class="text-gray-500 text-sm">Temperature</span>
                        <h3 class="text-4xl font-bold text-gray-900 mt-1">{{ analyticsData.weather?.avg_temperature ?? '--' }}<span class="text-xl text-gray-500 font-normal">°C</span></h3>
                      </div>
                      <div>
                        <span class="text-gray-500 text-sm">Rainfall</span>
                        <h3 class="text-4xl font-bold text-blue-600 mt-1">{{ analyticsData.weather?.total_rainfall ?? '--' }}<span class="text-xl text-blue-400 font-normal">mm</span></h3>
                      </div>
                      <div>
                        <span class="text-gray-500 text-sm">Humidity</span>
                        <h3 class="text-4xl font-bold text-gray-900 mt-1">{{ analyticsData.weather?.avg_humidity ?? '--' }}<span class="text-xl text-gray-500 font-normal">%</span></h3>
                      </div>
                    </div>
                  </div>
                  <div class="hidden sm:block opacity-20">
                    <svg class="w-32 h-32 text-emerald-900" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2.25a.75.75 0 01.75.75v2.25a.75.75 0 01-1.5 0V3a.75.75 0 01.75-.75zM7.5 12a4.5 4.5 0 119 0 4.5 4.5 0 01-9 0zM18.894 6.166a.75.75 0 00-1.06-1.06l-1.591 1.59a.75.75 0 101.06 1.061l1.591-1.59zM21.75 12a.75.75 0 01-.75.75h-2.25a.75.75 0 010-1.5H21a.75.75 0 01.75.75zM17.834 18.894a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 10-1.061 1.06l1.59 1.591zM12 18.75a.75.75 0 01.75.75V21a.75.75 0 01-1.5 0v-1.5a.75.75 0 01.75-.75zM6.166 18.894a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 10-1.06 1.061l1.59 1.59zM2.25 12a.75.75 0 01.75-.75H5.25a.75.75 0 010 1.5H3a.75.75 0 01-.75-.75zM6.166 5.106a.75.75 0 00-1.06 1.06l1.59 1.591a.75.75 0 101.06-1.06l-1.59-1.591z"></path></svg>
                  </div>
                </div>

                <!-- Pest Incidents Summary -->
                <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
                  <h3 class="text-lg font-bold text-gray-900 mb-4">Pest Incidents</h3>
                  <div class="flex items-center justify-between mb-4">
                    <p class="text-3xl font-bold text-gray-900">{{ analyticsData.pests?.total_incidents ?? 0 }}</p>
                    <p :class="['text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider', (analyticsData.pests?.active_incidents ?? 0) > 0 ? 'bg-rose-100 text-rose-700' : 'bg-emerald-100 text-emerald-700']">
                      {{ analyticsData.pests?.active_incidents ?? 0 }} active
                    </p>
                  </div>
                  <!-- Type mini-bars -->
                  <div v-if="Object.keys(analyticsData.pests?.by_type ?? {}).length" class="space-y-2 mb-4">
                    <div v-for="(count, type) in analyticsData.pests.by_type" :key="type" class="flex items-center gap-3">
                      <span class="text-xs font-medium text-gray-600 capitalize w-16 truncate">{{ type }}</span>
                      <div class="flex-1 bg-gray-100 rounded-full h-2 overflow-hidden">
                        <div class="h-2 rounded-full bg-rose-500" :style="{ width: `${(count / Math.max(...Object.values(analyticsData.pests.by_type))) * 100}%` }"></div>
                      </div>
                      <span class="text-xs font-bold text-gray-900 w-6 text-right">{{ count }}</span>
                    </div>
                  </div>
                  <div class="pt-3 border-t border-gray-100 text-sm text-gray-600">
                    <p>Total Treatment Cost: <span class="font-bold text-gray-900">{{ formatCurrency(analyticsData.pests?.total_treatment_cost ?? 0) }}</span></p>
                  </div>
                </div>
              </div>

              <!-- Weather Correlation Chart -->
              <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6 hover:shadow-md transition-shadow">
                <div class="flex justify-between items-center mb-6">
                  <h3 class="text-lg font-bold text-gray-800">Monthly Yield & Rainfall Correlation</h3>
                  <span class="text-xs font-medium px-2 py-1 bg-gray-100 text-gray-500 rounded">Climate Impact</span>
                </div>
                <div class="h-96">
                  <LineChart v-if="weatherCorrelationData.labels.length > 0" :data="weatherCorrelationData" :options="weatherChartOptions" />
                  <NoData v-else />
                </div>
              </div>

              <!-- Disease & Pest Forecast -->
              <div v-if="analyticsData.pests?.forecasts?.length" class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                <div class="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/50">
                    <h3 class="text-lg font-bold text-gray-900">7-Day Pest & Disease Risk Forecast</h3>
                    <span class="flex items-center gap-2 text-sm text-gray-600">
                      <span class="w-2 h-2 rounded-full bg-rose-500"></span> High Risk
                      <span class="w-2 h-2 rounded-full bg-amber-500 ml-2"></span> Moderate
                    </span>
                </div>
                <div class="p-6 grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <div v-for="(field, index) in analyticsData.pests.forecasts" :key="index" class="space-y-4">
                      <div class="flex items-center justify-between border-b border-gray-100 pb-2">
                          <h4 class="text-base font-bold text-gray-900 flex items-center gap-2">
                            <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                            {{ field.field_name }}
                          </h4>
                          <div v-if="field.crop_info" class="flex items-center gap-2 text-xs font-medium">
                            <span class="text-emerald-700 bg-emerald-50 px-2 py-1 rounded-md border border-emerald-100">{{ field.crop_info.variety }}</span>
                            <span class="text-gray-500">{{ field.crop_info.growth_stage }} (Day {{ field.crop_info.days_planted }})</span>
                          </div>
                      </div>
                      <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                          <div v-for="(pred, pIndex) in field.predictions.slice(0, 3)" :key="pIndex"
                              class="flex flex-col p-4 rounded-xl border border-gray-200 bg-white hover:border-emerald-300 transition-colors shadow-sm relative overflow-hidden">
                              <div :class="[
                                'absolute top-0 left-0 w-full h-1',
                                pred.risks[0].risk_level === 'High' ? 'bg-rose-500' :
                                pred.risks[0].risk_level === 'Moderate' ? 'bg-amber-500' :
                                'bg-emerald-400'
                              ]"></div>
                              <div class="flex justify-between items-center mb-2">
                                  <span class="text-sm font-bold text-gray-900">{{ pred.day_name }}</span>
                                  <span class="text-xs text-gray-500">{{ pred.date }}</span>
                              </div>
                              <p class="text-sm font-bold text-gray-800 mb-1">{{ pred.risks[0].pest_name }}</p>
                              <p class="text-xs text-gray-600 flex-grow">{{ pred.risks[0].description }}</p>
                              <p v-if="pred.risks[0].stage_note" class="text-xs font-medium text-emerald-700 mt-3 pt-2 border-t border-gray-100">
                                Info: {{ pred.risks[0].stage_note }}
                              </p>
                          </div>
                      </div>
                    </div>
                </div>
              </div>
            </div>

          </div>
        </transition>
      </div>

      <div v-else class="text-center py-32 bg-white rounded-xl border border-gray-200 border-dashed">
        <div class="w-16 h-16 bg-emerald-50 rounded-full flex items-center justify-center mx-auto mb-4 text-emerald-600">
           <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path></svg>
        </div>
        <h3 class="text-lg font-medium text-gray-900 mb-1">No Analytics Available</h3>
        <p class="text-gray-500 text-sm mb-6">We couldn't load the data for the selected period.</p>
        <button
          @click="fetchAnalytics"
          class="px-5 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 font-medium text-sm transition-colors shadow-sm"
        >
          Try Again
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';
import api from '@/services/api';
import { formatCurrency } from '@/utils/format';

// Pinia Stores for Charts
import { useFarmStore } from '@/stores/farm';
import { useWeatherStore } from '@/stores/weather';
import { useMarketplaceStore } from '@/stores/marketplace';

// Chart Components
import LineChart from '@/Components/Charts/LineChart.vue';
import BarChart from '@/Components/Charts/BarChart.vue';
import PieChart from '@/Components/Charts/PieChart.vue';
import NoData from '@/Components/NoData.vue';

const router = useRouter();

const farmStore = useFarmStore();
const weatherStore = useWeatherStore();
const marketplaceStore = useMarketplaceStore();

// State
const isLoading = ref(true);
const analyticsData = ref(null);
const selectedPeriod = ref('90');
const startDate = ref(new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]); // 90 days ago
const endDate = ref(new Date().toISOString().split('T')[0]); // Today

// Ensure array helper
const ensureArray = (value) => (Array.isArray(value) ? value : []);

// Navigation Tabs
const activeTab = ref('overview');
const tabs = [
  { id: 'overview', name: 'Overview', icon: 'M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6' },
  { id: 'production', name: 'Crop & Production', icon: 'M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z' },
  { id: 'financials', name: 'Financials', icon: 'M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z' },
  { id: 'operations', name: 'Operations & Tasks', icon: 'M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4' },
  { id: 'weather', name: 'Weather Forecasts', icon: 'M3 15a4 4 0 004 4h9a5 5 0 10-.1-9.999 5.002 5.002 0 10-9.78 2.096A4.001 4.001 0 003 15z' },
];

const chartColors = [
  'rgba(16, 185, 129, 0.7)', // emerald-500
  'rgba(59, 130, 246, 0.7)', // blue-500
  'rgba(139, 92, 246, 0.7)', // violet-500
  'rgba(245, 158, 11, 0.7)', // amber-500
  'rgba(244, 63, 94, 0.7)',  // rose-500
  'rgba(14, 165, 233, 0.7)', // sky-500
  'rgba(234, 179, 8, 0.7)'   // yellow-500
];

const getColor = (index) => chartColors[index % chartColors.length];

const getSuggestionIcon = (name) => {
  const icons = {
    'shopping-cart': 'M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z',
    'clock': 'M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z',
    'scissors': 'M14.121 14.121L19 19m-7-7l7-7m-7 7l-2.879 2.879M12 12L9.121 9.121m0 5.758a3 3 0 10-4.243 4.243 3 3 0 004.243-4.243zm0-5.758a3 3 0 10-4.243-4.243 3 3 0 004.243 4.243z',
    'cloud-rain': 'M12 14v2m-4-2v2m8-2v2m-9 3.5a4 4 0 110-8 5 5 0 019.9-.9A4 4 0 0118 19.5H7.5z',
    'thermometer': 'M14 14.76V5a2 2 0 10-4 0v9.76a4 4 0 104 0z',
    'droplet': 'M12 2.25s6 6.386 6 11.25a6 6 0 11-12 0c0-4.864 6-11.25 6-11.25z',
    'exclamation-triangle': 'M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z',
    'bug-ant': 'M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z',
    'sparkles': 'M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z',
    'banknotes': 'M2.25 18.75a60.07 60.07 0 0115.797 2.101c.727.198 1.453-.342 1.453-1.096V5.245c0-.754-.726-1.294-1.453-1.096a60.07 60.07 0 01-15.797 2.101c-.727-.198-1.453.342-1.453 1.096v10.308c0 .754.726 1.294 1.453 1.096z',
    'x-circle': 'M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z',
    'archive-box': 'M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H2.25c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z',
    'clipboard-document-list': 'M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4',
    'chart-bar': 'M3 13h2v-2H3v2zm0 4h2v-2H3v2zm0-8h2V7H3v2zm4 4h14v-2H7v2zm0 4h14v-2H7v2zM7 7v2h14V7H7z',
    'calendar': 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z',
    'building-storefront': 'M13.5 21v-7.5a.75.75 0 01.75-.75h3a.75.75 0 01.75.75V21m-4.5 0H2.36m11.14 0H18m0 0h3.64m-1.39 0V9.349m-16.5 11.65V9.35m0 0a3.001 3.001 0 003.75-.615A2.993 2.993 0 009.75 9.75c.896 0 1.7-.393 2.25-1.016a2.993 2.993 0 002.25 1.016c.896 0 1.7-.393 2.25-1.016a3.001 3.001 0 003.75.614m-16.5 0a3.004 3.004 0 01-.621-4.72L4.318 3.44A1.5 1.5 0 015.378 3h13.243a1.5 1.5 0 011.06.44l1.19 1.189a3 3 0 01-.621 4.72m-13.5 8.65h3.75a.75.75 0 00.75-.75V13.5a.75.75 0 00-.75-.75H6.75a.75.75 0 00-.75.75v3.75c0 .415.336.75.75.75z',
  };
  return icons[name] || icons['exclamation-triangle'];
};

// Computed Store State
const harvests = computed(() => ensureArray(farmStore.harvests));
const sales = computed(() => ensureArray(farmStore.sales));
const expensesList = computed(() => ensureArray(farmStore.expenses));
const farmerOrders = computed(() => ensureArray(marketplaceStore.orders));
const weatherHistoryRecords = computed(() => ensureArray(weatherStore.weatherHistory));

const harvestUnit = computed(() => {
  const unitCounts = harvests.value.reduce((acc, harvest) => {
    const unit = harvest?.unit || 'bushels';
    acc[unit] = (acc[unit] || 0) + 1;
    return acc;
  }, {});

  const entries = Object.entries(unitCounts);
  if (!entries.length) return 'bushels';

  return entries.reduce((best, current) => (current[1] > best[1] ? current : best))[0];
});

const harvestAmount = (harvest) => {
  return Number(harvest?.quantity ?? harvest?.yield ?? 0) || 0;
};

const netProfit = computed(() => {
  const revenue = analyticsData.value?.sales?.total_revenue ?? 0;
  const expenses = analyticsData.value?.expenses?.total_expenses ?? 0;
  return revenue - expenses;
});

const completedPercent = computed(() => {
  const total = analyticsData.value?.tasks?.total_tasks ?? 0;
  const completed = analyticsData.value?.tasks?.completed_tasks ?? 0;
  return total > 0 ? (completed / total) * 100 : 0;
});

const pendingPercent = computed(() => {
  const total = analyticsData.value?.tasks?.total_tasks ?? 0;
  const pending = analyticsData.value?.tasks?.pending_tasks ?? 0;
  return total > 0 ? (pending / total) * 100 : 0;
});

const overduePercent = computed(() => {
  const total = analyticsData.value?.tasks?.total_tasks ?? 0;
  const overdue = analyticsData.value?.tasks?.overdue_tasks ?? 0;
  return total > 0 ? (overdue / total) * 100 : 0;
});

// Chart Helpers
const formatDateForApi = (date) => {
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) return '';
  return date.toISOString().split('T')[0];
};

const formatLabelDate = (date) => {
  const parsed = date ? new Date(date) : null;
  if (!parsed || Number.isNaN(parsed.getTime())) return '';
  return parsed.toLocaleDateString(undefined, { month: 'short', day: 'numeric' });
};

const monthKey = (date) => {
  const parsed = date ? new Date(date) : null;
  if (!parsed || Number.isNaN(parsed.getTime())) return null;
  return `${parsed.getFullYear()}-${String(parsed.getMonth() + 1).padStart(2, '0')}`;
};

const monthLabelFromKey = (key) => {
  if (!key) return '';
  const [year, month] = key.split('-').map(Number);
  if (!year || !month) return '';
  const date = new Date(year, month - 1, 1);
  return date.toLocaleDateString(undefined, { month: 'short', year: 'numeric' });
};

const selectedPeriodLabel = computed(() => {
  if (selectedPeriod.value === 'all') return 'All Time';
  return `${formatLabelDate(startDate.value)} - ${formatLabelDate(endDate.value)}`;
});

const aggregateByMonth = (records, dateKey, valueKey) => {
  const result = new Map();
  ensureArray(records).forEach((record) => {
    const dateValue = record?.[dateKey];
    const value = Number(record?.[valueKey]);
    if (!dateValue || Number.isNaN(value)) return;
    const key = monthKey(dateValue);
    if (!key) return;
    result.set(key, (result.get(key) || 0) + value);
  });
  return result;
};

// --- CHART COMPUTED PROPERTIES ---

const yieldChartData = computed(() => {
  const ordered = harvests.value
    .filter(harvest => harvest?.harvest_date && !Number.isNaN(new Date(harvest.harvest_date).getTime()))
    .sort((a, b) => new Date(a.harvest_date) - new Date(b.harvest_date))
    .slice(-12);

  if (!ordered.length) return { labels: [], datasets: [] };

  return {
    labels: ordered.map(h => formatLabelDate(h.harvest_date)),
    datasets: [{
      label: `Yield (${harvestUnit.value})`,
      data: ordered.map(h => harvestAmount(h)),
      borderColor: 'rgb(16, 185, 129)', // emerald-500
      backgroundColor: 'rgba(16, 185, 129, 0.1)',
      tension: 0.1,
      fill: true
    }]
  };
});

const varietyChartData = computed(() => {
  const varietyTotals = harvests.value.reduce((acc, harvest) => {
    const variety = harvest?.planting?.crop_type || 'Unknown Variety';
    acc[variety] = (acc[variety] || 0) + harvestAmount(harvest);
    return acc;
  }, {});

  const entries = Object.entries(varietyTotals).sort((a, b) => b[1] - a[1]);
  if (!entries.length) return { labels: [], datasets: [] };

  const labels = entries.map(([variety]) => variety);
  const data = entries.map(([, total]) => total);

  return {
    labels,
    datasets: [{
      label: `Yield (${harvestUnit.value})`,
      data,
      backgroundColor: labels.map((_, index) => getColor(index)),
      borderRadius: 4
    }]
  };
});

const salesByMonth = computed(() => aggregateByMonth(sales.value, 'sale_date', 'total_amount'));
const ordersByMonth = computed(() => aggregateByMonth(farmerOrders.value.filter(o => o.payment_status === 'paid'), 'order_date', 'total_amount'));
const revenueByMonth = computed(() => {
  const combined = new Map();
  salesByMonth.value.forEach((v, k) => combined.set(k, (combined.get(k) || 0) + v));
  ordersByMonth.value.forEach((v, k) => combined.set(k, (combined.get(k) || 0) + v));
  return combined;
});
const expensesByMonth = computed(() => aggregateByMonth(expensesList.value, 'date', 'amount'));

const monthLabels = computed(() => {
  const keys = new Set([...revenueByMonth.value.keys(), ...expensesByMonth.value.keys()]);
  return Array.from(keys).sort();
});

const financialChartData = computed(() => {
  if (!monthLabels.value.length) {
    const revenue = Number(analyticsData.value?.sales?.total_revenue ?? 0);
    const expenses = Number(analyticsData.value?.expenses?.total_expenses ?? 0);

    if (revenue <= 0 && expenses <= 0) return { labels: [], datasets: [] };

    return {
      labels: [selectedPeriodLabel.value],
      datasets: [
        {
          label: 'Revenue',
          data: [revenue],
          borderColor: 'rgb(16, 185, 129)',
          backgroundColor: 'rgba(16, 185, 129, 0.15)',
          tension: 0.3,
          fill: true
        },
        {
          label: 'Expenses',
          data: [expenses],
          borderColor: 'rgb(244, 63, 94)',
          backgroundColor: 'rgba(244, 63, 94, 0.15)',
          tension: 0.3,
          fill: true
        }
      ]
    };
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
        borderColor: 'rgb(16, 185, 129)', // emerald
        backgroundColor: 'rgba(16, 185, 129, 0.15)',
        tension: 0.3,
        fill: true
      },
      {
        label: 'Expenses',
        data: expensesData,
        borderColor: 'rgb(244, 63, 94)', // rose
        backgroundColor: 'rgba(244, 63, 94, 0.15)',
        tension: 0.3,
        fill: true
      }
    ]
  };
});

const expenseChartData = computed(() => {
  if (!expensesList.value.length) {
    const categoryBreakdown = analyticsData.value?.expenses?.by_category ?? {};
    const entries = Object.entries(categoryBreakdown)
      .map(([category, data]) => [category, Number(data?.total ?? 0)])
      .filter(([, amount]) => amount > 0)
      .sort((a, b) => b[1] - a[1]);

    if (!entries.length) {
      const totalExpenses = Number(analyticsData.value?.expenses?.total_expenses ?? 0);
      if (totalExpenses <= 0) return { labels: [], datasets: [] };

      return {
        labels: ['Expenses'],
        datasets: [{
          data: [totalExpenses],
          backgroundColor: [getColor(0)]
        }]
      };
    }

    return {
      labels: entries.map(([category]) => formatDisplayKey(category)),
      datasets: [{
        data: entries.map(([, amount]) => Number(amount.toFixed(2))),
        backgroundColor: entries.map((_, index) => getColor(index))
      }]
    };
  }

  const categoryTotals = expensesList.value.reduce((acc, expense) => {
    const category = expense?.category || 'Uncategorized';
    acc[category] = (acc[category] || 0) + (Number(expense?.amount) || 0);
    return acc;
  }, {});

  const entries = Object.entries(categoryTotals).sort((a, b) => b[1] - a[1]);
  return {
    labels: entries.map(([category]) => category),
    datasets: [{
      data: entries.map(([, amount]) => Number(amount.toFixed(2))),
      backgroundColor: entries.map((_, index) => getColor(index))
    }]
  };
});

const weatherCorrelationData = computed(() => {
  const rainfallByMonth = new Map();
  weatherHistoryRecords.value.forEach(record => {
    const key = monthKey(record?.recorded_at);
    if (!key) return;
    rainfallByMonth.set(key, (rainfallByMonth.get(key) || 0) + (Number(record?.rainfall) || 0));
  });

  const yieldByMonth = new Map();
  harvests.value.forEach(harvest => {
    const key = monthKey(harvest?.harvest_date);
    if (!key) return;
    yieldByMonth.set(key, (yieldByMonth.get(key) || 0) + harvestAmount(harvest));
  });

  const monthKeys = Array.from(new Set([...rainfallByMonth.keys(), ...yieldByMonth.keys()])).sort();
  if (!monthKeys.length) return { labels: [], datasets: [] };

  return {
    labels: monthKeys.map(monthLabelFromKey),
    datasets: [
      {
        type: 'bar',
        label: 'Rainfall (mm)',
        data: monthKeys.map(key => Number((rainfallByMonth.get(key) || 0).toFixed(2))),
        backgroundColor: 'rgba(59, 130, 246, 0.4)', // blue-500
        yAxisID: 'y1',
        borderRadius: 4
      },
      {
        type: 'line',
        label: `Harvest Yield (${harvestUnit.value})`,
        data: monthKeys.map(key => Number((yieldByMonth.get(key) || 0).toFixed(2))),
        borderColor: 'rgb(16, 185, 129)', // emerald-500
        backgroundColor: 'rgba(16, 185, 129, 0.1)',
        borderWidth: 2,
        tension: 0.3,
        yAxisID: 'y'
      }
    ]
  };
});

// Chart Options Configs
const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { position: 'bottom', labels: { usePointStyle: true, boxWidth: 6 } }
  },
  scales: {
    y: { beginAtZero: true, grid: { color: 'rgba(0, 0, 0, 0.05)' } },
    x: { grid: { display: false } }
  }
};

const pieChartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { position: 'right', labels: { usePointStyle: true, boxWidth: 8 } }
  }
};

const weatherChartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { position: 'bottom', labels: { usePointStyle: true, boxWidth: 6 } }
  },
  scales: {
    y: { 
      type: 'linear', 
      display: true, 
      position: 'left', 
      title: { display: true, text: `Yield (${harvestUnit.value})` },
      grid: { color: 'rgba(0,0,0,0.05)' } 
    },
    y1: { 
      type: 'linear', 
      display: true, 
      position: 'right', 
      title: { display: true, text: 'Rainfall (mm)' },
      grid: { drawOnChartArea: false } 
    },
    x: { grid: { display: false } }
  }
};

// Methods
const formatNumber = (num) => {
  return new Intl.NumberFormat('en-PH').format(num);
};

const navigateTo = (path) => {
  router.push(path);
};

// Update Date range from Quick Select
watch(selectedPeriod, (newVal) => {
  if (newVal === 'all') {
    startDate.value = '2020-01-01'; // Default far past
  } else {
    startDate.value = new Date(Date.now() - parseInt(newVal) * 24 * 60 * 60 * 1000).toISOString().split('T')[0];
  }
  endDate.value = new Date().toISOString().split('T')[0];
  fetchAnalytics();
});

const fetchAnalytics = async () => {
  isLoading.value = true;
  try {
    // 1. Fetch Backend Aggregated Analytics Data
    const response = await api.get('/analytics/data-analysis', {
      params: {
        start_date: startDate.value,
        end_date: endDate.value,
      },
    });
    analyticsData.value = response.data;

    // 2. Fetch Detailed Pinia Store Data for Charts
    const filters = { date_from: startDate.value, date_to: endDate.value };
    const orderFilters = { from_date: startDate.value, to_date: endDate.value };

    await Promise.all([
      farmStore.fetchFarmProfile(),
      farmStore.fetchHarvests(filters),
      farmStore.fetchSales(filters),
      farmStore.fetchExpenses(filters),
      marketplaceStore.fetchFarmerOrders(orderFilters)
    ]);

    const farmId = farmStore.farmProfile?.farm?.id ?? farmStore.farmProfile?.id;
    if (farmId) {
      // Calculate days diff for weather history
      const diffTime = Math.abs(new Date(endDate.value) - new Date(startDate.value));
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      await weatherStore.fetchWeatherHistory(farmId, Math.min(diffDays, 365));
    }

  } catch (error) {
    console.error('Failed to fetch analytics:', error);
  } finally {
    isLoading.value = false;
  }
};

// Lifecycle
onMounted(() => {
  fetchAnalytics();
});
</script>

<style scoped>
h3, .text-2xl, .text-lg, .text-3xl, .text-4xl {
  font-feature-settings: "tnum";
  font-variant-numeric: tabular-nums;
}

.line-clamp-1 {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

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
