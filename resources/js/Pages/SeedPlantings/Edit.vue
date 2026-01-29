<template>
  <div class="min-h-screen bg-gray-50 py-8">
    <div class="w-full mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="mb-8 flex items-center justify-between">
        <div>
          <button 
            @click="$router.back()" 
            class="flex items-center text-sm text-gray-500 hover:text-green-600 transition-colors mb-2"
          >
            <ArrowLeftIcon class="h-4 w-4 mr-1" />
            Back to Nursery
          </button>
          <h1 class="text-3xl font-bold text-gray-900 tracking-tight">Edit Sowing</h1>
          <p class="mt-2 text-gray-600">Update details for this sowing batch.</p>
        </div>
      </div>

      <div v-if="loading" class="flex justify-center items-center py-12">
         <svg class="animate-spin h-8 w-8 text-green-600" fill="none" viewBox="0 0 24 24">
             <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
             <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
         </svg>
      </div>

      <!-- Main Form Card -->
      <div v-else class="bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
        <!-- Decorative Top Bar -->
        <div class="h-2 bg-gradient-to-r from-green-500 to-emerald-600"></div>

        <form @submit.prevent="submit" class="p-8">
          <!-- Section: Variety & Quantity -->
          <div class="mb-8">
            <h3 class="flex items-center text-lg font-semibold text-gray-900 mb-4">
              <span class="flex items-center justify-center w-8 h-8 rounded-full bg-green-100 text-green-600 mr-3 text-sm">1</span>
              Seed Details
            </h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <!-- Seed Source (Inventory) -->
              <div class="col-span-2">
                <label class="block text-sm font-medium text-gray-700 mb-2">Seed Source (Inventory)</label>
                <div class="relative rounded-xl shadow-sm">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <TagIcon class="h-5 w-5 text-gray-400" />
                  </div>
                  <select
                    v-model="form.inventory_item_id"
                    class="block w-full pl-10 pr-10 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md bg-gray-50"
                    disabled
                  >
                    <option value="" disabled>Select seeds from inventory...</option>
                     <option
                      v-for="item in inventorySeeds"
                      :key="item.id"
                      :value="item.id"
                    >
                      {{ item.name }}
                    </option>
                  </select>
                </div>
                <p class="mt-1 text-xs text-gray-500">Seed source cannot be changed after creation.</p>
                
                <!-- Display Variety Name -->
                 <div v-if="form.rice_variety_id" class="mt-2 flex items-center text-xs text-green-600 bg-green-50 px-3 py-1.5 rounded-lg border border-green-100">
                  <span class="font-medium mr-1">Variety:</span> 
                  {{ getVarietyName(form.rice_variety_id) }}
                </div>
              </div>

              <!-- Quantity -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Quantity</label>
                <div class="relative rounded-xl shadow-sm">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <ScaleIcon class="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    v-model="form.quantity"
                    type="number"
                    step="0.01"
                    class="block w-full pl-10 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md"
                    placeholder="0.00"
                    required
                  />
                </div>
              </div>

              <!-- Unit -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Unit</label>
                <div class="relative rounded-xl shadow-sm">
                  <select
                    v-model="form.unit"
                    class="block w-full pl-4 pr-10 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md"
                  >
                    <option value="kg">Kilograms (kg)</option>
                    <option value="sacks">Sacks</option>
                    <option value="bags">Bags</option>
                    <option value="trays">Trays</option>
                    <option value="packets">Packets</option>
                    <option value="pounds">Pounds</option>
                    <option value="grams">Grams (g)</option>
                  </select>
                </div>
              </div>
            </div>
          </div>

          <hr class="border-gray-100 my-8">

          <!-- Section: Schedule -->
          <div class="mb-8">
            <h3 class="flex items-center text-lg font-semibold text-gray-900 mb-4">
              <span class="flex items-center justify-center w-8 h-8 rounded-full bg-green-100 text-green-600 mr-3 text-sm">2</span>
              Schedule
            </h3>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <!-- Sown Date -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Date Sown</label>
                <div class="relative rounded-xl shadow-sm">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <CalendarDaysIcon class="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    v-model="form.planting_date"
                    type="date"
                    class="block w-full pl-10 pr-4 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md text-gray-600"
                    required
                  />
                </div>
              </div>

              <!-- Est. Transplant Date -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">
                  Est. Transplant Date
                   <span class="text-xs text-green-600 font-normal ml-1" v-if="suggestedTransplantDate">
                    (Suggested: {{ formatDate(suggestedTransplantDate) }})
                  </span>
                </label>
                <div class="relative rounded-xl shadow-sm">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <ClockIcon class="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    v-model="form.expected_transplant_date"
                    type="date"
                    class="block w-full pl-10 pr-4 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md text-gray-600"
                  />
                </div>
              </div>
            </div>
          </div>

          <hr class="border-gray-100 my-8">

          <!-- Section: Notes & Batch ID -->
          <div class="mb-8">
            <h3 class="flex items-center text-lg font-semibold text-gray-900 mb-4">
              <span class="flex items-center justify-center w-8 h-8 rounded-full bg-green-100 text-green-600 mr-3 text-sm">3</span>
              Additional Info
            </h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
               <!-- Batch ID -->
               <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Batch ID / Tag (Optional)</label>
                <div class="relative rounded-xl shadow-sm">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <TagIcon class="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    v-model="form.batch_id"
                    type="text"
                    class="block w-full pl-10 pr-4 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md"
                    placeholder="e.g. NUR-2025-001"
                  />
                </div>
              </div>

               <!-- Notes -->
               <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Notes</label>
                  <div class="relative rounded-xl shadow-sm">
                    <div class="absolute top-3 left-3 flex items-start pointer-events-none">
                      <DocumentTextIcon class="h-5 w-5 text-gray-400" />
                    </div>
                    <textarea
                      v-model="form.notes"
                      rows="1"
                      class="block w-full pl-10 pr-4 py-3 border-gray-200 rounded-xl focus:ring-green-500 focus:border-green-500 sm:text-sm transition-shadow shadow-sm hover:shadow-md resize-none"
                      placeholder="Special notes..."
                    ></textarea>
                  </div>
              </div>
            </div>
          </div>

          <!-- Actions -->
          <div class="flex items-center justify-end space-x-4 pt-4">
            <button
              type="button"
              @click="$router.back()"
              class="px-6 py-2.5 border border-gray-300 shadow-sm text-sm font-medium rounded-xl text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors"
            >
              Cancel
            </button>
            <button
              type="submit"
              :disabled="submitting"
              class="px-8 py-2.5 border border-transparent shadow-lg text-sm font-medium rounded-xl text-white bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transform hover:-translate-y-0.5 transition-all disabled:opacity-75 disabled:cursor-not-allowed"
            >
              <span v-if="submitting" class="flex items-center">
                <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Saving...
              </span>
              <span v-else>Update Sowing</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useInventoryStore } from '@/stores/inventory';
