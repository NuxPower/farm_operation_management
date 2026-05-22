<template>
  <div class="weather-reports-page">
    <div class="container mx-auto px-4 py-8">
      <!-- Header -->
      <div class="flex flex-col justify-between gap-4 sm:flex-row sm:items-start mb-8">
        <div class="min-w-0">
          <button
            type="button"
            @click="router.push('/weather')"
            class="inline-flex items-center text-sm font-medium text-blue-600 hover:text-blue-800 transition-colors mb-4"
          >
            <svg class="h-4 w-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            Back to Weather
          </button>
          <h1 class="text-3xl font-bold text-gray-900">Weather Reports</h1>
          <p class="text-gray-600 mt-2">Analyze weather patterns and their impact on your farm</p>
        </div>
        <div class="flex flex-wrap gap-3 self-start sm:self-auto">
          <button
            @click="exportReport"
            class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500"
          >
            Export Report
          </button>
          <button
            @click="generateReport"
            class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500"
          >
            Generate Report
          </button>
        </div>
      </div>
      <!-- Filters -->
      <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <h2 class="text-lg font-semibold mb-4">Report Filters</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Date Range</label>
            <select
              v-model="dateRange"
              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="last7days">Last 7 Days</option>
              <option value="last30days">Last 30 Days</option>
              <option value="last3months">Last 3 Months</option>
              <option value="lastyear">Last Year</option>
            </select>
          </div>
          <div class="flex items-end">
            <button
              @click="updateReport"
              :disabled="loading"
              class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50"
            >
              {{ loading ? 'Loading...' : 'Update Report' }}
            </button>
          </div>
        </div>
      </div>

      <!-- Weather Summary -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="bg-white rounded-lg shadow-md p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                <span class="text-blue-600 text-2xl">🌡️</span>
              </div>
            </div>
            <div class="ml-4">
              <div class="text-2xl font-bold text-gray-900">{{ weatherSummary.avgTemperature }}°C</div>
              <div class="text-sm text-gray-600">Avg Temperature</div>
            </div>
          </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                <span class="text-blue-600 text-2xl">🌧️</span>
              </div>
            </div>
            <div class="ml-4">
              <div class="text-2xl font-bold text-gray-900">{{ weatherSummary.totalRainfall }} mm</div>
              <div class="text-sm text-gray-600">Total Rainfall</div>
            </div>
          </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                <span class="text-blue-600 text-2xl">💨</span>
              </div>
            </div>
            <div class="ml-4">
              <div class="text-2xl font-bold text-gray-900">{{ weatherSummary.avgWindSpeed }} km/h</div>
              <div class="text-sm text-gray-600">Avg Wind Speed</div>
            </div>
          </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                <span class="text-blue-600 text-2xl">☀️</span>
              </div>
            </div>
            <div class="ml-4">
              <div class="text-2xl font-bold text-gray-900">{{ weatherSummary.sunshineHours }}h</div>
              <div class="text-sm text-gray-600">Sunshine Hours</div>
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- Temperature Chart -->
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold mb-4">Temperature Trends</h2>
          <div class="w-full" style="height: 300px;">
            <LineChart v-if="temperatureChartData.labels.length > 0" :data="temperatureChartData" />
            <div v-else class="h-full flex items-center justify-center text-gray-500">
              No temperature data available
            </div>
          </div>
        </div>

        <!-- Rainfall Chart -->
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold mb-4">Rainfall Distribution</h2>
          <div class="w-full" style="height: 300px;">
            <BarChart v-if="rainfallChartData.labels.length > 0" :data="rainfallChartData" />
            <div v-else class="h-full flex items-center justify-center text-gray-500">
              No rainfall data available
            </div>
          </div>
        </div>
      </div>

      <!-- Growing Degree Days -->
      <div class="mt-8">
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold mb-4">Growing Degree Days (GDD)</h2>
          <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div class="text-center">
              <div class="text-3xl font-bold text-green-600">{{ gddData.today }}</div>
              <div class="text-sm text-gray-600">Today</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold text-blue-600">{{ gddData.week }}</div>
              <div class="text-sm text-gray-600">This Week</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold text-purple-600">{{ gddData.month }}</div>
              <div class="text-sm text-gray-600">This Month</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold text-yellow-600">{{ gddData.season }}</div>
              <div class="text-sm text-gray-600">This Season</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Weather Events -->
      <div class="mt-8">
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold mb-4">Significant Weather Events</h2>
          <div class="space-y-4">
            <div
              v-for="event in weatherEvents"
              :key="event.id"
              class="flex items-start space-x-3 p-4 border border-gray-200 rounded-lg"
            >
              <div class="flex-shrink-0">
                <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                  <span class="text-blue-600 text-sm">{{ getEventIcon(event.type) }}</span>
                </div>
              </div>
              <div class="flex-1">
                <div class="flex justify-between items-start">
                  <div>
                    <h3 class="font-medium text-gray-900">{{ event.title }}</h3>
                    <p class="text-sm text-gray-600 mt-1">{{ event.description }}</p>
                  </div>
                  <span class="text-sm text-gray-500">{{ formatDate(event.date) }}</span>
                </div>
                <div class="mt-2 flex items-center space-x-4 text-sm text-gray-600">
                  <span>Duration: {{ event.duration }}</span>
                  <span>Intensity: {{ event.intensity }}</span>
                  <span>Impact: {{ event.impact }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Historical Weather Data -->
      <div class="mt-8">
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
          <div class="px-6 py-4 border-b border-gray-200 flex justify-between items-center">
            <h2 class="text-xl font-semibold text-gray-900">Historical Weather Data</h2>
            <span class="text-sm text-gray-500">{{ dailyHistory.length }} records</span>
          </div>
          <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Condition</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Temp (°C)</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rainfall (mm)</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Humidity (%)</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Wind (km/h)</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-if="dailyHistory.length === 0">
                  <td colspan="6" class="px-6 py-4 text-center text-sm text-gray-500">
                    No historical data available for this period.
                  </td>
                </tr>
                <tr v-for="day in paginatedHistory" :key="day.date" class="hover:bg-gray-50">
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ formatDate(day.date) }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ formatGrowthStage(day.condition) }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ day.temperature }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ day.rainfall }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ day.humidity }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ day.wind_speed }}</td>
                </tr>
              </tbody>
            </table>
          </div>
          <!-- Pagination -->
          <div v-if="totalHistoryPages > 1" class="px-6 py-3 border-t border-gray-200 flex items-center justify-between">
            <span class="text-sm text-gray-600">
              Page {{ historyPage }} of {{ totalHistoryPages }}
            </span>
            <div class="flex items-center gap-1">
              <button
                @click="historyPage = 1"
                :disabled="historyPage === 1"
                class="px-2 py-1 text-xs rounded border border-gray-300 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed"
              >«</button>
              <button
                @click="historyPage--"
                :disabled="historyPage === 1"
                class="px-2 py-1 text-xs rounded border border-gray-300 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed"
              >‹</button>
              <button
                v-for="p in totalHistoryPages"
                :key="p"
                v-show="Math.abs(p - historyPage) <= 2"
                @click="historyPage = p"
                :class="[
                  'px-3 py-1 text-xs rounded border',
                  p === historyPage
                    ? 'bg-blue-600 text-white border-blue-600'
                    : 'border-gray-300 hover:bg-gray-100'
                ]"
              >{{ p }}</button>
              <button
                @click="historyPage++"
                :disabled="historyPage === totalHistoryPages"
                class="px-2 py-1 text-xs rounded border border-gray-300 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed"
              >›</button>
              <button
                @click="historyPage = totalHistoryPages"
                :disabled="historyPage === totalHistoryPages"
                class="px-2 py-1 text-xs rounded border border-gray-300 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed"
              >»</button>
            </div>
          </div>
        </div>
      </div>

      <!-- 7-Day Forecast -->
      <div class="mt-8">
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold mb-4">7-Day Forecast</h2>
          <div v-if="forecastLoading" class="text-center py-8">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
            <p class="text-gray-500 mt-4 text-sm">Loading forecast...</p>
          </div>
          <div v-else-if="forecast.length === 0" class="text-center py-8 text-gray-500">
            <p class="text-sm">No forecast data available. Try refreshing the Weather Dashboard first.</p>
            <button @click="router.push('/weather')" class="mt-3 text-blue-600 hover:text-blue-700 text-sm font-medium underline">Go to Weather Dashboard →</button>
          </div>
          <div v-else class="space-y-3">
            <div
              v-for="day in forecast"
              :key="day.date"
              class="flex flex-col md:flex-row md:items-center justify-between p-4 border border-gray-200 rounded-lg hover:bg-gray-50 gap-3"
            >
              <div class="flex items-center space-x-4">
                <div class="text-sm font-medium text-gray-900 w-28">{{ formatForecastDate(day.date) }}</div>
                <div class="text-2xl">{{ day.icon }}</div>
                <div class="font-medium text-gray-900">{{ day.condition }}</div>
              </div>
              <div class="flex items-center gap-6 text-sm text-gray-600">
                <div>
                  <span class="font-semibold text-gray-900">{{ day.high !== null && !isNaN(day.high) ? Math.round(day.high) + '°C' : '--' }}</span>
                  <span class="text-gray-400 mx-1">/</span>
                  <span>{{ day.low !== null && !isNaN(day.low) ? Math.round(day.low) + '°C' : '--' }}</span>
                </div>
                <div class="flex items-center gap-1">🌧️ {{ day.rain_chance !== null && !isNaN(day.rain_chance) ? Math.round(day.rain_chance) + '%' : '--' }}</div>
                <div class="flex items-center gap-1">💨 {{ day.wind_speed !== null && !isNaN(day.wind_speed) ? Math.round(day.wind_speed * 3.6) + ' km/h' : '--' }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Weather Impact Analysis -->
      <div class="mt-8">
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold mb-4">Weather Impact Analysis</h2>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <h3 class="font-medium text-gray-900 mb-3">Crop Development</h3>
              <div class="space-y-2">
                <div class="flex justify-between text-sm">
                  <span class="text-gray-600">Growth Stage</span>
                  <span class="font-medium">{{ formatGrowthStage(weatherImpact.crop_development.growth_stage) }}</span>
                </div>
                <div class="flex justify-between text-sm">
                  <span class="text-gray-600">Days to Maturity</span>
                  <span class="font-medium">{{ formatDaysToMaturity(weatherImpact.crop_development.days_to_maturity) }}</span>
                </div>
                <div class="flex justify-between text-sm">
                  <span class="text-gray-600">Stress Level</span>
                  <span 
                    class="font-medium"
                    :class="{
                      'text-green-600': weatherImpact.crop_development.stress_level === 'Low',
                      'text-yellow-600': weatherImpact.crop_development.stress_level === 'Moderate',
                      'text-red-600': weatherImpact.crop_development.stress_level === 'High'
                    }"
                  >
                    {{ weatherImpact.crop_development.stress_level }}
                  </span>
                </div>
              </div>
            </div>
            <div>
              <h3 class="font-medium text-gray-900 mb-3">Field Conditions</h3>
              <div class="space-y-2">
                <div class="flex justify-between text-sm">
                  <span class="text-gray-600">Soil Moisture</span>
                  <span class="font-medium">{{ weatherImpact.field_conditions.soil_moisture }}</span>
                </div>
                <div class="flex justify-between text-sm">
                  <span class="text-gray-600">Field Workability</span>
                  <span class="font-medium">{{ weatherImpact.field_conditions.field_workability }}</span>
                </div>
                <div class="flex justify-between text-sm">
                  <span class="text-gray-600">Disease Risk</span>
                  <span 
                    class="font-medium"
                    :class="{
                      'text-green-600': weatherImpact.field_conditions.disease_risk === 'Low',
                      'text-yellow-600': weatherImpact.field_conditions.disease_risk === 'Moderate',
                      'text-red-600': weatherImpact.field_conditions.disease_risk === 'High'
                    }"
                  >
                    {{ weatherImpact.field_conditions.disease_risk }}
                  </span>
                </div>
                <!-- Data Quality Score Added From Open Question -->
                <div class="flex justify-between text-sm mt-3 pt-3 border-t border-gray-100">
                  <span class="text-gray-600">Data Reliability Score</span>
                  <span 
                    class="font-medium"
                    :class="weatherImpact.data_quality >= 80 ? 'text-green-600' : 'text-yellow-600'"
                  >
                    {{ weatherImpact.data_quality }}%
                  </span>
                </div>
              </div>
            </div>
            <div>
              <h3 class="font-medium text-gray-900 mb-3">Recommendations</h3>
              <div class="space-y-2">
                <div v-for="(rec, index) in weatherImpact.recommendations" :key="index" class="text-sm text-gray-600 flex items-start">
                  <span class="mr-2">•</span>
                  <span>{{ rec }}</span>
                </div>
                <div v-if="weatherImpact.recommendations.length === 0" class="text-sm text-gray-500 italic">
                  No specific recommendations at this time.
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { reportsAPI } from '@/services/api'
import { useWeatherStore } from '@/stores/weather'
import { useFarmStore } from '@/stores/farm'
import LineChart from '@/Components/Charts/LineChart.vue'
import BarChart from '@/Components/Charts/BarChart.vue'

