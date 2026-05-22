<template>
  <div class="min-h-screen bg-slate-50">
    <div class="mx-auto w-full max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
      <header class="mb-4 flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p class="text-sm font-semibold uppercase tracking-wide text-emerald-700">Buyer Dashboard</p>
          <h1 class="mt-1 text-3xl font-bold text-gray-950">Rice Marketplace</h1>
          <p class="mt-2 max-w-2xl text-sm text-gray-600">
            Welcome back, {{ authStore.user?.name }}. Track orders, review pickup updates, and continue shopping from local farmers.
          </p>
        </div>
        <router-link
          to="/marketplace"
          class="inline-flex items-center justify-center rounded-lg bg-emerald-600 px-4 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2"
        >
          <MagnifyingGlassIcon class="mr-2 h-5 w-5" />
          Browse marketplace
        </router-link>
      </header>

      <section class="mb-5">
        <div class="grid grid-cols-2 gap-2 sm:grid-cols-4">
          <router-link
            v-for="action in quickActions"
            :key="action.label"
            :to="action.to"
            class="group rounded-lg border border-gray-200 bg-white p-3 shadow-sm transition hover:border-emerald-300 hover:shadow-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2 sm:p-4"
          >
            <div class="flex flex-col gap-2 sm:flex-row sm:items-center sm:gap-3">
              <div :class="action.iconWrapClass" class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg sm:h-10 sm:w-10">
                <component :is="action.icon" class="h-5 w-5" :class="action.iconClass" />
              </div>
              <div class="min-w-0 flex-1">
                <p class="text-sm font-semibold text-gray-950 group-hover:text-emerald-700">{{ action.label }}</p>
                <p class="mt-0.5 truncate text-xs text-gray-500">{{ action.detail }}</p>
              </div>
              <ChevronRightIcon class="hidden h-4 w-4 shrink-0 text-gray-400 transition group-hover:translate-x-0.5 group-hover:text-emerald-600 sm:block" />
            </div>
          </router-link>
        </div>
      </section>

      <div class="grid grid-cols-1 gap-6 xl:grid-cols-3">
        <main class="space-y-6 xl:col-span-2">
          <section class="rounded-lg border border-gray-200 bg-white shadow-sm">
            <div class="flex items-center justify-between gap-4 border-b border-gray-200 px-5 py-4">
              <div>
                <h2 class="text-lg font-semibold text-gray-950">Available Products</h2>
                <p class="text-sm text-gray-500">Fresh rice listings ready for order.</p>
              </div>
              <router-link to="/marketplace" class="text-sm font-semibold text-emerald-700 hover:text-emerald-800">
                View all
              </router-link>
            </div>

            <div v-if="loading" class="grid grid-cols-1 gap-4 p-5 sm:grid-cols-2">
              <div v-for="n in 4" :key="n" class="animate-pulse rounded-lg border border-gray-200 p-4">
                <div class="mb-4 h-36 rounded bg-gray-200"></div>
                <div class="mb-2 h-4 rounded bg-gray-200"></div>
                <div class="h-4 w-2/3 rounded bg-gray-200"></div>
              </div>
            </div>

            <div v-else-if="featuredProducts.length" class="grid grid-cols-1 gap-4 p-4 sm:grid-cols-2 sm:p-5">
              <article
                v-for="product in featuredProducts"
                :key="product.id"
                class="overflow-hidden rounded-lg border border-gray-200 transition hover:border-emerald-300 hover:shadow-md"
              >
                <button class="block w-full text-left" type="button" @click="viewProduct(product)">
                  <div class="h-40 overflow-hidden bg-emerald-50 sm:h-36">
                    <img
                      v-if="getProductImage(product)"
                      :src="getProductImage(product)"
                      :alt="product.name"
                      class="h-full w-full object-cover"
                      @error="handleImageError"
                    />
                    <div v-else class="flex h-full w-full items-center justify-center">
                      <SparklesIcon class="h-10 w-10 text-emerald-500" />
                    </div>
                  </div>
                  <div class="p-4">
                    <div class="flex items-start justify-between gap-3">
                      <div class="min-w-0">
                        <h3 class="line-clamp-1 text-sm font-semibold text-gray-950">{{ product.name }}</h3>
                        <p class="mt-1 line-clamp-2 text-xs text-gray-500">{{ getProductDescription(product) }}</p>
                      </div>
                      <span class="shrink-0 rounded-full bg-emerald-100 px-2 py-1 text-xs font-semibold text-emerald-800">
                        {{ getProductQuantity(product) }} {{ getProductUnit(product) }}
                      </span>
                    </div>
                    <div class="mt-4 flex items-center justify-between gap-3">
                      <div>
                        <p class="text-lg font-bold text-emerald-700">{{ formatCurrency(getProductPrice(product)) }}</p>
                        <p class="text-xs text-gray-500">per {{ getProductUnit(product) }}</p>
                      </div>
                    </div>
                  </div>
                </button>
                <div class="border-t border-gray-100 p-4 pt-0">
                  <button
                    type="button"
                    @click.stop="addToCart(product)"
                    :disabled="addingToCartId === product.id || getProductQuantity(product) <= 0"
                    class="mt-3 inline-flex w-full items-center justify-center rounded-lg bg-gray-950 px-3 py-2 text-sm font-semibold text-white transition hover:bg-gray-800 disabled:cursor-not-allowed disabled:opacity-50"
                  >
                    <ArrowPathIcon v-if="addingToCartId === product.id" class="mr-2 h-4 w-4 animate-spin" />
                    <ShoppingBagIcon v-else class="mr-2 h-4 w-4" />
                    {{ addingToCartId === product.id ? 'Adding' : 'Add to cart' }}
                  </button>
                </div>
              </article>
            </div>

            <div v-else class="p-10 text-center">
              <SparklesIcon class="mx-auto h-12 w-12 text-gray-300" />
              <h3 class="mt-3 text-sm font-semibold text-gray-950">No products available</h3>
              <p class="mt-1 text-sm text-gray-500">Fresh listings will appear here when farmers publish products.</p>
              <router-link to="/marketplace" class="mt-5 inline-flex items-center rounded-lg bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700">
                Browse marketplace
              </router-link>
            </div>
          </section>

          <section class="rounded-lg border border-gray-200 bg-white shadow-sm">
            <div class="flex items-center justify-between gap-4 border-b border-gray-200 px-5 py-4">
              <div>
                <h2 class="text-lg font-semibold text-gray-950">Recent Orders</h2>
                <p class="text-sm text-gray-500">Latest marketplace activity.</p>
              </div>
              <router-link to="/buyer/orders" class="text-sm font-semibold text-emerald-700 hover:text-emerald-800">
                View orders
              </router-link>
            </div>

            <div v-if="recentOrders.length" class="divide-y divide-gray-100">
              <button
                v-for="order in recentOrders.slice(0, 5)"
                :key="order.id"
                type="button"
                class="flex w-full items-center justify-between gap-4 px-5 py-4 text-left transition hover:bg-gray-50"
                @click="viewOrder(order.id)"
              >
                <div class="min-w-0">
                  <p class="text-sm font-semibold text-gray-950">Order #{{ order.id }}</p>
                  <p class="mt-1 truncate text-sm text-gray-500">
                    {{ order.quantity || 1 }} {{ formatUnit(order.rice_product?.unit || order.unit || 'kg') }}
                    · {{ order.rice_product?.name || order.product_name || 'Rice product' }}
                  </p>
                  <p class="mt-1 text-xs text-gray-400">{{ formatDate(order.created_at || order.order_date) }}</p>
                </div>
                <div class="shrink-0 text-right">
                  <span class="inline-flex rounded-full px-2.5 py-1 text-xs font-semibold" :class="getOrderStatusClass(order.status)">
                    {{ formatOrderStatus(order.status) }}
                  </span>
                  <p class="mt-2 text-sm font-semibold text-gray-950">{{ formatCurrency(order.total_amount || 0) }}</p>
                </div>
              </button>
            </div>

            <div v-else class="p-10 text-center">
              <DocumentTextIcon class="mx-auto h-12 w-12 text-gray-300" />
              <h3 class="mt-3 text-sm font-semibold text-gray-950">No orders yet</h3>
              <p class="mt-1 text-sm text-gray-500">Orders will show here after checkout.</p>
              <router-link to="/marketplace" class="mt-5 inline-flex items-center rounded-lg bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700">
                Start shopping
              </router-link>
            </div>
          </section>
        </main>

        <aside class="space-y-6">
          <section class="rounded-lg border border-gray-200 bg-white shadow-sm">
            <div class="flex items-center justify-between gap-4 border-b border-gray-200 px-5 py-4">
              <div>
                <h2 class="text-lg font-semibold text-gray-950">Notifications</h2>
                <p class="text-sm text-gray-500">{{ notifications.length }} unread update{{ notifications.length === 1 ? '' : 's' }}</p>
              </div>
              <button
                v-if="notifications.length"
                type="button"
                class="text-sm font-semibold text-emerald-700 hover:text-emerald-800"
                @click="markAllNotificationsRead"
              >
                Clear all
              </button>
            </div>

            <div v-if="notifications.length" class="divide-y divide-gray-100">
              <article v-for="notification in notifications.slice(0, 5)" :key="notification.id" class="p-5">
                <div class="flex items-start gap-3">
                  <div class="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-blue-50">
                    <BellIcon class="h-5 w-5 text-blue-600" />
                  </div>
                  <div class="min-w-0 flex-1">
                    <h3 class="text-sm font-semibold text-gray-950">{{ notification.title }}</h3>
                    <p class="mt-1 text-sm text-gray-600">{{ notification.message }}</p>
                    <div class="mt-3 flex items-center gap-3">
                      <button
                        v-if="getNotificationRoute(notification)"
                        type="button"
                        class="text-sm font-semibold text-blue-700 hover:text-blue-800"
                        @click="openNotification(notification)"
                      >
                        View details
                      </button>
                      <button
                        type="button"
                        class="text-sm font-semibold text-gray-500 hover:text-gray-700"
                        @click="markAsRead(notification)"
                      >
                        Dismiss
                      </button>
                    </div>
                  </div>
                </div>
              </article>
            </div>

            <div v-else class="p-8 text-center">
              <BellIcon class="mx-auto h-10 w-10 text-gray-300" />
              <p class="mt-3 text-sm font-semibold text-gray-950">No unread notifications</p>
              <p class="mt-1 text-sm text-gray-500">Pickup and order updates will appear here.</p>
            </div>
          </section>

          <section class="rounded-lg border border-gray-200 bg-white p-5 shadow-sm">
            <h2 class="text-lg font-semibold text-gray-950">Next Best Action</h2>
            <p class="mt-1 text-sm text-gray-500">{{ nextAction.detail }}</p>
            <router-link
              :to="nextAction.to"
              class="mt-5 inline-flex w-full items-center justify-center rounded-lg bg-emerald-600 px-4 py-2.5 text-sm font-semibold text-white transition hover:bg-emerald-700"
            >
              <component :is="nextAction.icon" class="mr-2 h-5 w-5" />
              {{ nextAction.label }}
            </router-link>
          </section>
        </aside>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import {
  ArrowPathIcon,
  BellIcon,
  ChevronRightIcon,
  DocumentTextIcon,
  MagnifyingGlassIcon,
  ShoppingBagIcon,
  ShoppingCartIcon,
  SparklesIcon,
  UserCircleIcon,
} from '@heroicons/vue/24/outline';
import { notificationsAPI } from '@/services/api';
import { useAuthStore } from '@/stores/auth';
import { useMarketplaceStore } from '@/stores/marketplace';
import { formatCurrency, formatUnit } from '@/utils/format';

