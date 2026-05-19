<template>
  <div class="min-h-screen bg-[linear-gradient(180deg,#f8fafc_0%,#eef7f2_36%,#f8fafc_100%)] text-gray-900">
    <div class="w-full px-6 py-8 space-y-7">
      <section class="overflow-hidden rounded-2xl border border-white/80 bg-white shadow-[0_24px_70px_rgba(15,23,42,0.10)]">
        <div class="grid grid-cols-1 xl:grid-cols-[1.3fr_0.7fr]">
          <div class="relative bg-[linear-gradient(135deg,#0f172a_0%,#14532d_48%,#0369a1_100%)] p-8 text-white">
            <p class="text-xs font-bold uppercase tracking-[0.24em] text-emerald-200">Field operations</p>
            <h1 class="mt-3 max-w-3xl text-4xl font-bold leading-tight">Rice Fields</h1>
            <p class="mt-4 max-w-3xl text-sm leading-6 text-white/75">
              Monitor land use, active plantings, soil conditions, and field readiness from one focused workspace.
            </p>
            <div class="mt-6 flex flex-wrap gap-2">
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Boundaries</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Planting Status</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Soil</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Irrigation</span>
            </div>
          </div>

          <div class="flex flex-col justify-between gap-6 bg-white p-8">
            <div>
              <p class="text-sm font-semibold text-gray-500">Farm profile</p>
              <p class="mt-2 text-2xl font-bold text-gray-900">{{ farmName }}</p>
              <p class="mt-2 text-sm leading-6 text-gray-500">
                {{ activePlantingCount }} field{{ activePlantingCount === 1 ? '' : 's' }} currently planted across {{ formatAreaValue(totalFieldArea) }} hectares.
              </p>
            </div>

            <div class="grid grid-cols-2 gap-3 sm:grid-cols-4">
              <div class="rounded-xl bg-emerald-50 p-3">
                <p class="text-xs font-medium text-emerald-700">Fields</p>
                <p class="mt-1 text-xl font-bold text-emerald-950">{{ fields.length }}</p>
              </div>
              <div class="rounded-xl bg-sky-50 p-3">
                <p class="text-xs font-medium text-sky-700">Area</p>
                <p class="mt-1 text-xl font-bold text-sky-950">{{ formatAreaValue(totalFieldArea) }} ha</p>
              </div>
              <div class="rounded-xl bg-amber-50 p-3">
                <p class="text-xs font-medium text-amber-700">Active</p>
                <p class="mt-1 text-xl font-bold text-amber-950">{{ activePlantingCount }}</p>
              </div>
              <div class="rounded-xl bg-violet-50 p-3">
                <p class="text-xs font-medium text-violet-700">Soil</p>
                <p class="mt-1 truncate text-xl font-bold text-violet-950">{{ primarySoilLabel }}</p>
              </div>
            </div>

            <div class="flex flex-wrap gap-2">
              <button
                @click="goToFieldSetup"
                class="inline-flex items-center gap-1.5 rounded-md bg-emerald-600 px-3 py-1.5 text-xs font-semibold text-white shadow-sm hover:bg-emerald-700"
              >
                <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v14m7-7H5" />
                </svg>
                Add Field
              </button>
              <button
                @click="openEditFarmModal"
                class="inline-flex items-center gap-1.5 rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 shadow-sm hover:bg-gray-50"
              >
                <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                </svg>
                Farm Details
              </button>
              <button
                @click="refreshFields"
                :disabled="loading"
                class="inline-flex items-center gap-1.5 rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 shadow-sm hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-60"
              >
                <svg :class="['h-3.5 w-3.5', { 'animate-spin': loading }]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                </svg>
                Refresh
              </button>
            </div>
          </div>
        </div>
      </section>

      <div v-if="error" class="rounded-xl border border-rose-200 bg-rose-50 p-4">
        <div class="flex items-start gap-3">
          <svg class="mt-0.5 h-5 w-5 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
          </svg>
          <div>
            <p class="text-sm font-semibold text-rose-900">Fields could not be loaded</p>
            <p class="mt-1 text-sm text-rose-700">{{ error }}</p>
            <button @click="refreshFields" class="mt-2 text-sm font-semibold text-rose-800 hover:text-rose-900">Try again</button>
          </div>
        </div>
      </div>

      <section class="rounded-2xl border border-gray-200 bg-white p-4 shadow-sm">
        <div class="grid grid-cols-1 gap-3 lg:grid-cols-[1fr_180px_180px_180px_auto]">
          <div class="relative">
            <svg class="pointer-events-none absolute left-3 top-2.5 h-4 w-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35m1.35-5.65a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input
              v-model="searchQuery"
              type="text"
              placeholder="Search field name or location"
              class="h-10 w-full rounded-lg border border-gray-200 bg-gray-50 pl-9 pr-3 text-sm font-medium text-gray-800 outline-none transition focus:border-emerald-500 focus:bg-white focus:ring-2 focus:ring-emerald-100"
            />
          </div>
          <select v-model="soilFilter" class="h-10 rounded-lg border border-gray-200 bg-white px-3 text-sm font-medium text-gray-700 outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-100">
            <option value="">All Soil Types</option>
            <option v-for="soil in soilOptions" :key="soil" :value="soil">{{ formatDisplayKey(soil) }}</option>
          </select>
          <select v-model="statusFilter" class="h-10 rounded-lg border border-gray-200 bg-white px-3 text-sm font-medium text-gray-700 outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-100">
            <option value="">All Statuses</option>
            <option value="active">Active</option>
            <option value="fallow">Fallow</option>
            <option value="maintenance">Maintenance</option>
          </select>
          <select v-model="cropFilter" class="h-10 rounded-lg border border-gray-200 bg-white px-3 text-sm font-medium text-gray-700 outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-100">
            <option value="">All Crops</option>
            <option v-for="crop in cropOptions" :key="crop" :value="crop">{{ formatDisplayKey(crop) }}</option>
          </select>
          <button
            v-if="hasFilters"
            @click="clearFilters"
            class="h-10 rounded-lg border border-gray-200 bg-white px-4 text-sm font-semibold text-gray-600 hover:border-rose-200 hover:bg-rose-50 hover:text-rose-700"
          >
            Clear
          </button>
        </div>
      </section>

      <div v-if="loading" class="grid grid-cols-1 gap-5 lg:grid-cols-2 2xl:grid-cols-3">
        <div v-for="n in 6" :key="n" class="animate-pulse rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
          <div class="h-5 w-1/3 rounded bg-gray-200"></div>
          <div class="mt-5 h-24 rounded-xl bg-gray-100"></div>
          <div class="mt-5 grid grid-cols-3 gap-3">
            <div class="h-16 rounded-xl bg-gray-100"></div>
            <div class="h-16 rounded-xl bg-gray-100"></div>
            <div class="h-16 rounded-xl bg-gray-100"></div>
          </div>
        </div>
      </div>

      <section v-else-if="fields.length === 0" class="rounded-2xl border border-dashed border-emerald-200 bg-white p-12 text-center shadow-sm">
        <div class="mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-emerald-50">
          <svg class="h-8 w-8 text-emerald-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 19l4-14 4 14m0 0l4-14 4 14M4 19h16" />
          </svg>
        </div>
        <h2 class="mt-5 text-2xl font-bold text-gray-950">No fields yet</h2>
        <p class="mx-auto mt-2 max-w-md text-sm leading-6 text-gray-500">
          Add your first field to start tracking planting schedules, weather context, and operational readiness.
        </p>
        <button @click="goToFieldSetup" class="mt-6 rounded-lg bg-emerald-600 px-5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-emerald-700">
          Create First Field
        </button>
      </section>

      <section v-else-if="filteredFields.length === 0" class="rounded-2xl border border-gray-200 bg-white p-12 text-center shadow-sm">
        <h2 class="text-xl font-bold text-gray-950">No fields match your filters</h2>
        <p class="mt-2 text-sm text-gray-500">Clear filters or search with a broader field name or location.</p>
        <button @click="clearFilters" class="mt-5 rounded-lg border border-gray-200 px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50">
          Clear Filters
        </button>
      </section>

      <section v-else class="grid grid-cols-1 gap-5 lg:grid-cols-2 2xl:grid-cols-3">
        <article
          v-for="field in filteredFields"
          :key="field.id"
          class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:shadow-[0_18px_50px_rgba(15,23,42,0.10)]"
        >
          <div class="border-b border-gray-100 bg-[linear-gradient(135deg,#ffffff_0%,#f0fdf4_100%)] p-6">
            <div class="flex items-start justify-between gap-4">
              <div class="min-w-0">
                <div class="flex items-center gap-3">
                  <div class="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-emerald-600 text-white shadow-sm">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 19l4-14 4 14m0 0l4-14 4 14M4 19h16" />
                    </svg>
                  </div>
                  <div class="min-w-0">
                    <h3 class="truncate text-lg font-bold text-gray-950">{{ field.name }}</h3>
                    <p class="mt-1 truncate text-sm text-gray-500">{{ formatLocation(field.location || field.address) }}</p>
                  </div>
                </div>
              </div>
              <span class="shrink-0 rounded-full px-3 py-1 text-xs font-bold" :class="statusClass(field.status)">
                {{ field.status ? statusLabel(field.status) : 'Active' }}
              </span>
            </div>
          </div>

          <div class="p-6">
            <div class="grid grid-cols-3 gap-3">
              <MiniStat label="Area" :value="formatArea(field.size || field.area || field.field_size)" tone="emerald" />
              <MiniStat label="Soil" :value="formatDisplayKey(field.soil_type) || 'Unset'" tone="amber" />
              <MiniStat label="Irrigation" :value="formatDisplayKey(field.irrigation_type) || 'Unset'" tone="blue" />
            </div>

            <div class="mt-5 rounded-xl border p-4" :class="field.current_crop ? 'border-emerald-100 bg-emerald-50' : 'border-gray-100 bg-gray-50'">
              <p class="text-xs font-bold uppercase tracking-wide" :class="field.current_crop ? 'text-emerald-700' : 'text-gray-500'">Current Planting</p>
              <div class="mt-2 flex flex-wrap items-center gap-2">
                <router-link
                  v-if="field.current_crop && field.current_planting_id"
                  :to="`/plantings/${field.current_planting_id}`"
                  class="text-sm font-bold text-emerald-950 hover:text-emerald-700 hover:underline"
                >
                  {{ formatDisplayKey(field.current_crop) }}
                </router-link>
                <span v-else class="text-sm font-bold" :class="field.current_crop ? 'text-emerald-950' : 'text-gray-500'">
                  {{ field.current_crop ? formatDisplayKey(field.current_crop) : 'No current crop' }}
                </span>
                <span v-if="field.current_planting_status" class="rounded-full px-2 py-0.5 text-xs font-bold" :class="plantingStatusClass(field.current_planting_status)">
                  {{ formatPlantingStatus(field.current_planting_status) }}
                </span>
              </div>
            </div>

            <div class="mt-5 flex items-center justify-between border-t border-gray-100 pt-4">
              <p class="text-xs font-medium text-gray-400">Updated {{ formatDate(field.updated_at || field.created_at) }}</p>
              <div class="flex items-center gap-2">
                <button
                  v-if="field.id"
                  @click="router.push(`/weather/fields/${field.id}`)"
                  class="rounded-md border border-sky-100 bg-sky-50 px-3 py-1.5 text-xs font-semibold text-sky-700 hover:bg-sky-100"
                >
                  Weather
                </button>
                <button
                  @click.stop="editField(field.id)"
                  class="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 hover:bg-gray-50"
                >
                  Edit
                </button>
              </div>
            </div>
          </div>
        </article>
      </section>
    </div>
    <EditFarmModal
      :show="showEditFarmModal"
      :farm="farmProfile"
      @close="showEditFarmModal = false"
      @updated="onFarmUpdated"
    />
  </div>
