import { defineStore } from 'pinia';
import axios from 'axios';

export const useWeatherStore = defineStore('weather', {
  state: () => ({
    currentWeather: null,
    farmsWeather: {}, // Cache for farm-specific weather { farmId: { data: ..., timestamp: ... } }
    forecast: [],
    weatherHistory: [],
    alerts: [],
    loading: false,
    error: null,
  }),

  getters: {
    hasWeatherData: (state) => !!state.currentWeather,
    criticalAlerts: (state) => state.alerts.filter(alert => alert.severity === 'critical'),
    weatherWarnings: (state) => state.alerts.filter(alert =>
      [
        'heavy_rain',
        'drought',
        'typhoon',
        'extreme_temperature',
        'high_humidity',
        'low_humidity'
      ].includes(alert.type)
    ),
  },

  actions: {
    async fetchCurrentWeather(farmId, force = false) {
      // Check cache first (10 minute TTL)
      const now = Date.now();
      const cached = this.farmsWeather[farmId];
      if (!force && cached && (now - cached.timestamp < 10 * 60 * 1000)) {
        this.currentWeather = cached.data;
        return { weather: cached.data, alerts: cached.alerts };
      }

      this.loading = true;
      try {
        const response = await axios.get(`/api/weather/farms/${farmId}/current`);
        const weatherData = response.data.weather;

        this.currentWeather = weatherData;
        if (response.data.alerts) {
          this.alerts = response.data.alerts;
        }

        // Update cache
        this.farmsWeather[farmId] = {
          data: weatherData,
          alerts: response.data.alerts || [],
          timestamp: now
        };

        return response.data;
      } catch (error) {
        this.error = error.response?.data?.message || 'Failed to fetch current weather';
        throw error;
      } finally {
        this.loading = false;
      }
    },

    async fetchForecast(farmId, days = 7) {
      this.loading = true;
      try {
        const response = await axios.get(`/api/weather/farms/${farmId}/forecast`, {
          params: { days }
        });
        // Backend returns { forecast: { daily_forecasts: [...], summary: {...} }, ... }
        // Extract the daily_forecasts array for the UI
        const forecastData = response.data.forecast || {};
        this.forecast = forecastData.daily_forecasts || forecastData || [];
        return response.data;
      } catch (error) {
        this.error = error.response?.data?.message || 'Failed to fetch forecast';
        console.error('Forecast fetch error:', error);
        this.forecast = []; // Set to empty array on error
        throw error;
      } finally {
        this.loading = false;
      }
    },

    async fetchWeatherHistory(farmId, days = 30) {
      this.loading = true;
      try {
        const response = await axios.get(`/api/weather/farms/${farmId}/history`, {
          params: { days, per_page: 5000 }
        });
        // Handle paginated or direct response structure
        if (response.data.weather_logs) {
          this.weatherHistory = response.data.weather_logs.data || response.data.weather_logs;
        } else {
          this.weatherHistory = response.data.data || response.data.history || [];
        }
        return response.data;
      } catch (error) {
        this.error = error.response?.data?.message || 'Failed to fetch weather history';
        throw error;
      } finally {
        this.loading = false;
      }
    },

    async fetchWeatherAlerts(farmId) {
      this.loading = true;
      try {
        const response = await axios.get(`/api/weather/farms/${farmId}/alerts`);
        this.alerts = response.data.alerts;
        return response.data;
      } catch (error) {
        this.error = error.response?.data?.message || 'Failed to fetch weather alerts';
        throw error;
      } finally {
        this.loading = false;
      }
    },

    async updateWeather(farmId, weatherData) {
      this.loading = true;
      try {
        const response = await axios.post(`/api/weather/farms/${farmId}/update`, weatherData);
        return response.data;
      } catch (error) {
        this.error = error.response?.data?.message || 'Failed to update weather';
        throw error;
      } finally {
        this.loading = false;
      }
    },
  },
});