const dateRange = ref('last30days')
const weatherData = ref([])
const loading = ref(true)

const weatherSummary = ref({
  avgTemperature: 0,
  totalRainfall: 0,
  avgWindSpeed: 0,
  sunshineHours: 0
})

const gddData = ref({
  today: 0,
  week: 0,
  month: 0,
  season: 0
})

const weatherImpact = ref({
  crop_development: {
    growth_stage: 'N/A',
    days_to_maturity: 'N/A',
    stress_level: 'Low'
  },
  field_conditions: {
    soil_moisture: 'Unknown',
    field_workability: 'Unknown',
    disease_risk: 'Low'
  },
  recommendations: [],
  data_quality: 100
})



const weatherStore = useWeatherStore()
const farmStore = useFarmStore()

const weatherEvents = ref([])
const dailyHistory = ref([])

// Pagination
const historyPage = ref(1)
const historyPageSize = 10
const paginatedHistory = computed(() => {
  const start = (historyPage.value - 1) * historyPageSize
  return dailyHistory.value.slice(start, start + historyPageSize)
})
const totalHistoryPages = computed(() => Math.max(1, Math.ceil(dailyHistory.value.length / historyPageSize)))

// Forecast from weatherStore (same data as /weather)
const getWeatherIconFromCondition = (condition) => {
  const c = (condition || '').toLowerCase()
  if (c.includes('storm') || c.includes('thunder')) return '⛈️'
  if (c.includes('heavy rain')) return '🌧️'
  if (c.includes('rain') || c.includes('drizzle')) return '🌦️'
  if (c.includes('cloud') || c.includes('overcast')) return '☁️'
  if (c.includes('partly')) return '⛅'
  if (c.includes('fog') || c.includes('mist')) return '🌫️'
  if (c.includes('snow')) return '❄️'
  return '☀️'
}
const forecast = computed(() => {
  if (!weatherStore.forecast || weatherStore.forecast.length === 0) return []
  return weatherStore.forecast.map(day => {
    const condition = day.most_common_condition || day.condition || day.weather || 'Clear'
    const tempMin = day.temperature?.min ?? day.low ?? day.temperature_min ?? null
    const tempMax = day.temperature?.max ?? day.high ?? day.temperature_max ?? null
    return {
      date: day.date || day.time,
      condition,
      icon: getWeatherIconFromCondition(condition),
      high: tempMax,
      low: tempMin,
      rain_chance: day.precipitation_probability ?? day.rain_chance ?? 0,
      wind_speed: day.wind_speed_avg ?? day.wind_speed ?? 0,
      hourly: day.hourly || []
    }
  })
})
const forecastLoading = ref(false)

