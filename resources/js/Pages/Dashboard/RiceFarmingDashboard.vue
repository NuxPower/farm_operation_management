<template>
  <div class="min-h-screen bg-[linear-gradient(180deg,#f8fafc_0%,#eef7f2_34%,#f8fafc_78%)] text-gray-900">
    <div class="w-full mx-auto px-6 py-8 space-y-7">
      <div class="overflow-hidden rounded-2xl border border-white/80 bg-white shadow-[0_24px_70px_rgba(15,23,42,0.10)]">
        <div class="grid grid-cols-1 lg:grid-cols-[1.35fr_0.65fr]">
          <div class="relative bg-[linear-gradient(135deg,#0f172a_0%,#14532d_48%,#0369a1_100%)] p-8 text-white">
            <div class="absolute inset-x-0 bottom-0 h-px bg-white/20"></div>
            <p class="text-xs font-bold uppercase tracking-[0.24em] text-emerald-200">ANIBUKID operations hub</p>
            <h1 class="mt-3 max-w-3xl text-4xl font-bold leading-tight">
              Good day, {{ authStore.user?.name || 'Farmer' }}
            </h1>
            <p class="mt-4 max-w-3xl text-sm leading-6 text-white/75">
              Plan field work, check local weather, track resources, review data, and move harvested rice toward buyers from one dashboard.
            </p>
            <div class="mt-6 flex flex-wrap gap-2">
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Planning</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Labor</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Weather</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Analytics</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Marketplace</span>
            </div>
          </div>

          <div class="flex flex-col justify-between gap-6 bg-white p-8">
            <div>
              <p class="text-sm font-semibold text-gray-500">Today’s priority</p>
              <p class="mt-2 text-2xl font-bold text-gray-900">{{ weatherSeverityLabel }} weather posture</p>
              <p class="mt-2 text-sm leading-6 text-gray-500">
                {{ totalWarningCount }} total warning{{ totalWarningCount === 1 ? '' : 's' }} across weather, resources, and crop operations.
              </p>
            </div>

            <div class="grid grid-cols-3 gap-3">
              <div class="rounded-xl bg-emerald-50 p-3">
                <p class="text-xs font-medium text-emerald-700">Area</p>
                <p class="mt-1 text-xl font-bold text-emerald-950">{{ stats.total_area || 0 }} ha</p>
              </div>
              <div class="rounded-xl bg-sky-50 p-3">
                <p class="text-xs font-medium text-sky-700">Weather</p>
                <p class="mt-1 text-xl font-bold text-sky-950">{{ totalWeatherAlerts }}</p>
              </div>
              <div class="rounded-xl bg-amber-50 p-3">
                <p class="text-xs font-medium text-amber-700">Tasks</p>
                <p class="mt-1 text-xl font-bold text-amber-950">{{ stats.pending_tasks || 0 }}</p>
              </div>
            </div>

            <div class="flex flex-wrap gap-2">
              <router-link
                to="/tasks/create"
                class="inline-flex items-center gap-1.5 rounded-md bg-emerald-600 px-3 py-1.5 text-xs font-semibold text-white shadow-sm hover:bg-emerald-700"
              >
                <PlusIcon class="h-3.5 w-3.5" />
                New Task
              </router-link>
              <button
                @click="loadDashboardData"
                :disabled="loading"
                class="inline-flex items-center gap-1.5 rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 shadow-sm hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-60"
              >
                <ArrowPathIcon class="h-3.5 w-3.5" :class="{ 'animate-spin': loading }" />
                Refresh
              </button>
            </div>
          </div>
        </div>
      </div>

      <div v-if="error" class="rounded-xl border border-rose-200 bg-rose-50 p-4">
        <div class="flex items-start gap-3">
          <ExclamationTriangleIcon class="mt-0.5 h-5 w-5 text-rose-600" />
          <div>
            <p class="text-sm font-semibold text-rose-900">Dashboard data could not be loaded</p>
            <p class="mt-1 text-sm text-rose-700">{{ error }}</p>
          </div>
        </div>
      </div>

      <div v-if="loading && !hasLoaded" class="flex items-center justify-center rounded-xl border border-gray-200 bg-white py-24 shadow-sm">
        <div class="text-center">
          <div class="mx-auto h-12 w-12 animate-spin rounded-full border-[3px] border-emerald-100 border-t-emerald-600"></div>
          <p class="mt-4 text-sm font-medium text-gray-500">Loading farm dashboard...</p>
        </div>
      </div>

      <div v-else class="space-y-6">
        <section class="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-6">
          <MetricTile
            label="Farm Area"
            :value="`${stats.total_area || 0} ha`"
            :detail="`${stats.utilization_rate || 0}% utilized`"
            tone="emerald"
            :icon="MapIcon"
          />
          <MetricTile
            label="Seedbed"
            :value="stats.active_seed_batches || 0"
            :detail="`${stats.ready_for_transplant || 0} ready to transplant`"
            tone="blue"
            :icon="SparklesIcon"
          />
          <MetricTile
            label="Tasks"
            :value="stats.pending_tasks || 0"
            :detail="`${stats.overdue_tasks || 0} overdue`"
            tone="amber"
            :icon="ClipboardDocumentListIcon"
          />
          <MetricTile
            label="Inventory Alerts"
            :value="resourceAlertCount"
            detail="Stock and expiry"
            tone="violet"
            :icon="CubeIcon"
          />
          <MetricTile
            label="Orders"
            :value="stats.pending_orders || 0"
            detail="Pending marketplace"
            tone="indigo"
            :icon="ShoppingBagIcon"
          />
          <MetricTile
            label="Revenue"
            :value="formatCurrency(stats.marketplace_revenue || 0)"
            detail="Analytics period"
            tone="green"
            :icon="CurrencyDollarIcon"
          />
        </section>

        <section class="grid grid-cols-1 gap-6 xl:grid-cols-3">
          <div class="xl:col-span-2 overflow-hidden rounded-2xl border border-sky-900/10 bg-white shadow-[0_18px_50px_rgba(2,132,199,0.12)]">
            <div class="border-b border-white/10 bg-[linear-gradient(135deg,#0c4a6e_0%,#0369a1_48%,#047857_100%)] p-6 text-white">
              <div class="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                <div>
                  <div class="flex items-center gap-2">
                    <div class="rounded-xl bg-white/15 p-2">
                      <CloudIcon class="h-6 w-6 text-white" />
                    </div>
                    <h2 class="text-xl font-bold text-white">Localized Weather Decisions</h2>
                  </div>
                  <p class="mt-3 max-w-2xl text-sm leading-6 text-white/75">
                    Monitor warnings and field conditions before scheduling irrigation, spraying, harvesting, or labor deployment.
                  </p>
                </div>
                <router-link
                  to="/weather"
                  class="inline-flex items-center justify-center rounded-lg bg-white px-4 py-2 text-sm font-semibold text-sky-800 shadow-sm hover:bg-sky-50"
                >
                  Weather Center
                </router-link>
              </div>
            </div>

            <div class="grid grid-cols-1 gap-0 lg:grid-cols-[1.1fr_0.9fr]">
              <div class="border-b border-gray-100 bg-[linear-gradient(180deg,#ffffff_0%,#f0f9ff_100%)] p-6 lg:border-b-0 lg:border-r">
                <div class="flex items-center justify-between">
                  <div>
                    <p class="text-sm font-semibold text-gray-500">Active Warnings</p>
                    <p class="mt-1 text-6xl font-bold tracking-tight text-gray-950">{{ totalWeatherAlerts }}</p>
                  </div>
                  <div
                    class="rounded-full px-4 py-2 text-sm font-bold shadow-sm"
                    :class="weatherSeverityClass"
                  >
                    {{ weatherSeverityLabel }}
                  </div>
                </div>

                <div class="mt-6 space-y-3">
                  <div
                    v-if="weatherWarnings.length === 0"
                    class="rounded-xl border border-emerald-100 bg-white p-5 shadow-sm"
                  >
                    <p class="text-sm font-semibold text-emerald-900">No active weather warnings</p>
                    <p class="mt-1 text-sm text-emerald-700">Current field weather does not show urgent alerts.</p>
                  </div>

                  <div
                    v-for="warning in weatherWarnings.slice(0, 4)"
                    :key="warning.id"
                    class="rounded-xl border p-5 shadow-sm"
                    :class="warning.critical ? 'border-rose-200 bg-white' : 'border-amber-200 bg-white'"
                  >
                    <div class="flex items-start justify-between gap-4">
                      <div>
                        <p class="text-sm font-semibold" :class="warning.critical ? 'text-rose-900' : 'text-amber-900'">
                          {{ warning.title }}
                        </p>
                        <p class="mt-1 text-sm" :class="warning.critical ? 'text-rose-700' : 'text-amber-700'">
                          {{ warning.message }}
                        </p>
                      </div>
                      <ExclamationTriangleIcon class="h-5 w-5 shrink-0" :class="warning.critical ? 'text-rose-600' : 'text-amber-600'" />
                    </div>
                  </div>
                </div>
              </div>

              <div class="bg-white p-6">
                <div class="flex items-center justify-between">
                  <h3 class="text-sm font-semibold uppercase tracking-wide text-gray-500">Analytics Weather</h3>
                  <span class="text-xs font-medium text-gray-400">7-day farm average</span>
                </div>

                <div class="mt-4 grid grid-cols-1 gap-3">
                  <div class="rounded-xl border border-sky-100 bg-sky-50 p-4">
                    <p class="text-xs font-semibold uppercase tracking-wide text-sky-700">Temperature</p>
                    <p class="mt-2 text-3xl font-bold text-sky-950">{{ analyticsData?.weather?.avg_temperature ?? '--' }} C</p>
                  </div>
                  <div class="grid grid-cols-2 gap-3">
                    <div class="rounded-xl border border-emerald-100 bg-emerald-50 p-4">
                      <p class="text-xs font-semibold uppercase tracking-wide text-emerald-700">Humidity</p>
                      <p class="mt-2 text-xl font-bold text-emerald-950">{{ analyticsData?.weather?.avg_humidity ?? '--' }}%</p>
                    </div>
                    <div class="rounded-xl border border-blue-100 bg-blue-50 p-4">
                      <p class="text-xs font-semibold uppercase tracking-wide text-blue-700">Rainfall</p>
                      <p class="mt-2 text-xl font-bold text-blue-950">{{ analyticsData?.weather?.total_rainfall ?? '--' }} mm</p>
                    </div>
                  </div>
                  <div v-if="analyticsData?.weather?.weather_alert" class="rounded-xl border border-amber-200 bg-amber-50 p-4">
                    <p class="text-sm font-semibold text-amber-900">Weather data issue</p>
                    <p class="mt-1 text-sm text-amber-700">{{ analyticsData.weather.weather_alert }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="rounded-2xl border border-gray-200/80 bg-white p-6 shadow-[0_18px_40px_rgba(15,23,42,0.08)]">
            <div class="flex items-center justify-between">
              <h2 class="text-lg font-bold text-gray-900">Decision Queue</h2>
              <span class="rounded-full bg-gray-100 px-2.5 py-1 text-xs font-semibold text-gray-600">{{ decisionQueue.length }}</span>
            </div>
            <div class="mt-5 space-y-3">
              <router-link
                v-for="item in decisionQueue"
                :key="item.label"
                :to="item.to"
                class="block rounded-xl border border-gray-100 bg-gray-50/60 p-4 transition hover:border-emerald-200 hover:bg-emerald-50/60"
              >
                <div class="flex items-start gap-3">
                  <component :is="item.icon" class="mt-0.5 h-5 w-5" :class="item.iconClass" />
                  <div>
                    <p class="text-sm font-semibold text-gray-900">{{ item.label }}</p>
                    <p class="mt-1 text-sm text-gray-500">{{ item.detail }}</p>
                  </div>
                </div>
              </router-link>
            </div>
          </div>
        </section>

        <section class="grid grid-cols-1 gap-6 xl:grid-cols-3">
          <div class="rounded-2xl border border-gray-200/80 bg-white shadow-[0_18px_40px_rgba(15,23,42,0.08)] xl:col-span-2">
            <div class="flex items-center justify-between border-b border-gray-100 p-6">
              <div>
                <h2 class="text-lg font-bold text-gray-900">Operations and Labor Analytics</h2>
                <p class="mt-1 text-sm text-gray-500">Task completion, labor readiness, and crop risk from the analytics API.</p>
              </div>
              <router-link to="/tasks" class="text-sm font-semibold text-emerald-700 hover:text-emerald-800">View Tasks</router-link>
            </div>

            <div class="grid grid-cols-1 divide-y divide-gray-100 lg:grid-cols-2 lg:divide-x lg:divide-y-0">
              <div class="p-6">
                <h3 class="text-sm font-semibold uppercase tracking-wide text-gray-500">Task Distribution</h3>
                <div class="mt-4 space-y-3">
                  <ResourceRow label="Total tasks" :value="analyticsData?.tasks?.total_tasks || 0" tone="gray" />
                  <ResourceRow label="Completed" :value="analyticsData?.tasks?.completed_tasks || 0" tone="green" />
                  <ResourceRow label="Pending" :value="analyticsData?.tasks?.pending_tasks || 0" tone="amber" />
                  <ResourceRow label="Overdue" :value="analyticsData?.tasks?.overdue_tasks || 0" tone="rose" />
                </div>
              </div>

              <div class="p-6">
                <h3 class="text-sm font-semibold uppercase tracking-wide text-gray-500">Labor and Crop Risk</h3>
                <div class="mt-4 space-y-3">
                  <ResourceRow label="Active laborers" :value="analyticsData?.laborers?.active_laborers || 0" tone="green" />
                  <ResourceRow label="Labor completion" :value="`${analyticsData?.laborers?.completion_rate || 0}%`" tone="amber" />
                  <ResourceRow label="Active pest incidents" :value="analyticsData?.pests?.active_incidents || 0" tone="rose" />
                  <ResourceRow label="Failed plantings" :value="analyticsData?.failure_analysis?.total_failed || 0" tone="rose" />
                </div>
              </div>
            </div>
          </div>

          <div class="rounded-2xl border border-gray-200/80 bg-white p-6 shadow-[0_18px_40px_rgba(15,23,42,0.08)]">
            <h2 class="text-lg font-bold text-gray-900">Resource Management</h2>
            <p class="mt-1 text-sm text-gray-500">Inventory and cost signals.</p>
            <div class="mt-5 space-y-4">
              <ResourceRow label="Low stock items" :value="stats.low_stock_items || 0" tone="amber" />
              <ResourceRow label="Expiring soon" :value="stats.expiring_items_count || 0" tone="orange" />
              <ResourceRow label="Inventory value" :value="formatCurrency(analyticsData?.inventory?.total_value || 0)" tone="gray" />
              <ResourceRow label="Monthly expenses" :value="formatCurrency(stats.monthly_expenses || 0)" tone="gray" />
            </div>
            <router-link
              to="/inventory"
              class="mt-6 inline-flex w-full items-center justify-center rounded-lg border border-gray-200 px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50"
            >
              Manage Inventory
            </router-link>
          </div>
        </section>

        <section class="grid grid-cols-1 gap-6 xl:grid-cols-2">
          <DetailPanel title="Today’s Work" action-label="View Tasks" to="/tasks">
            <div class="space-y-3">
              <div
                v-for="task in analyticsData?.tasks?.upcoming?.slice(0, 5) || []"
                :key="task.id"
                class="rounded-xl border border-gray-100 bg-gray-50/70 p-4"
              >
                <div class="flex items-start justify-between gap-4">
                  <div class="min-w-0">
                    <p class="truncate text-sm font-semibold text-gray-900">{{ task.title }}</p>
                    <p class="mt-1 line-clamp-1 text-xs text-gray-500">{{ task.description || task.status }}</p>
                  </div>
                  <span class="shrink-0 rounded-full px-2 py-0.5 text-xs font-semibold" :class="getPriorityClass(task.priority)">
                    {{ task.due_date || 'No date' }}
                  </span>
                </div>
              </div>
              <EmptyState v-if="!(analyticsData?.tasks?.upcoming || []).length" label="No upcoming work found." />
            </div>
          </DetailPanel>

          <DetailPanel title="Inventory Watchlist" action-label="Manage Inventory" to="/inventory">
            <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
              <div>
                <p class="mb-3 text-xs font-bold uppercase tracking-wide text-amber-700">Low Stock</p>
                <div class="space-y-2">
                  <div
                    v-for="item in analyticsData?.inventory?.low_stock_items?.slice(0, 4) || []"
                    :key="`low-${item.id}`"
                    class="flex items-center justify-between rounded-lg bg-amber-50 px-3 py-2"
                  >
                    <span class="truncate text-sm font-medium text-gray-800">{{ item.name }}</span>
                    <span class="text-xs font-bold text-amber-800">{{ item.current_stock }} {{ item.unit }}</span>
                  </div>
                  <EmptyState v-if="!(analyticsData?.inventory?.low_stock_items || []).length" label="No low-stock items." compact />
                </div>
              </div>

              <div>
                <p class="mb-3 text-xs font-bold uppercase tracking-wide text-orange-700">Expiring</p>
                <div class="space-y-2">
                  <div
                    v-for="item in analyticsData?.inventory?.expiring_items?.slice(0, 4) || []"
                    :key="`exp-${item.id}`"
                    class="flex items-center justify-between rounded-lg bg-orange-50 px-3 py-2"
                  >
                    <span class="truncate text-sm font-medium text-gray-800">{{ item.name }}</span>
                    <span class="text-xs font-bold text-orange-800">{{ item.expiry_date }}</span>
                  </div>
                  <EmptyState v-if="!(analyticsData?.inventory?.expiring_items || []).length" label="No expiring items." compact />
                </div>
              </div>
            </div>
          </DetailPanel>
        </section>

        <section class="grid grid-cols-1 gap-6 xl:grid-cols-3">
          <DetailPanel title="Marketplace Pipeline" action-label="Manage Products" to="/marketplace/my-products">
            <div class="mb-4 grid grid-cols-2 gap-3">
              <MiniStat label="Active listings" :value="analyticsData?.marketplace?.active_listings || 0" />
              <MiniStat label="Products" :value="analyticsData?.marketplace?.total_products || 0" />
            </div>
            <div class="space-y-2">
              <div
                v-for="product in analyticsData?.marketplace?.recent_products?.slice(0, 4) || []"
                :key="product.id"
                class="flex items-center justify-between rounded-lg border border-gray-100 px-3 py-2"
              >
                <div class="min-w-0">
                  <p class="truncate text-sm font-semibold text-gray-900">{{ product.name }}</p>
                  <p class="text-xs text-gray-500">{{ product.variety }}</p>
                </div>
                <span class="text-xs font-bold text-gray-700">{{ formatCurrency(product.price_per_unit) }}/{{ product.unit }}</span>
              </div>
              <EmptyState v-if="!(analyticsData?.marketplace?.recent_products || []).length" label="No marketplace products yet." compact />
            </div>
          </DetailPanel>

          <DetailPanel title="Post-Harvest Snapshot" action-label="View Harvests" to="/harvests">
            <div class="grid grid-cols-2 gap-3">
              <MiniStat label="Completed" :value="analyticsData?.post_harvest?.total_processes || 0" />
              <MiniStat label="Recovery" :value="`${analyticsData?.post_harvest?.average_recovery_rate || 0}%`" />
              <MiniStat label="Self avg/unit" :value="formatCurrency(analyticsData?.post_harvest?.cost_optimization?.self_avg_cost || 0)" />
              <MiniStat label="Provider avg/unit" :value="formatCurrency(analyticsData?.post_harvest?.cost_optimization?.provider_avg_cost || 0)" />
            </div>
          </DetailPanel>

          <DetailPanel title="Financial Outlook" action-label="View Reports" to="/reports">
            <div class="space-y-3">
              <div class="grid grid-cols-2 gap-3">
                <MiniStat label="Revenue" :value="formatCurrency(analyticsData?.sales?.total_revenue || 0)" />
                <MiniStat label="Expenses" :value="formatCurrency(analyticsData?.expenses?.total_expenses || 0)" />
              </div>
              <div v-if="analyticsData?.financial_forecast?.months?.length" class="space-y-2">
                <div
                  v-for="(month, index) in analyticsData.financial_forecast.months.slice(0, 3)"
                  :key="month"
                  class="flex items-center justify-between rounded-lg bg-gray-50 px-3 py-2 text-sm"
                >
                  <span class="font-medium text-gray-700">{{ month }}</span>
                  <span class="font-bold text-emerald-700">
                    {{ formatCurrency((analyticsData.financial_forecast.projected_revenue[index] || 0) - (analyticsData.financial_forecast.projected_expenses[index] || 0)) }}
                  </span>
                </div>
              </div>
              <EmptyState v-else label="No forecast data available." compact />
            </div>
          </DetailPanel>
        </section>

        <section class="grid grid-cols-1 gap-6 lg:grid-cols-3">
          <ModuleCard
            title="Farm Data Analysis"
            description="Stored field, task, weather, resource, and production records for informed decisions."
            to="/analytics"
            action="Open Analytics"
            :icon="ChartBarIcon"
            tone="emerald"
          >
            <div class="grid grid-cols-2 gap-3">
              <MiniStat label="Area" :value="`${stats.total_area || 0} ha`" />
              <MiniStat label="Inventory value" :value="formatCurrency(analyticsData?.inventory?.total_value || 0)" />
            </div>
          </ModuleCard>

          <ModuleCard
            title="Direct Buyer Platform"
            description="Marketplace activity connects harvested products directly to buyers."
            to="/marketplace/my-products"
            action="Manage Products"
            :icon="ShoppingBagIcon"
            tone="indigo"
          >
            <div class="grid grid-cols-2 gap-3">
              <MiniStat label="Pending" :value="stats.pending_orders || 0" />
              <MiniStat label="Revenue" :value="formatCurrency(stats.marketplace_revenue || 0)" />
            </div>
          </ModuleCard>

          <ModuleCard
            title="Centralized System"
            description="Operations, weather, labor, resources, and sales signals appear in one workflow."
            to="/reports"
            action="View Reports"
            :icon="Squares2X2Icon"
            tone="slate"
          >
            <div class="grid grid-cols-2 gap-3">
              <MiniStat label="Suggestions" :value="analyticsData?.action_suggestions?.length || 0" />
              <MiniStat label="Warnings" :value="totalWarningCount" />
            </div>
          </ModuleCard>
        </section>

        <section class="rounded-2xl border border-gray-200/80 bg-white shadow-[0_18px_40px_rgba(15,23,42,0.08)]">
          <div class="flex items-center justify-between border-b border-gray-100 p-6">
            <h2 class="text-lg font-bold text-gray-900">Recent System Activity</h2>
            <span class="text-sm text-gray-500">Operations, buyers, and resources</span>
          </div>
          <div class="divide-y divide-gray-100">
            <div
              v-for="activity in recentActivity.slice(0, 6)"
              :key="activity.id"
              class="flex items-start gap-4 p-5"
            >
              <span class="mt-2 h-2.5 w-2.5 rounded-full" :class="getActivityTypeColor(activity.type)"></span>
              <div>
                <p class="text-sm font-medium text-gray-900">{{ activity.description }}</p>
                <p class="mt-1 text-xs text-gray-500">{{ formatDate(activity.created_at) }}</p>
              </div>
            </div>
            <div v-if="recentActivity.length === 0" class="p-8 text-center text-sm text-gray-500">
              No recent activity yet.
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, defineComponent, h, onMounted, ref, resolveComponent } from 'vue';
import { useAuthStore } from '@/stores/auth';
import { formatCurrency } from '@/utils/format';
import {
  analyticsAPI,
} from '@/services/api';
import {
  ArrowPathIcon,
  ChartBarIcon,
  ClipboardDocumentListIcon,
  CloudIcon,
  CubeIcon,
  CurrencyDollarIcon,
  ExclamationTriangleIcon,
  MapIcon,
  PlusIcon,
  ShoppingBagIcon,
  SparklesIcon,
  Squares2X2Icon,
} from '@heroicons/vue/24/outline';