const router = useRouter();
const authStore = useAuthStore();
const marketplaceStore = useMarketplaceStore();

const loading = ref(false);
const notifications = ref([]);
const addingToCartId = ref(null);

const availableProducts = computed(() => {
  const products = marketplaceStore.products?.data || marketplaceStore.products || [];
  return Array.isArray(products) ? products : [];
});

const featuredProducts = computed(() => availableProducts.value.slice(0, 4));
const recentOrders = computed(() => Array.isArray(marketplaceStore.orders) ? marketplaceStore.orders : []);

const pendingOrdersCount = computed(() => recentOrders.value.filter((order) => {
  return ['pending', 'confirmed', 'accepted', 'ready_for_pickup', 'negotiating'].includes(order.status);
}).length);

const quickActions = computed(() => [
  {
    label: 'Browse Rice Products',
    detail: `${availableProducts.value.length} listings available`,
    to: '/marketplace',
    icon: MagnifyingGlassIcon,
    iconWrapClass: 'bg-emerald-50',
    iconClass: 'text-emerald-600',
  },
  {
    label: 'Shopping Cart',
    detail: `${marketplaceStore.cartItemsCount} item${marketplaceStore.cartItemsCount === 1 ? '' : 's'} in cart`,
    to: '/cart',
    icon: ShoppingBagIcon,
    iconWrapClass: 'bg-blue-50',
    iconClass: 'text-blue-600',
  },
  {
    label: 'Order History',
    detail: `${recentOrders.value.length} recent order${recentOrders.value.length === 1 ? '' : 's'}`,
    to: '/buyer/orders',
    icon: DocumentTextIcon,
    iconWrapClass: 'bg-violet-50',
    iconClass: 'text-violet-600',
  },
  {
    label: 'Profile',
    detail: 'Account and contact details',
    to: '/profile',
    icon: UserCircleIcon,
    iconWrapClass: 'bg-gray-100',
    iconClass: 'text-gray-600',
  },
]);

