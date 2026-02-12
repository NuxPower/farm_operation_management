<template>
  <div class="bg-white rounded-2xl border border-gray-100 p-6 shadow-sm hover:border-green-200 transition-all group">
    <div class="flex items-center gap-4">
      <div :class="['h-12 w-12 rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform', iconBg, iconText]">
        <svg v-if="$slots.default" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <slot></slot>
        </svg>
        <span v-else class="font-bold text-xl">$</span>
      </div>
      <div>
        <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">{{ title }}</p>
        <p class="text-2xl font-black text-gray-900 leading-none mt-1">{{ value }}</p>
        <p class="text-[11px] text-gray-500 mt-1.5 font-medium">{{ sub }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: String,
  value: [String, Number],
  sub: String,
  iconBg: String,
  iconText: String,
});
</script>