const authStore = useAuthStore();

const stats = ref({});
const analyticsData = ref(null);
const recentActivity = ref([]);
const loading = ref(true);
const hasLoaded = ref(false);
const error = ref(null);

const MetricTile = defineComponent({
  props: {
    label: String,
    value: [String, Number],
    detail: String,
    tone: String,
    icon: Object,
  },
  setup(props) {
    const toneClass = computed(() => ({
      emerald: 'bg-emerald-50 text-emerald-700',
      blue: 'bg-blue-50 text-blue-700',
      amber: 'bg-amber-50 text-amber-700',
      violet: 'bg-violet-50 text-violet-700',
      indigo: 'bg-indigo-50 text-indigo-700',
      green: 'bg-green-50 text-green-700',
    }[props.tone] || 'bg-gray-50 text-gray-700'));

    return () => h('div', { class: 'group rounded-2xl border border-gray-200/80 bg-white p-5 shadow-[0_14px_36px_rgba(15,23,42,0.07)] transition hover:-translate-y-0.5 hover:shadow-[0_20px_46px_rgba(15,23,42,0.11)]' }, [
      h('div', { class: 'flex items-start justify-between gap-4' }, [
        h('div', [
          h('p', { class: 'text-sm font-medium text-gray-500' }, props.label),
          h('p', { class: 'mt-2 text-3xl font-bold text-gray-900' }, String(props.value ?? 0)),
          h('p', { class: 'mt-1 text-xs text-gray-500' }, props.detail),
        ]),
        h('div', { class: `rounded-xl p-3 transition group-hover:scale-105 ${toneClass.value}` }, [
          h(props.icon, { class: 'h-5 w-5' }),
        ]),
      ]),
    ]);
  },
});