const getEventIcon = (type) => {
  const icons = {
    rain: '🌧️',
    wind: '💨',
    frost: '❄️',
    heat: '🌡️',
    storm: '⛈️'
  }
  return icons[type] || '🌤️'
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
}

const formatForecastDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })
}

const formatDaysToMaturity = (value) => {
  if (!value || value === 'N/A') return 'N/A'
  // If it looks like a date string (contains - or /)
  if (typeof value === 'string' && (value.includes('-') || value.includes('/'))) {
    const d = new Date(value)
    if (!isNaN(d.getTime())) {
      const today = new Date()
      const diffMs = d - today
      const diffDays = Math.round(diffMs / (1000 * 60 * 60 * 24))
      if (diffDays < 0) return 'Harvested'
      if (diffDays === 0) return 'Today'
      return `${diffDays} day${diffDays !== 1 ? 's' : ''} (${d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' })})`
    }
  }
  return value
}

const formatGrowthStage = (value) => {
  if (!value || value === 'N/A') return value
  // Title-case each word, replace underscores/hyphens with spaces
  return value
    .replace(/[_-]/g, ' ')
    .replace(/\w\S*/g, w => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase())
}

const updateReport = async () => {
  // Reload report data with current filters
  try {
    await loadWeatherData()
  } catch (error) {
    console.error('Failed to update report:', error)
  }
}

