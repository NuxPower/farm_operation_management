<template>
  <div class="min-h-screen bg-[linear-gradient(180deg,#f8fafc_0%,#fff7ed_38%,#f8fafc_100%)]">
    <div class="w-full mx-auto px-6 py-8 space-y-6">
      <section class="overflow-hidden rounded-2xl border border-white/80 bg-white shadow-[0_24px_70px_rgba(15,23,42,0.10)]">
        <div class="grid grid-cols-1 lg:grid-cols-[1.25fr_0.75fr]">
          <div class="bg-[linear-gradient(135deg,#7f1d1d_0%,#b45309_52%,#14532d_100%)] p-8 text-white">
            <p class="text-xs font-bold uppercase tracking-[0.24em] text-orange-100">Production Cycle</p>
            <h1 class="mt-3 text-4xl font-bold leading-tight">Pest & Disease Tracker</h1>
            <p class="mt-4 max-w-2xl text-sm leading-6 text-white/75">
              Record field incidents, treatment actions, and risk trends before they affect production.
            </p>
            <div class="mt-6 flex flex-wrap gap-2">
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Detection</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Treatment</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Resolution</span>
            </div>
          </div>
          <div class="flex flex-col justify-between gap-5 bg-white p-8">
            <div>
              <p class="text-sm font-semibold text-gray-500">Protection status</p>
              <p class="mt-2 text-2xl font-bold text-gray-900">{{ stats.active }} active incident{{ stats.active === 1 ? '' : 's' }}</p>
              <p class="mt-2 text-sm leading-6 text-gray-500">{{ stats.total }} total reports, {{ stats.treated }} treated, {{ stats.resolved }} resolved.</p>
            </div>
            <div class="grid grid-cols-3 gap-3">
              <div class="rounded-xl bg-rose-50 p-3">
                <p class="text-xs font-medium text-rose-700">Active</p>
                <p class="mt-1 text-xl font-bold text-rose-950">{{ stats.active }}</p>
              </div>
              <div class="rounded-xl bg-amber-50 p-3">
                <p class="text-xs font-medium text-amber-700">Treated</p>
                <p class="mt-1 text-xl font-bold text-amber-950">{{ stats.treated }}</p>
              </div>
              <div class="rounded-xl bg-emerald-50 p-3">
                <p class="text-xs font-medium text-emerald-700">Resolved</p>
                <p class="mt-1 text-xl font-bold text-emerald-950">{{ stats.resolved }}</p>
              </div>
            </div>
            <button
              @click="showCreateModal = true"
              class="inline-flex w-fit items-center gap-1.5 rounded-md bg-rose-600 px-3 py-1.5 text-xs font-semibold text-white shadow-sm hover:bg-rose-700"
            >
              <span class="text-lg leading-none">+</span> Report Incident
            </button>
          </div>
        </div>
      </section>

      <!-- Analytics Section (Collapsible) -->
      <div class="bg-white rounded-xl border border-gray-200 shadow-sm mb-6 overflow-hidden">
        <button @click="showAnalytics = !showAnalytics" class="w-full flex items-center justify-between p-5 hover:bg-gray-50 transition-colors">
          <h2 class="text-lg font-bold text-gray-800 flex items-center gap-2">
            <span class="text-xl">📊</span> Pest Analytics
          </h2>
          <svg :class="['w-5 h-5 text-gray-400 transition-transform duration-300', showAnalytics ? 'rotate-180' : '']" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
          </svg>
        </button>

        <div v-if="showAnalytics" class="px-5 pb-6 border-t border-gray-100">

          <div v-if="analyticsLoading" class="flex items-center justify-center py-12">
            <div class="animate-spin rounded-full h-8 w-8 border-2 border-red-100 border-t-red-600"></div>
          </div>

          <div v-else-if="analyticsData" class="mt-5 space-y-6">

            <!-- Row 1: Type Distribution + Severity Breakdown -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

              <!-- Pest Type Distribution -->
              <div>
                <h3 class="text-sm font-semibold text-gray-700 mb-3">Incidents by Type</h3>
                <div v-if="hasTypeData" class="space-y-3">
                  <div v-for="typeKey in ['insect', 'disease', 'weed', 'rodent', 'other']" :key="typeKey">
                    <template v-if="analyticsData.by_type[typeKey]">
                      <div class="flex items-center justify-between text-sm mb-1">
                        <span class="flex items-center gap-2 text-gray-700 font-medium">
                          <span>{{ getTypeIcon(typeKey) }}</span>
                          <span class="capitalize">{{ typeKey }}</span>
                        </span>
                        <span class="text-gray-500">{{ analyticsData.by_type[typeKey] }}</span>
                      </div>
                      <div class="w-full bg-gray-100 rounded-full h-2 overflow-hidden">
                        <div class="h-2 rounded-full transition-all duration-700" :class="typeBarColor(typeKey)"
                          :style="{ width: `${(analyticsData.by_type[typeKey] / maxTypeCount) * 100}%` }"></div>
                      </div>
                    </template>
                  </div>
                </div>
                <p v-else class="text-sm text-gray-400 py-4 text-center">No incident data yet</p>
              </div>

              <!-- Severity Breakdown (Donut) -->
              <div>
                <h3 class="text-sm font-semibold text-gray-700 mb-3">Severity Distribution</h3>
                <div v-if="hasSeverityData" class="flex items-center gap-8">
                  <div class="relative w-28 h-28 shrink-0">
                    <svg viewBox="0 0 100 100" class="w-full h-full transform -rotate-90">
                      <circle cx="50" cy="50" r="40" fill="transparent" stroke="#e5e7eb" stroke-width="12" />
                      <circle cx="50" cy="50" r="40" fill="transparent" stroke="#3b82f6" stroke-width="12"
                        :stroke-dasharray="`${sevPercent('low') * 2.51} 251.2`" class="transition-all duration-700" />
                      <circle cx="50" cy="50" r="40" fill="transparent" stroke="#f59e0b" stroke-width="12"
                        :stroke-dasharray="`${sevPercent('medium') * 2.51} 251.2`"
                        :stroke-dashoffset="`${-sevPercent('low') * 2.51}`" class="transition-all duration-700" />
                      <circle cx="50" cy="50" r="40" fill="transparent" stroke="#f97316" stroke-width="12"
                        :stroke-dasharray="`${sevPercent('high') * 2.51} 251.2`"
                        :stroke-dashoffset="`${-(sevPercent('low') + sevPercent('medium')) * 2.51}`" class="transition-all duration-700" />
                      <circle cx="50" cy="50" r="40" fill="transparent" stroke="#ef4444" stroke-width="12"
                        :stroke-dasharray="`${sevPercent('critical') * 2.51} 251.2`"
                        :stroke-dashoffset="`${-(sevPercent('low') + sevPercent('medium') + sevPercent('high')) * 2.51}`" class="transition-all duration-700" />
                    </svg>
                    <div class="absolute inset-0 flex flex-col items-center justify-center">
                      <span class="text-lg font-bold text-gray-900">{{ totalSeverity }}</span>
                      <span class="text-[10px] text-gray-400 uppercase">Total</span>
                    </div>
                  </div>
                  <div class="flex-1 space-y-2">
                    <div v-for="sev in [{ key: 'low', color: 'bg-blue-500', text: 'text-blue-700' }, { key: 'medium', color: 'bg-yellow-500', text: 'text-yellow-700' }, { key: 'high', color: 'bg-orange-500', text: 'text-orange-700' }, { key: 'critical', color: 'bg-red-500', text: 'text-red-700' }]"
                      :key="sev.key" class="flex items-center justify-between p-1.5 rounded hover:bg-gray-50">
                      <div class="flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full" :class="sev.color"></span>
                        <span class="text-sm text-gray-600 capitalize">{{ sev.key }}</span>
                      </div>
                      <span class="text-sm font-bold text-gray-900">{{ analyticsData.by_severity[sev.key] || 0 }}</span>
                    </div>
                  </div>
                </div>
                <p v-else class="text-sm text-gray-400 py-4 text-center">No incident data yet</p>
              </div>
            </div>

            <!-- Row 2: Monthly Trend -->
            <div>
              <h3 class="text-sm font-semibold text-gray-700 mb-3">Monthly Incident Trend</h3>
              <div v-if="hasMonthlyData" class="h-40 flex items-end gap-1 border-b border-gray-100 pb-1">
                <div v-for="(count, month) in analyticsData.monthly_trend" :key="month"
                  class="flex-1 flex flex-col items-center gap-1 group relative">
                  <span class="text-[10px] font-medium text-gray-500 opacity-0 group-hover:opacity-100 transition-opacity absolute -top-5">{{ count }}</span>
                  <div class="w-full rounded-t-sm transition-all duration-500 hover:bg-red-500"
                    :class="count > 0 ? 'bg-red-400' : 'bg-gray-100'"
                    :style="{ height: `${count > 0 ? Math.max((count / maxMonthlyCount) * 120, 6) : 4}px` }"></div>
                  <span class="text-[9px] text-gray-400 truncate w-full text-center">{{ formatMonthLabel(month) }}</span>
                </div>
              </div>
              <p v-else class="text-sm text-gray-400 py-4 text-center">No trend data yet</p>
            </div>

            <!-- Row 3: Treatment Costs + Top Pests + Resolution Time -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

              <!-- Treatment Costs -->
              <div class="bg-gray-50 rounded-lg p-4 border border-gray-100">
                <p class="text-xs font-medium text-gray-500 uppercase tracking-wide mb-2">Treatment Costs</p>
                <p class="text-xl font-bold text-gray-900">₱{{ formatNumber(analyticsData.treatment_costs.total) }}</p>
                <div class="mt-2 space-y-1 text-sm">
                  <div class="flex justify-between text-gray-600">
                    <span>Avg/incident</span>
                    <span class="font-medium">₱{{ formatNumber(analyticsData.treatment_costs.average_per_incident) }}</span>
                  </div>
                  <div v-if="analyticsData.treatment_costs.most_expensive" class="flex justify-between text-gray-600">
                    <span>Most expensive</span>
                    <span class="font-medium text-red-600 truncate max-w-[120px]" :title="analyticsData.treatment_costs.most_expensive.pest_name">{{ analyticsData.treatment_costs.most_expensive.pest_name }}</span>
                  </div>
                </div>
              </div>

              <!-- Top Recurring Pests -->
              <div class="bg-gray-50 rounded-lg p-4 border border-gray-100">
                <p class="text-xs font-medium text-gray-500 uppercase tracking-wide mb-2">Top Pests</p>
                <div v-if="analyticsData.top_pests?.length" class="space-y-2">
                  <div v-for="(pest, i) in analyticsData.top_pests" :key="i" class="flex items-center justify-between">
                    <span class="flex items-center gap-1.5 text-sm text-gray-700 truncate">
                      <span class="text-xs">{{ getTypeIcon(pest.pest_type) }}</span>
                      {{ pest.pest_name }}
                    </span>
                    <span class="text-xs font-bold text-gray-900 bg-white px-2 py-0.5 rounded-full border border-gray-200">{{ pest.count }}×</span>
                  </div>
                </div>
                <p v-else class="text-sm text-gray-400 text-center py-2">None yet</p>
              </div>

              <!-- Avg Resolution -->
              <div class="bg-gray-50 rounded-lg p-4 border border-gray-100">
                <p class="text-xs font-medium text-gray-500 uppercase tracking-wide mb-2">Avg. Resolution</p>
                <p class="text-xl font-bold text-gray-900">
                  {{ analyticsData.avg_resolution_days }}
                  <span class="text-sm font-normal text-gray-500">days</span>
                </p>
                <p class="text-xs text-gray-400 mt-1">From detection to resolved</p>
                <div class="mt-2 text-sm text-gray-600 flex justify-between">
                  <span>Treated incidents</span>
                  <span class="font-medium">{{ analyticsData.treatment_costs.treated_count }}</span>
                </div>
              </div>

            </div>
          </div>

          <!-- No Data State -->
          <div v-else class="text-center py-8 text-sm text-gray-400">
            Report pest incidents to start seeing analytics.
          </div>
        </div>
      </div>

      <!-- Filters -->
      <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-4 mb-6 flex flex-wrap gap-4">
        <select v-model="filter.status" @change="loadData" class="px-3 py-2 border rounded-lg">
          <option value="">All Status</option>
          <option value="active">Active</option>
          <option value="treated">Treated</option>
          <option value="resolved">Resolved</option>
        </select>
        <select v-model="filter.severity" @change="loadData" class="px-3 py-2 border rounded-lg">
          <option value="">All Severity</option>
          <option value="low">Low</option>
          <option value="medium">Medium</option>
          <option value="high">High</option>
          <option value="critical">Critical</option>
        </select>
      </div>

      <!-- Loading -->
      <div v-if="loading" class="text-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-red-600 mx-auto"></div>
      </div>

      <!-- Incidents List -->
      <div v-else-if="incidents.length > 0" class="space-y-4">
        <div v-for="incident in incidents" :key="incident.id"
          class="bg-white rounded-xl shadow p-6 hover:shadow-lg transition-shadow"
        >
          <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div class="flex-1">
              <div class="flex items-center gap-3 mb-2">
                <span class="text-2xl">{{ getTypeIcon(incident.pest_type) }}</span>
                <h3 class="font-semibold text-gray-900">{{ incident.pest_name }}</h3>
                <span :class="getSeverityClass(incident.severity)" class="px-2 py-1 rounded-full text-xs font-medium">
                  {{ incident.severity }}
                </span>
                <span :class="getStatusClass(incident.status)" class="px-2 py-1 rounded-full text-xs font-medium capitalize">
                  {{ incident.status }}
                </span>
              </div>
              <div class="text-sm text-gray-600 space-y-1">
                <p><strong>Field:</strong> {{ incident.planting?.field?.name || 'N/A' }}</p>
                <p><strong>Detected:</strong> {{ formatDate(incident.detected_date) }}</p>
                <p v-if="incident.symptoms"><strong>Symptoms:</strong> {{ incident.symptoms }}</p>
                <p v-if="incident.treatment_applied" class="text-green-600">
                  <strong>Treatment:</strong> {{ incident.treatment_applied }}
                </p>
              </div>
            </div>
            <div class="flex flex-col gap-2">
              <button v-if="incident.status === 'active'"
                @click="markTreated(incident)"
                class="px-4 py-2 bg-yellow-500 text-white rounded-lg text-sm hover:bg-yellow-600"
              >Mark Treated</button>
              <button v-if="incident.status === 'treated'"
                @click="markResolved(incident)"
                class="px-4 py-2 bg-green-600 text-white rounded-lg text-sm hover:bg-green-700"
              >Mark Resolved</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-else class="text-center py-12 bg-white rounded-xl">
        <div class="text-5xl mb-4">🐛</div>
        <h3 class="text-lg font-medium text-gray-900">No incidents recorded</h3>
        <p class="text-gray-500 mt-1">Click "Report Incident" to log a pest or disease issue</p>
      </div>

      <!-- Create Modal -->
      <div v-if="showCreateModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div class="bg-white rounded-xl max-w-lg w-full p-6 max-h-[90vh] overflow-y-auto">
          <h2 class="text-xl font-bold text-gray-900 mb-4">Report Pest Incident</h2>
          
          <form @submit.prevent="submitIncident">
            <div class="grid grid-cols-2 gap-4 mb-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Pest Type</label>
                <select v-model="form.pest_type" required class="w-full px-3 py-2 border rounded-lg">
                  <option value="">Select type</option>
                  <option value="insect">Insect</option>
                  <option value="disease">Disease</option>
                  <option value="weed">Weed</option>
                  <option value="rodent">Rodent</option>
                  <option value="other">Other</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Severity</label>
                <select v-model="form.severity" required class="w-full px-3 py-2 border rounded-lg">
                  <option value="low">Low</option>
                  <option value="medium">Medium</option>
                  <option value="high">High</option>
                  <option value="critical">Critical</option>
                </select>
              </div>
            </div>

            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700 mb-1">Pest/Disease Name</label>
              <input v-model="form.pest_name" type="text" required
                class="w-full px-3 py-2 border rounded-lg" placeholder="e.g., Rice Stem Borer" />
            </div>

  <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700 mb-1">Field</label>
              <select v-model="selectedFieldId" required class="w-full px-3 py-2 border rounded-lg">
                <option value="">Select field</option>
                <option v-for="field in fields" :key="field.id" :value="field.id">
                  {{ field.name }}
                </option>
              </select>
              
              <div v-if="selectedPlanting" class="mt-2 p-3 bg-gray-50 rounded-lg text-sm border border-gray-100">
                <p class="font-medium text-gray-700">Linked Crop:</p>
                <div class="flex items-center gap-2 mt-1">
                   <span class="text-green-700 font-medium">{{ selectedPlanting.rice_variety?.name || selectedPlanting.crop_type }}</span>
                   <span class="text-gray-400">•</span>
                   <span class="capitalize text-gray-600">{{ selectedPlanting.status }}</span>
                   <span class="text-gray-400">•</span>
                   <span class="text-gray-500">Planted: {{ formatDate(selectedPlanting.planting_date) }}</span>
                </div>
              </div>
              <div v-else-if="selectedFieldId" class="mt-2 text-sm text-yellow-600">
                ⚠️ No active planting found for this field.
              </div>
            </div>

            <div class="grid grid-cols-2 gap-4 mb-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Detected Date</label>
                <input v-model="form.detected_date" type="date" required class="w-full px-3 py-2 border rounded-lg" />
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Affected Area (ha)</label>
                <input v-model="form.affected_area" type="number" step="0.01" class="w-full px-3 py-2 border rounded-lg"
                  :placeholder="selectedPlanting ? `Max: ${selectedPlanting.area_planted} ha` : ''"
                  :max="selectedPlanting?.area_planted"
                 />
              </div>
            </div>

            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700 mb-1">Symptoms</label>
              <textarea v-model="form.symptoms" rows="2" class="w-full px-3 py-2 border rounded-lg"
                placeholder="Describe observed symptoms..."></textarea>
            </div>

            <div class="flex gap-3">
              <button type="button" @click="showCreateModal = false"
                class="flex-1 px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200"
              >Cancel</button>
              <button type="submit" :disabled="submitting"
                class="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 disabled:opacity-50"
              >{{ submitting ? 'Saving...' : 'Save Incident' }}</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, watch } from 'vue'