const ResourceRow = defineComponent({
  props: {
    label: String,
    value: [String, Number],
    tone: String,
  },
  setup(props) {
    const toneClass = computed(() => ({
      amber: 'bg-amber-100 text-amber-800',
      orange: 'bg-orange-100 text-orange-800',
      rose: 'bg-rose-100 text-rose-800',
      green: 'bg-emerald-100 text-emerald-800',
      gray: 'bg-gray-100 text-gray-800',
    }[props.tone] || 'bg-gray-100 text-gray-800'));

    return () => h('div', { class: 'flex items-center justify-between rounded-xl border border-gray-100 bg-gray-50/70 p-3' }, [
      h('span', { class: 'text-sm text-gray-600' }, props.label),
      h('span', { class: `rounded-full px-2.5 py-1 text-xs font-bold ${toneClass.value}` }, String(props.value ?? 0)),
    ]);
  },
});

const MiniStat = defineComponent({
  props: {
    label: String,
    value: [String, Number],
  },
  setup(props) {
    return () => h('div', { class: 'rounded-xl bg-gray-50 p-3' }, [
      h('p', { class: 'text-xs font-medium text-gray-500' }, props.label),
      h('p', { class: 'mt-1 text-sm font-bold text-gray-900' }, String(props.value ?? 0)),
    ]);
  },
});