const nextAction = computed(() => {
  if (marketplaceStore.cartItemsCount > 0) {
    return {
      label: 'Review cart',
      detail: 'You have items waiting for checkout.',
      to: '/cart',
      icon: ShoppingCartIcon,
    };
  }

  if (pendingOrdersCount.value > 0) {
    return {
      label: 'Track orders',
      detail: 'You have active orders with farmer updates.',
      to: '/buyer/orders',
      icon: DocumentTextIcon,
    };
  }

  return {
    label: 'Browse products',
    detail: 'Find fresh rice varieties from local farmers.',
    to: '/marketplace',
    icon: MagnifyingGlassIcon,
  };
});

const fetchNotifications = async () => {
  try {
    const response = await notificationsAPI.getAll({ unread_only: true });
    const payload = response.data?.notifications;
    notifications.value = payload?.data || payload || [];
  } catch (error) {
    console.error('Failed to fetch notifications:', error);
    notifications.value = [];
  }
};

const markAsRead = async (notification) => {
  try {
    await notificationsAPI.markAsRead(notification.id);
    notifications.value = notifications.value.filter((item) => item.id !== notification.id);
  } catch (error) {
    console.error('Failed to mark notification as read:', error);
  }
};

const markAllNotificationsRead = async () => {
  try {
    await notificationsAPI.markAllAsRead();
    notifications.value = [];
  } catch (error) {
    console.error('Failed to mark all notifications as read:', error);
  }
};