import axios from 'axios'
import { useFormValidation } from '@/composables/useFormValidation'

const loading = ref(true)
const { errors: clientErrors, rules, validateForm, sanitizeForm, clearErrors } = useFormValidation()
const incidents = ref([])
const stats = ref({ total: 0, active: 0, treated: 0, resolved: 0 })
const plantings = ref([])
const selectedFieldId = ref('')

// --- Analytics ---
const showAnalytics = ref(true)
const analyticsLoading = ref(true)
const analyticsData = ref(null)

const hasTypeData = computed(() => analyticsData.value && Object.keys(analyticsData.value.by_type || {}).length > 0)
const hasSeverityData = computed(() => analyticsData.value && Object.keys(analyticsData.value.by_severity || {}).length > 0)
const hasMonthlyData = computed(() => {
  if (!analyticsData.value?.monthly_trend) return false
  return Object.values(analyticsData.value.monthly_trend).some(v => v > 0)
})

const maxTypeCount = computed(() => {
  if (!analyticsData.value?.by_type) return 1
  return Math.max(...Object.values(analyticsData.value.by_type), 1)
})

const maxMonthlyCount = computed(() => {
  if (!analyticsData.value?.monthly_trend) return 1
  return Math.max(...Object.values(analyticsData.value.monthly_trend), 1)
})