const ModuleCard = defineComponent({
  props: {
    title: String,
    description: String,
    to: String,
    action: String,
    icon: Object,
    tone: String,
  },
  setup(props, { slots }) {
    const RouterLink = resolveComponent('RouterLink');
    const toneClass = computed(() => ({
      emerald: 'bg-emerald-50 text-emerald-700',
      indigo: 'bg-indigo-50 text-indigo-700',
      slate: 'bg-slate-100 text-slate-700',
    }[props.tone] || 'bg-gray-50 text-gray-700'));

    return () => h('div', { class: 'rounded-2xl border border-gray-200/80 bg-white p-6 shadow-[0_18px_40px_rgba(15,23,42,0.08)] transition hover:-translate-y-0.5 hover:shadow-[0_22px_52px_rgba(15,23,42,0.12)]' }, [
      h('div', { class: 'flex items-start gap-4' }, [
        h('div', { class: `rounded-xl p-3 ${toneClass.value}` }, [
          h(props.icon, { class: 'h-6 w-6' }),
        ]),
        h('div', { class: 'min-w-0 flex-1' }, [
          h('h3', { class: 'text-lg font-bold text-gray-900' }, props.title),
          h('p', { class: 'mt-2 text-sm leading-6 text-gray-500' }, props.description),
        ]),
      ]),
      h('div', { class: 'mt-5' }, slots.default?.()),
      h(RouterLink, { to: props.to, class: 'mt-5 inline-flex text-sm font-semibold text-emerald-700 hover:text-emerald-800' }, () => props.action),
    ]);
  },
});