const generateReport = async () => {
  // Generate new report with current filters
  try {
    await loadWeatherData()
  } catch (error) {
    console.error('Failed to generate report:', error)
  }
}

const exportReport = () => {
  // Export report as CSV
  try {
    const csvContent = generateCSV()
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' })
    const link = document.createElement('a')
    const url = URL.createObjectURL(blob)
    link.setAttribute('href', url)
    link.setAttribute('download', `weather-report-${new Date().toISOString().split('T')[0]}.csv`)
    link.style.visibility = 'hidden'
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
  } catch (error) {
    console.error('Failed to export report:', error)
  }
}

const generateCSV = () => {
  // Generate CSV content from weather data
  const headers = ['Date', 'Temperature (°C)', 'Rainfall (mm)', 'Wind Speed (km/h)', 'Sunshine Hours']
  const rows = temperatureTrends.value.map((tempItem, index) => {
    const rainItem = rainfallDistribution.value[index] || {}
    return [
      tempItem.date || 'N/A',
      tempItem.temperature || 0,
      rainItem.rainfall || 0,
      weatherSummary.value.avgWindSpeed || 0,
      weatherSummary.value.sunshineHours || 0,
    ]
  })
  
  return [headers, ...rows].map(row => row.join(',')).join('\n')
}

const temperatureTrends = ref([])
const rainfallDistribution = ref([])