const totalSeverity = computed(() => {
  if (!analyticsData.value?.by_severity) return 0
  return Object.values(analyticsData.value.by_severity).reduce((a, b) => a + b, 0)
})

const sevPercent = (key) => {
  if (totalSeverity.value === 0) return 0
  return ((analyticsData.value?.by_severity?.[key] || 0) / totalSeverity.value) * 100
}

const typeBarColor = (type) => {
  const colors = { insect: 'bg-amber-500', disease: 'bg-red-500', weed: 'bg-green-500', rodent: 'bg-gray-600', other: 'bg-blue-500' }
  return colors[type] || 'bg-gray-400'
}

const formatMonthLabel = (month) => {
  const [y, m] = month.split('-')
  const labels = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  return labels[parseInt(m) - 1] || m
}

const formatNumber = (num) => {
  if (!num) return '0'
  return new Intl.NumberFormat('en-PH', { minimumFractionDigits: 0, maximumFractionDigits: 2 }).format(num)
}

const loadAnalytics = async () => {
  analyticsLoading.value = true
  try {
    const response = await axios.get('/api/pest-incidents/analytics')
    analyticsData.value = response.data
  } catch (error) {
    console.error('Failed to load pest analytics:', error)
    analyticsData.value = null
  } finally {
    analyticsLoading.value = false
  }
}