const DetailPanel = defineComponent({
  props: {
    title: String,
    actionLabel: String,
    to: String,
  },
  setup(props, { slots }) {
    const RouterLink = resolveComponent('RouterLink');

    return () => h('div', { class: 'rounded-2xl border border-gray-200/80 bg-white p-6 shadow-[0_18px_40px_rgba(15,23,42,0.08)]' }, [
      h('div', { class: 'mb-5 flex items-center justify-between gap-4' }, [
        h('h3', { class: 'text-lg font-bold text-gray-900' }, props.title),
        h(RouterLink, { to: props.to, class: 'shrink-0 text-sm font-semibold text-emerald-700 hover:text-emerald-800' }, () => props.actionLabel),
      ]),
      h('div', slots.default?.()),
    ]);
  },
});

const EmptyState = defineComponent({
  props: {
    label: String,
    compact: Boolean,
  },
  setup(props) {
    return () => h('div', {
      class: props.compact
        ? 'rounded-lg border border-dashed border-gray-200 px-3 py-2 text-center text-xs text-gray-500'
        : 'rounded-xl border border-dashed border-gray-200 p-6 text-center text-sm text-gray-500',
    }, props.label);
  },
});

const resourceAlertCount = computed(() =>
  (stats.value.low_stock_items || 0) +
  (stats.value.expiring_items_count || 0)
);

