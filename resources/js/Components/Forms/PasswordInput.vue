<template>
  <div class="relative">
    <input
      v-bind="$attrs"
      :type="visible ? 'text' : 'password'"
      :value="modelValue"
      :class="[
        inputClass,
        'pr-10'
      ]"
      @input="$emit('update:modelValue', $event.target.value)"
    />
    <button
      type="button"
      class="absolute inset-y-0 right-0 z-20 flex w-10 items-center justify-center rounded-r-md text-gray-500 hover:text-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-green-500"
      :aria-label="visible ? 'Hide password' : 'Show password'"
      :title="visible ? 'Hide password' : 'Show password'"
      @click="visible = !visible"
    >
      <EyeSlashIcon v-if="visible" class="h-5 w-5" aria-hidden="true" />
      <EyeIcon v-else class="h-5 w-5" aria-hidden="true" />
    </button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { EyeIcon, EyeSlashIcon } from '@heroicons/vue/24/outline'

defineOptions({
  inheritAttrs: false,
})

defineProps({
  modelValue: {
    type: String,
    default: '',
  },
  inputClass: {
    type: [String, Array, Object],
    default: '',
  },
})

defineEmits(['update:modelValue'])

const visible = ref(false)
</script>