// --- End Analytics ---

const selectedPlanting = computed(() => {
   if (!form.value.planting_id) return null
   return plantings.value.find(p => p.id === form.value.planting_id)
})

watch(selectedFieldId, (newFieldId) => {
  if (!newFieldId) {
    form.value.planting_id = ''
    return
  }
  
  // Find active planting for this field
  // Priority: Growing > Planted > Ready > Planned > Harvested
  const fieldPlantings = plantings.value.filter(p => p.field_id === newFieldId)
  
  if (fieldPlantings.length === 0) {
    form.value.planting_id = ''
    return
  }

  const priority = { growing: 1, planted: 2, ready: 3, planned: 4, harvested: 5, failed: 6 }
  
  const bestPlanting = fieldPlantings.sort((a, b) => {
    const pA = priority[a.status] || 99
    const pB = priority[b.status] || 99
    // If status is same, prefer newer
    if (pA === pB) {
        return new Date(b.planting_date) - new Date(a.planting_date)
    }
    return pA - pB
  })[0]

  if (bestPlanting) {
    form.value.planting_id = bestPlanting.id
  }
})

const showCreateModal = ref(false)
const submitting = ref(false)
const filter = ref({ status: '', severity: '' })

const form = ref({
  pest_type: '',
  pest_name: '',
  severity: 'medium',
  planting_id: '',
  detected_date: new Date().toISOString().split('T')[0],
  affected_area: null,
  symptoms: '',
})