import axios from 'axios';
import { 
  ArrowLeftIcon, 
  TagIcon, 
  ScaleIcon, 
  CalendarDaysIcon, 
  ClockIcon,
  DocumentTextIcon
} from '@heroicons/vue/24/outline';

const router = useRouter();
const route = useRoute();
const inventoryStore = useInventoryStore();
const submitting = ref(false);
const loading = ref(true);
const varieties = ref([]);
const suggestedTransplantDate = ref(null);

const form = ref({
  inventory_item_id: '',
  rice_variety_id: '',
  quantity: '',
  unit: 'kg',
  planting_date: '',
  expected_transplant_date: '',
  batch_id: '',
  notes: '',
});

const inventorySeeds = computed(() => inventoryStore.riceSeeds);

const submit = async () => {
  submitting.value = true;
  
  try {
    const id = route.params.id;
    await axios.put(`/api/seed-plantings/${id}`, form.value);
    router.push('/seed-plantings');
  } catch (error) {
    console.error('Error updating seed planting:', error);
    alert('Failed to update record. Please check the inputs.');
  } finally {
    submitting.value = false;
  }
};

const fetchVarieties = async () => {
  try {
    const response = await axios.get('/api/rice-varieties');
    if (response.data.varieties && Array.isArray(response.data.varieties)) {
        varieties.value = response.data.varieties;
    } else if (Array.isArray(response.data)) {
        varieties.value = response.data;
    } else if (response.data.data && Array.isArray(response.data.data)) {
        varieties.value = response.data.data;
    } else {
        varieties.value = [];
    }
  } catch (error) {
    console.error('Error fetching varieties:', error);
  }
};

const getVarietyName = (id) => {
    const v = varieties.value.find(varItem => varItem.id === id);
    return v ? v.name : 'Unknown';
}

const formatDate = (dateStr) => {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    return date.toLocaleDateString('en-GB');
}

const fetchPlanting = async () => {
    try {
        const id = route.params.id;
        const response = await axios.get(`/api/seed-plantings/${id}`);
        const data = response.data.data ? response.data.data : response.data;
        
        form.value = {
            inventory_item_id: data.inventory_item_id,
            rice_variety_id: data.rice_variety_id,
            quantity: data.quantity,
            unit: data.unit,
            planting_date: data.planting_date,
            expected_transplant_date: data.expected_transplant_date,
            batch_id: data.batch_id,
            notes: data.notes
        };
        
        // Calculate suggestion based on fetched data
        if (form.value.planting_date) {
             const date = new Date(form.value.planting_date);
             date.setDate(date.getDate() + 18);
             suggestedTransplantDate.value = date.toISOString().split('T')[0];
        }

    } catch (error) {
        console.error("Error fetching planting:", error);
        alert("Failed to load planting details.");
        router.push('/seed-plantings');
    } finally {
        loading.value = false;
    }
}

onMounted(async () => {
  await Promise.all([
      fetchVarieties(),
      inventoryStore.fetchItems()
  ]);
  await fetchPlanting();
});
</script>