</template>

<script setup>
import { ref, computed, onMounted, h } from 'vue'
import { useRouter } from 'vue-router'
import { useFarmStore } from '@/stores/farm'
import EditFarmModal from '@/Components/Farm/EditFarmModal.vue'

const router = useRouter()
const farmStore = useFarmStore()

const loading = ref(true)
const error = ref('')
const showEditFarmModal = ref(false)

const fields = computed(() => farmStore.fields || [])
const farmProfile = computed(() => farmStore.farmProfile)

const farmName = computed(() => {
  return farmProfile.value?.name || farmProfile.value?.farm?.name || 'Anibukid Farm'
})

const getFieldArea = (field) => {
  const value = field?.size ?? field?.area ?? field?.field_size ?? 0
  const number = Number(value)
  return Number.isFinite(number) ? number : 0
}

const totalFieldArea = computed(() => {
  return fields.value.reduce((sum, field) => sum + getFieldArea(field), 0)
})

const activePlantingCount = computed(() => fields.value.filter(field => field.current_crop).length)
const fallowFieldCount = computed(() => fields.value.filter(field => field.status === 'fallow' || !field.current_crop).length)

const primarySoilLabel = computed(() => {
  const counts = fields.value.reduce((acc, field) => {
    if (!field.soil_type) return acc
    acc[field.soil_type] = (acc[field.soil_type] || 0) + 1
    return acc
  }, {})
  const primary = Object.entries(counts).sort((a, b) => b[1] - a[1])[0]?.[0]
  return primary ? formatDisplayKey(primary) : 'Unset'
})