const totalWeatherAlerts = computed(() =>
  (analyticsData.value?.weather?.weather_alert ? 1 : 0) +
  (analyticsData.value?.action_suggestions || []).filter((suggestion) => isWeatherSuggestion(suggestion)).length
);

const totalCriticalWeatherAlerts = computed(() =>
  (analyticsData.value?.action_suggestions || []).filter((suggestion) => isWeatherSuggestion(suggestion) && suggestion.priority === 'high').length
);

const totalWarningCount = computed(() =>
  totalWeatherAlerts.value + resourceAlertCount.value + (stats.value.failed_plantings_count || 0)
);

const weatherSeverityLabel = computed(() => {
  if (totalCriticalWeatherAlerts.value > 0) return 'Critical';
  if (totalWeatherAlerts.value > 0) return 'Watch';
  return 'Stable';
});

const weatherSeverityClass = computed(() => {
  if (totalCriticalWeatherAlerts.value > 0) return 'bg-rose-100 text-rose-800';
  if (totalWeatherAlerts.value > 0) return 'bg-amber-100 text-amber-800';
  return 'bg-emerald-100 text-emerald-800';
});

const weatherWarnings = computed(() =>
  [
    ...(analyticsData.value?.weather?.weather_alert ? [{
      id: 'weather-alert',
      critical: true,
      title: 'Weather location needs attention',
      message: analyticsData.value.weather.weather_alert,
    }] : []),
    ...(analyticsData.value?.action_suggestions || [])
      .filter((suggestion) => isWeatherSuggestion(suggestion))
      .map((suggestion, index) => ({
        id: `weather-suggestion-${index}`,
        critical: suggestion.priority === 'high',
        title: suggestion.action_label || 'Weather recommendation',
        message: suggestion.message,
      })),
  ]
);