// Chart data computed properties
const temperatureChartData = computed(() => {
  if (!temperatureTrends.value || temperatureTrends.value.length === 0) {
    return { labels: [], datasets: [] }
  }
  
  return {
    labels: temperatureTrends.value.map(item => {
      const date = new Date(item.date)
      return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
    }),
    datasets: [
      {
        label: 'Temperature (°C)',
        data: temperatureTrends.value.map(item => item.temperature || 0),
        borderColor: 'rgb(239, 68, 68)',
        backgroundColor: 'rgba(239, 68, 68, 0.1)',
        fill: true,
        tension: 0.4,
      }
    ]
  }
})

const rainfallChartData = computed(() => {
  if (!rainfallDistribution.value || rainfallDistribution.value.length === 0) {
    return { labels: [], datasets: [] }
  }
  
  return {
    labels: rainfallDistribution.value.map(item => {
      const date = new Date(item.date)
      return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
    }),
    datasets: [
      {
        label: 'Rainfall (mm)',
        data: rainfallDistribution.value.map(item => item.rainfall || 0),
        backgroundColor: 'rgba(59, 130, 246, 0.8)',
      }
    ]
  }
})

const loadWeatherData = async () => {
  try {
    loading.value = true
    
    // Map date range to period
    const periodMap = {
      'last7days': 7,
      'last30days': 30,
      'last3months': 90,
      'lastyear': 365
    }
    const period = periodMap[dateRange.value] || 30
    
    // Pass field ID if selected, otherwise null for all fields
    const fieldId = null
    const response = await reportsAPI.getWeatherReport(period, fieldId)
    const data = response.data.data || response.data
    
    if (data.weather_summary) {
      weatherSummary.value = {
        avgTemperature: data.weather_summary.avg_temperature || 0,
        totalRainfall: data.weather_summary.total_rainfall || 0,
        avgWindSpeed: data.weather_summary.avg_wind_speed || 0,
        sunshineHours: data.weather_summary.sunshine_hours || 0,
      }
    }
    
    if (data.gdd_data) {
      gddData.value = {
        today: data.gdd_data.today || 0,
        week: data.gdd_data.week || 0,
        month: data.gdd_data.month || 0,
        season: data.gdd_data.season || 0,
      }
    }
    
    if (data.temperature_trends) {
      temperatureTrends.value = data.temperature_trends
    }
    
    if (data.rainfall_distribution) {
      rainfallDistribution.value = data.rainfall_distribution
    }
    
    if (data.weather_events) {
      weatherEvents.value = data.weather_events
    } else {
      weatherEvents.value = []
    }

    if (data.daily_history) {
      dailyHistory.value = data.daily_history
    } else {
      dailyHistory.value = []
    }

    if (data.weather_impact_analysis) {
      weatherImpact.value = data.weather_impact_analysis
    }
  } catch (error) {
    console.error('Error loading weather data:', error)
  } finally {
    loading.value = false
  }
}

import { useRoute, useRouter } from 'vue-router'

const router = useRouter()
const route = useRoute()

onMounted(async () => {
  loadWeatherData()
  // Load forecast from weatherStore (same as /weather dashboard)
  forecastLoading.value = true
  try {
    if (!farmStore.farmProfile) {
      await farmStore.fetchFarmProfile()
    }
    const farmId = farmStore.farmProfile?.id || farmStore.farmProfile?.farm?.id
    if (farmId && (!weatherStore.forecast || weatherStore.forecast.length === 0)) {
      await weatherStore.fetchForecast(farmId, 7)
    }
  } catch (e) {
    console.error('Failed to load forecast:', e)
  } finally {
    forecastLoading.value = false
  }
})
</script>

<style scoped>
.weather-reports-page {
  min-height: 100vh;
  background-color: #f8fafc;
}
</style>