// Filters
const searchQuery = ref('')
const soilFilter = ref('')
const statusFilter = ref('')
const cropFilter = ref('')

const soilOptions = computed(() => [
  ...new Set(fields.value.map(f => f.soil_type).filter(Boolean))
].sort())

const cropOptions = computed(() => [
  ...new Set(fields.value.map(f => f.current_crop).filter(Boolean))
].sort())

const hasFilters = computed(() => Boolean(searchQuery.value || soilFilter.value || statusFilter.value || cropFilter.value))

const filteredFields = computed(() => {
  const search = searchQuery.value.toLowerCase().trim()
  return fields.value.filter(f => {
    if (search) {
      const name = (f.name || '').toLowerCase()
      const loc = formatLocation(f.location || f.address).toLowerCase()
      if (!name.includes(search) && !loc.includes(search)) return false
    }
    if (soilFilter.value && f.soil_type !== soilFilter.value) return false
    if (statusFilter.value && f.status !== statusFilter.value) return false
    if (cropFilter.value && f.current_crop !== cropFilter.value) return false
    return true
  })
})

const clearFilters = () => {
  searchQuery.value = ''
  soilFilter.value = ''
  statusFilter.value = ''
  cropFilter.value = ''
}

const openEditFarmModal = () => {
  showEditFarmModal.value = true
}