const decisionQueue = computed(() => {
  const analyticsSuggestions = (analyticsData.value?.action_suggestions || []).map((suggestion, index) => ({
    label: suggestion.action_label || suggestion.category || `Suggestion ${index + 1}`,
    detail: suggestion.message,
    to: suggestion.action_url || '/analytics',
    icon: getSuggestionIcon(suggestion.category),
    iconClass: getSuggestionIconClass(suggestion.priority),
  }));

  if (analyticsSuggestions.length > 0) {
    return analyticsSuggestions.slice(0, 4);
  }

  const queue = [];

  if (totalWeatherAlerts.value > 0) {
    queue.push({
      label: 'Review weather warnings',
      detail: `${totalWeatherAlerts.value} alert${totalWeatherAlerts.value > 1 ? 's' : ''} across monitored fields`,
      to: '/weather',
      icon: ExclamationTriangleIcon,
      iconClass: totalCriticalWeatherAlerts.value > 0 ? 'text-rose-600' : 'text-amber-600',
    });
  }

  if ((stats.value.pending_tasks || 0) > 0) {
    queue.push({
      label: 'Schedule labor and tasks',
      detail: `${stats.value.pending_tasks} pending task${stats.value.pending_tasks > 1 ? 's' : ''}`,
      to: '/tasks',
      icon: ClipboardDocumentListIcon,
      iconClass: 'text-emerald-600',
    });
  }

  if (resourceAlertCount.value > 0) {
    queue.push({
      label: 'Resolve resource alerts',
      detail: `${resourceAlertCount.value} stock or expiry issue${resourceAlertCount.value > 1 ? 's' : ''}`,
      to: '/inventory',
      icon: CubeIcon,
      iconClass: 'text-violet-600',
    });
  }

  if ((stats.value.pending_orders || 0) > 0) {
    queue.push({
      label: 'Process buyer orders',
      detail: `${stats.value.pending_orders} pending marketplace order${stats.value.pending_orders > 1 ? 's' : ''}`,
      to: '/marketplace/orders',
      icon: ShoppingBagIcon,
      iconClass: 'text-indigo-600',
    });
  }

  if (queue.length === 0) {
    queue.push({
      label: 'Open analytics review',
      detail: 'Use stored farm data to plan the next operational cycle',
      to: '/analytics',
      icon: ChartBarIcon,
      iconClass: 'text-emerald-600',
    });
  }

  return queue.slice(0, 4);
});

const isWeatherSuggestion = (suggestion) =>
  String(suggestion?.category || '').toLowerCase().includes('weather');

const formatDate = (date) => {
  if (!date) return 'No date';
  return new Date(date).toLocaleDateString();
};

