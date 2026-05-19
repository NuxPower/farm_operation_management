<template>
  <div class="min-h-screen bg-[linear-gradient(180deg,#f8fafc_0%,#eef7f2_38%,#f8fafc_100%)]">
    <div class="w-full mx-auto px-6 py-8 space-y-6">
      <section class="overflow-hidden rounded-2xl border border-white/80 bg-white shadow-[0_24px_70px_rgba(15,23,42,0.10)]">
        <div class="grid grid-cols-1 lg:grid-cols-[1.25fr_0.75fr]">
          <div class="bg-[linear-gradient(135deg,#1e3a8a_0%,#047857_52%,#14532d_100%)] p-8 text-white">
            <p class="text-xs font-bold uppercase tracking-[0.24em] text-sky-100">Production Cycle</p>
            <h1 class="mt-3 text-4xl font-bold leading-tight">Tasks</h1>
            <p class="mt-4 max-w-2xl text-sm leading-6 text-white/75">
              Coordinate field work, labor assignments, and due dates across the active farm schedule.
            </p>
            <div class="mt-6 flex flex-wrap gap-2">
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Planning</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Labor</span>
              <span class="rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-semibold text-white/90">Deadlines</span>
            </div>
          </div>
          <div class="flex flex-col justify-between gap-5 bg-white p-8">
            <div>
              <p class="text-sm font-semibold text-gray-500">Workload</p>
              <p class="mt-2 text-2xl font-bold text-gray-900">{{ taskStats.open }} open task{{ taskStats.open === 1 ? '' : 's' }}</p>
              <p class="mt-2 text-sm leading-6 text-gray-500">{{ taskStats.urgent }} urgent and {{ taskStats.completed }} completed in this list.</p>
            </div>
            <div class="grid grid-cols-3 gap-3">
              <div class="rounded-xl bg-amber-50 p-3">
                <p class="text-xs font-medium text-amber-700">Pending</p>
                <p class="mt-1 text-xl font-bold text-amber-950">{{ taskStats.pending }}</p>
              </div>
              <div class="rounded-xl bg-sky-50 p-3">
                <p class="text-xs font-medium text-sky-700">In Progress</p>
                <p class="mt-1 text-xl font-bold text-sky-950">{{ taskStats.inProgress }}</p>
              </div>
              <div class="rounded-xl bg-rose-50 p-3">
                <p class="text-xs font-medium text-rose-700">Urgent</p>
                <p class="mt-1 text-xl font-bold text-rose-950">{{ taskStats.urgent }}</p>
              </div>
            </div>
            <button
              @click="showCreateModal = true"
              class="inline-flex w-fit items-center gap-1.5 rounded-md bg-emerald-600 px-3 py-1.5 text-xs font-semibold text-white shadow-sm hover:bg-emerald-700"
            >
              <span class="text-lg leading-none">+</span> New Task
            </button>
          </div>
        </div>
      </section>

      <!-- Filters and Search -->
      <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-5 mb-6">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
            <input
              v-model="searchQuery"
              type="text"
              placeholder="Search tasks..."
              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
            <select
              v-model="statusFilter"
              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">All Status</option>
              <option value="pending">Pending</option>
              <option value="in_progress">In Progress</option>
              <option value="completed">Completed</option>
              <option value="overdue">Overdue</option>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Priority</label>
            <select
              v-model="priorityFilter"
              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">All Priorities</option>
              <option value="low">Low</option>
              <option value="medium">Medium</option>
              <option value="high">High</option>
              <option value="urgent">Urgent</option>
            </select>
          </div>
          <div class="flex items-end">
            <button
              @click="clearFilters"
              class="w-full bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500"
            >
              Clear Filters
            </button>
          </div>
        </div>
      </div>

      <!-- Tasks List -->
      <div class="space-y-4">
        <div
          v-for="task in filteredTasks"
          :key="task.id"
          class="bg-white rounded-xl border border-gray-200 shadow-sm p-6 hover:shadow-md transition-shadow"
        >
          <div class="flex items-start justify-between">
            <div class="flex-1">
              <div class="flex items-center space-x-3 mb-2">
                <input
                  type="checkbox"
                  :checked="task.completed"
                  @change="toggleTask(task.id)"
                  class="w-5 h-5 text-blue-600 border-gray-300 rounded focus:ring-blue-500"
                />
                <h3 class="text-lg font-semibold text-gray-900">{{ task.title }}</h3>
                <span
                  :class="getPriorityBadgeClass(task.priority)"
                  class="px-2 py-1 text-xs font-medium rounded-full"
                >
                  {{ task.priority }}
                </span>
                <span
                  :class="getStatusBadgeClass(task.status)"
                  class="px-2 py-1 text-xs font-medium rounded-full"
                >
                  {{ task.status }}
                </span>
              </div>
              
              <p class="text-gray-600 mb-3">{{ task.description }}</p>
              
              <div class="flex items-center space-x-6 text-sm text-gray-500">
                <div class="flex items-center space-x-1">
                  <span>📅</span>
                  <span>Due: {{ formatDate(task.due_date) }}</span>
                </div>
                <div class="flex items-center space-x-1">
                  <span>🌾</span>
                  <span>{{ task.field_name || 'No field' }}</span>
                </div>
                <div class="flex items-center space-x-1">
                  <span>👤</span>
                  <span>{{ task.assigned_to || 'Unassigned' }}</span>
                </div>
                <div v-if="task.estimated_hours" class="flex items-center space-x-1">
                  <span>⏱️</span>
                  <span>{{ task.estimated_hours }}h</span>
                </div>
              </div>
            </div>
            
            <div class="flex space-x-2 ml-4">
              <button
                @click="viewTask(task.id)"
                class="bg-blue-600 text-white px-3 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
              >
                View
              </button>
              <button
                @click="editTask(task.id)"
                class="bg-gray-600 text-white px-3 py-2 rounded-md hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500 text-sm"
              >
                Edit
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-if="filteredTasks.length === 0" class="text-center py-12">
        <div class="text-gray-400 text-6xl mb-4">📋</div>
        <h3 class="text-xl font-medium text-gray-900 mb-2">No tasks found</h3>
        <p class="text-gray-600 mb-6">Get started by adding your first task</p>
        <button
          @click="showCreateModal = true"
          class="bg-blue-600 text-white px-6 py-3 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500"
        >
          Add Your First Task
        </button>
      </div>

      <!-- Create Task Modal -->
      <div v-if="showCreateModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 w-full max-w-md mx-4">
          <h2 class="text-xl font-semibold mb-4">Add New Task</h2>
          
          <form @submit.prevent="createTask" class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Task Title</label>
              <input
                v-model="newTask.title"
                type="text"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
              <textarea
                v-model="newTask.description"
                rows="3"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              ></textarea>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Field</label>
              <select
                v-model="newTask.field_id"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">Select field (optional)</option>
                <option v-for="field in fields" :key="field.id" :value="field.id">
                  {{ field.name }}
                </option>
              </select>
            </div>
            
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Priority</label>
                <select
                  v-model="newTask.priority"
                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                >
                  <option value="">Select priority</option>
                  <option value="low">Low</option>
                  <option value="medium">Medium</option>
                  <option value="high">High</option>
                  <option value="urgent">Urgent</option>
                </select>
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Due Date</label>
                <input
                  v-model="newTask.due_date"
                  type="date"
                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Estimated Hours</label>
              <input
                v-model="newTask.estimated_hours"
                type="number"
                step="0.5"
                min="0"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div class="flex justify-end space-x-3">
              <button
                type="button"
                @click="showCreateModal = false"
                class="px-4 py-2 text-gray-600 hover:text-gray-800"
              >
                Cancel
              </button>
              <button
                type="submit"
                :disabled="loading"
                class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50"
              >
                {{ loading ? 'Creating...' : 'Create Task' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const loading = ref(false)
const showCreateModal = ref(false)
const searchQuery = ref('')
const statusFilter = ref('')
const priorityFilter = ref('')

const fields = ref([
  { id: 1, name: 'North Field' },
  { id: 2, name: 'South Field' },
  { id: 3, name: 'East Field' }
])

const tasks = ref([
  {
    id: 1,
    title: 'Apply herbicide to North Field',
    description: 'Apply pre-emergent herbicide to prevent weed growth',
    field_id: 1,
    field_name: 'North Field',
    priority: 'high',
    status: 'pending',
    due_date: '2024-04-01',
    assigned_to: 'John Smith',
    estimated_hours: 4,
    completed: false
  },
  {
    id: 2,
    title: 'Check irrigation system',
    description: 'Inspect and test irrigation system in all fields',
    field_id: null,
    field_name: null,
    priority: 'medium',
    status: 'in_progress',
    due_date: '2024-03-30',
    assigned_to: 'Mike Johnson',
    estimated_hours: 6,
    completed: false
  },
  {
    id: 3,
    title: 'Fertilizer application',
    description: 'Apply side-dress fertilizer to corn fields',
    field_id: 1,
    field_name: 'North Field',
    priority: 'high',
    status: 'completed',
    due_date: '2024-03-20',
    assigned_to: 'John Smith',
    estimated_hours: 3,
    completed: true
  }
])

const newTask = ref({
  title: '',
  description: '',
  field_id: '',
  priority: '',
  due_date: '',
  estimated_hours: ''
})

const filteredTasks = computed(() => {
  return tasks.value.filter(task => {
    const matchesSearch = task.title.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                         task.description.toLowerCase().includes(searchQuery.value.toLowerCase())
    const matchesStatus = !statusFilter.value || task.status === statusFilter.value
    const matchesPriority = !priorityFilter.value || task.priority === priorityFilter.value
    
    return matchesSearch && matchesStatus && matchesPriority
  })
})

const taskStats = computed(() => ({
  pending: tasks.value.filter(task => task.status === 'pending').length,
  inProgress: tasks.value.filter(task => task.status === 'in_progress').length,
  completed: tasks.value.filter(task => task.status === 'completed').length,
  urgent: tasks.value.filter(task => task.priority === 'urgent').length,
  open: tasks.value.filter(task => task.status !== 'completed').length,
}))

const getPriorityBadgeClass = (priority) => {
  const classes = {
    low: 'bg-gray-100 text-gray-800',
    medium: 'bg-yellow-100 text-yellow-800',
    high: 'bg-orange-100 text-orange-800',
    urgent: 'bg-red-100 text-red-800'
  }
  return classes[priority] || 'bg-gray-100 text-gray-800'
}

const getStatusBadgeClass = (status) => {
  const classes = {
    pending: 'bg-yellow-100 text-yellow-800',
    in_progress: 'bg-blue-100 text-blue-800',
    completed: 'bg-green-100 text-green-800',
    overdue: 'bg-red-100 text-red-800'
  }
  return classes[status] || 'bg-gray-100 text-gray-800'
}

const formatDate = (date) => {
  if (!date) return 'Not set'
  return new Date(date).toLocaleDateString()
}

const viewTask = (id) => {
  router.push(`/tasks/${id}`)
}

const editTask = (id) => {
  // Navigate to edit page or show edit modal
  console.log('Edit task:', id)
}

const toggleTask = (id) => {
  const task = tasks.value.find(t => t.id === id)
  if (task) {
    task.completed = !task.completed
    task.status = task.completed ? 'completed' : 'pending'
  }
}

const createTask = async () => {
  loading.value = true
  try {
    const field = fields.value.find(f => f.id == newTask.value.field_id)
    const task = {
      id: Date.now(),
      ...newTask.value,
      field_name: field?.name || null,
      status: 'pending',
      assigned_to: null,
      completed: false
    }
    tasks.value.push(task)
    
    // Reset form
    newTask.value = {
      title: '',
      description: '',
      field_id: '',
      priority: '',
      due_date: '',
      estimated_hours: ''
    }
    showCreateModal.value = false
  } catch (error) {
    console.error('Error creating task:', error)
  } finally {
    loading.value = false
  }
}

const clearFilters = () => {
  searchQuery.value = ''
  statusFilter.value = ''
  priorityFilter.value = ''
}

onMounted(() => {
  // Load tasks from API
})
</script>

<style scoped>
.tasks-page {
  min-height: 100vh;
  background-color: #f8fafc;
}
</style>