const loadData = async () => {
  loading.value = true
  try {
    const params = {}
    if (filter.value.status) params.status = filter.value.status
    if (filter.value.severity) params.severity = filter.value.severity

    const response = await axios.get('/api/pest-incidents', { params })
    incidents.value = response.data.incidents?.data || []
    stats.value = response.data.stats || { total: 0, active: 0, treated: 0, resolved: 0 }
  } catch (error) {
    console.error('Failed to load incidents:', error)
  } finally {
    loading.value = false
  }
}

const loadPlantings = async () => {
  try {
    const response = await axios.get('/api/plantings')
    plantings.value = response.data.plantings || response.data || []
  } catch (error) {
    console.error('Failed to load plantings:', error)
  }
}

const fields = ref([])
const loadFields = async () => {
  try {
    const response = await axios.get('/api/fields')
    fields.value = response.data.fields || response.data || []
  } catch (error) {
    console.error('Failed to load fields:', error)
  }
}

const submitIncident = async () => {
  submitting.value = true
  
  clearErrors()
  sanitizeForm(form.value)
  
  const isValid = validateForm(form.value, {
    pest_type: [rules.required, rules.maxLength(50)],
    pest_name: [rules.required, rules.maxLength(100), rules.noEmoji],
    detected_date: [rules.required],
    affected_area: [rules.numeric, rules.minValue(0.01)],
    symptoms: [rules.maxLength(1000), rules.noEmoji]
  })
  
  if (!isValid) {
    alert('Validation failed: ' + Object.values(clientErrors.value).join(' | '))
    submitting.value = false
    return
  }
  
  try {
    await axios.post('/api/pest-incidents', form.value)
    showCreateModal.value = false
    resetForm()
    loadData()
    loadAnalytics() // Refresh analytics after new incident
  } catch (error) {
    alert(error.response?.data?.message || 'Failed to save incident')
  } finally {
    submitting.value = false
  }
}