const getSuggestionIcon = (category) => {
  const normalizedCategory = String(category || '').toLowerCase();

  if (normalizedCategory.includes('weather')) {
    return CloudIcon;
  }

  const icons = {
    tasks: ClipboardDocumentListIcon,
    inventory: CubeIcon,
    sales: ShoppingBagIcon,
    pests: ExclamationTriangleIcon,
    financial: ChartBarIcon,
  };

  return icons[normalizedCategory] || ChartBarIcon;
};

const getSuggestionIconClass = (priority) => {
  if (priority === 'high') return 'text-rose-600';
  if (priority === 'medium') return 'text-amber-600';
  return 'text-emerald-600';
};

const getPriorityClass = (priority) => {
  const priorityClasses = {
    high: 'bg-rose-100 text-rose-800',
    medium: 'bg-amber-100 text-amber-800',
    low: 'bg-emerald-100 text-emerald-800',
  };

  return priorityClasses[priority] || 'bg-gray-100 text-gray-700';
};

const getActivityTypeColor = (type) => {
  const typeColors = {
    planting: 'bg-emerald-500',
    task: 'bg-blue-500',
    order: 'bg-indigo-500',
    weather: 'bg-sky-500',
    inventory: 'bg-violet-500',
  };

  return typeColors[type] || 'bg-gray-400';
};

const normalizeTasks = (tasks) => {
  const nextWeek = new Date();
  nextWeek.setDate(nextWeek.getDate() + 7);

  return tasks
    .filter((task) => {
      if (!task.due_date) return false;
      const dueDate = new Date(task.due_date);
      return dueDate <= nextWeek && ['pending', 'in_progress'].includes(task.status);
    })
    .sort((a, b) => new Date(a.due_date) - new Date(b.due_date));
};

const getStock = (item) => Number(item.current_stock ?? item.quantity ?? 0);

const getExpiryCounts = (inventory) => {
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  return inventory.reduce((counts, item) => {
    if (!item.expiry_date || getStock(item) <= 0) return counts;

    const expiry = new Date(item.expiry_date);
    expiry.setHours(0, 0, 0, 0);
    const diffDays = Math.round((expiry.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));

    if (diffDays < 0) counts.expired += 1;
    if (diffDays >= 0 && diffDays <= 7) counts.expiring += 1;

    return counts;
  }, { expired: 0, expiring: 0 });
};

const generateRecentActivity = (lifecycle, tasks, orders) => {
  const activities = [];

  (lifecycle.plantings || []).slice(0, 3).forEach((planting) => {
    activities.push({
      id: `planting-${planting.id}`,
      description: `${planting.field?.name || 'Field'} updated to ${planting.current_stage?.riceGrowthStage?.name || 'current'} stage`,
      created_at: planting.updated_at || planting.created_at,
      type: 'planting',
    });
  });

  tasks.filter((task) => task.status === 'completed').slice(0, 3).forEach((task) => {
    activities.push({
      id: `task-${task.id}`,
      description: `Completed task: ${task.title}`,
      created_at: task.updated_at || task.created_at,
      type: 'task',
    });
  });

  orders.slice(0, 3).forEach((order) => {
    activities.push({
      id: `order-${order.id}`,
      description: `Buyer order received: ${order.rice_product?.name || 'Rice product'}`,
      created_at: order.order_date || order.created_at,
      type: 'order',
    });
  });

  return activities
    .filter((activity) => activity.created_at)
    .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
    .slice(0, 6);
};

const loadDashboardData = async () => {
  try {
    loading.value = true;
    error.value = null;

    const endDate = new Date().toISOString().split('T')[0];
    const startDate = new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString().split('T')[0];
    const response = await analyticsAPI.getDataAnalysis({ start_date: startDate, end_date: endDate });
    const data = response.data || {};

    analyticsData.value = data;

    stats.value = {
      total_area: data.fields?.total_area || 0,
      utilization_rate: data.fields?.utilization_rate || 0,
      active_seed_batches: data.nursery?.active_batches || 0,
      ready_for_transplant: data.nursery?.ready_for_transplant || 0,
      pending_tasks: data.tasks?.pending_tasks || 0,
      overdue_tasks: data.tasks?.overdue_tasks || 0,
      weather_alerts: totalWeatherAlerts.value,
      total_items: data.inventory?.total_items || 0,
      low_stock_items: data.inventory?.low_stock_count || 0,
      expiring_items_count: data.inventory?.expiring_soon_count || 0,
      failed_plantings_count: data.failure_analysis?.total_failed || 0,
      pending_orders: data.sales?.pending_orders || 0,
      marketplace_revenue: data.sales?.total_revenue || 0,
      monthly_expenses: data.expenses?.total_expenses || 0,
    };

    recentActivity.value = (data.action_suggestions || []).map((suggestion, index) => ({
      id: `suggestion-${index}`,
      description: suggestion.message,
      created_at: data.generated_at,
      type: suggestion.category || 'analytics',
    }));

    hasLoaded.value = true;
  } catch (err) {
    console.error('Error loading dashboard data:', err);
    error.value = err.response?.data?.message || 'Failed to load dashboard data';
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  loadDashboardData();
});
</script>