const onFarmUpdated = async () => {
  await farmStore.fetchFarmProfile()
}

const refreshFields = async () => {
  loading.value = true
  error.value = ''

  try {
    await Promise.all([
      farmStore.fetchFields(),
      farmStore.fetchFarmProfile()
    ])
  } catch (err) {
    console.error('Failed to load fields:', err)
    error.value = err.userMessage || err.response?.data?.message || 'Unable to load fields.'
  } finally {
    loading.value = false
  }
}

const goToFieldSetup = () => {
  // Navigate directly to field creation page
  router.push('/fields/create')
}

const editField = (id) => {
  router.push(`/fields/${id}/edit`)
}

const formatArea = (value) => {
  if (!value) return '—'
  const num = Number(value)
  if (Number.isNaN(num)) return value
  return `${num.toFixed(1)} ha`
}

const formatAreaValue = (value) => {
  const num = Number(value)
  if (!Number.isFinite(num)) return '0.0'
  return num.toFixed(1)
}

const formatLocation = (location) => {
  if (!location) return 'Location not set'
  if (typeof location === 'string') return location
  const parts = [location.barangay, location.city, location.province].filter(Boolean)
  return parts.join(', ') || 'Location not set'
}

const formatDate = (value) => {
  if (!value) return 'Recently'
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? 'Recently' : date.toLocaleDateString()
}

const formatDisplayKey = (value) => {
  if (!value) return ''
  return String(value)
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase())
}

const statusLabel = (status) => {
  const labels = {
    active: 'Active',
    fallow: 'Fallow',
    maintenance: 'Maintenance'
  }
  return labels[status] || formatDisplayKey(status)
}

const plantingStatusClass = (status) => {
  const classes = {
    planned: 'bg-gray-100 text-gray-700',
    planted: 'bg-blue-100 text-blue-700',
    growing: 'bg-yellow-100 text-yellow-700',
    ready: 'bg-teal-100 text-teal-700',
    harvested: 'bg-green-100 text-green-700',
    failed: 'bg-red-100 text-red-700'
  }
  return classes[status] || 'bg-gray-100 text-gray-700'
}

const formatPlantingStatus = (status) => {
  if (!status) return ''
  return status.charAt(0).toUpperCase() + status.slice(1).replace(/_/g, ' ')
}

const statusClass = (status) => {
  const classes = {
    active: 'bg-green-100 text-green-800',
    fallow: 'bg-yellow-100 text-yellow-800',
    maintenance: 'bg-red-100 text-red-800'
  }
  return classes[status] || 'bg-blue-100 text-blue-800'
}

const miniToneClass = {
  emerald: 'border-emerald-100 bg-emerald-50 text-emerald-950',
  amber: 'border-amber-100 bg-amber-50 text-amber-950',
  blue: 'border-sky-100 bg-sky-50 text-sky-950'
}

const MiniStat = {
  props: {
    label: String,
    value: [String, Number],
    tone: { type: String, default: 'emerald' }
  },
  setup(props) {
    return () => h('div', {
      class: ['min-w-0 rounded-xl border p-3', miniToneClass[props.tone] || miniToneClass.emerald]
    }, [
      h('p', { class: 'truncate text-xs font-bold uppercase tracking-wide opacity-70' }, props.label),
      h('p', { class: 'mt-1 truncate text-sm font-bold' }, props.value)
    ])
  }
}

onMounted(() => {
  // Always refresh fields to get latest current_crop data
  refreshFields()
})
</script>