const getNotificationRoute = (notification) => {
  const orderId = notification?.data?.order_id || notification?.data?.rice_order_id;
  const link = notification?.link;

  if (orderId) {
    return `/buyer/orders/${orderId}`;
  }

  if (!link) return null;

  if (link.startsWith('/marketplace/orders')) {
    return link.replace('/marketplace/orders', '/buyer/orders');
  }

  if (link.startsWith('/orders')) {
    return link.replace('/orders', '/buyer/orders');
  }

  if (link === '/buyer/products') {
    return '/marketplace';
  }

  return link;
};

const openNotification = async (notification) => {
  const route = getNotificationRoute(notification);
  await markAsRead(notification);

  if (route) {
    router.push(route);
  }
};

const addToCart = async (product) => {
  if (addingToCartId.value || getProductQuantity(product) <= 0) return;

  addingToCartId.value = product.id;
  try {
    await marketplaceStore.addToCart(product, 1);
  } catch (error) {
    console.error('Failed to add to cart:', error);
  } finally {
    addingToCartId.value = null;
  }
};

const viewProduct = (product) => {
  router.push(`/marketplace/products/${product.id}`);
};

const viewOrder = (orderId) => {
  router.push(`/buyer/orders/${orderId}`);
};

const getOrderStatusClass = (status) => {
  const classes = {
    pending: 'bg-amber-100 text-amber-800',
    negotiating: 'bg-purple-100 text-purple-800',
    accepted: 'bg-blue-100 text-blue-800',
    confirmed: 'bg-blue-100 text-blue-800',
    ready_for_pickup: 'bg-emerald-100 text-emerald-800',
    completed: 'bg-green-100 text-green-800',
    delivered: 'bg-green-100 text-green-800',
    cancelled: 'bg-red-100 text-red-800',
    expired: 'bg-red-100 text-red-800',
  };
  return classes[status] || 'bg-gray-100 text-gray-700';
};

const formatOrderStatus = (status = 'pending') => {
  return String(status).replaceAll('_', ' ').replace(/\b\w/g, (letter) => letter.toUpperCase());
};

const formatDate = (date) => {
  if (!date) return 'No date';
  return new Date(date).toLocaleDateString();
};

const getProductPrice = (product) => {
  return Number(product.price_per_unit ?? product.price ?? product.unit_price ?? 0);
};

const getProductQuantity = (product) => {
  return Number(product.quantity_available ?? product.quantity ?? product.available_quantity ?? 0);
};

const getProductUnit = (product) => {
  return formatUnit(product.unit ?? product.unit_type ?? 'kg');
};

const getProductDescription = (product) => {
  return product.description || product.summary || product.rice_variety?.name || 'Premium rice variety';
};

const getProductImage = (product) => {
  if (Array.isArray(product.images) && product.images.length > 0) {
    return product.images[0];
  }

  return product.image || product.thumbnail || null;
};

const handleImageError = (event) => {
  event.target.style.display = 'none';
};

onMounted(async () => {
  loading.value = true;

  try {
    await Promise.all([
      marketplaceStore.fetchProducts({ per_page: 8 }),
      marketplaceStore.fetchOrders(),
      marketplaceStore.fetchCart(),
      fetchNotifications(),
    ]);
  } catch (error) {
    console.error('Failed to load buyer dashboard data:', error);
  } finally {
    loading.value = false;
  }
});
</script>