const markTreated = async (incident) => {
  const treatment = prompt('What treatment was applied?')
  if (!treatment) return
  try {
    await axios.put(`/api/pest-incidents/${incident.id}`, {
      status: 'treated',
      treatment_applied: treatment,
      treatment_date: new Date().toISOString().split('T')[0]
    })
    loadData()
    loadAnalytics()
  } catch (error) {
    alert('Failed to update')
  }
}

const markResolved = async (incident) => {
  try {
    await axios.put(`/api/pest-incidents/${incident.id}`, { status: 'resolved' })
    loadData()
    loadAnalytics()
  } catch (error) {
    alert('Failed to update')
  }
}

const resetForm = () => {
  form.value = {
    pest_type: '',
    pest_name: '',
    severity: 'medium',
    planting_id: '',
    detected_date: new Date().toISOString().split('T')[0],
    affected_area: null,
    symptoms: '',
  }
}

const formatDate = (date) => {
  if (!date) return 'N/A'
  return new Date(date).toLocaleDateString('en-PH', { month: 'short', day: 'numeric', year: 'numeric' })
}

const getTypeIcon = (type) => {
  const icons = { insect: '🐛', disease: '🦠', weed: '🌿', rodent: '🐀', other: '⚠️' }
  return icons[type] || '❓'
}

const getSeverityClass = (severity) => {
  const classes = {
    low: 'bg-blue-100 text-blue-800',
    medium: 'bg-yellow-100 text-yellow-800',
    high: 'bg-orange-100 text-orange-800',
    critical: 'bg-red-100 text-red-800',
  }
  return classes[severity] || 'bg-gray-100 text-gray-800'
}

const getStatusClass = (status) => {
  const classes = {
    active: 'bg-red-100 text-red-800',
    treated: 'bg-yellow-100 text-yellow-800',
    resolved: 'bg-green-100 text-green-800',
  }
  return classes[status] || 'bg-gray-100 text-gray-800'
}

onMounted(() => {
  loadData()
  loadPlantings()
  loadFields()
  loadAnalytics()
})
</script>
