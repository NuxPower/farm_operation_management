export const formatCurrency = (value, options = {}) => {
  const amount = Number.isFinite(value) ? value : Number(value) || 0;
  const {
    currency = 'PHP',
    locale = 'en-PH',
    minimumFractionDigits = 2,
    maximumFractionDigits = 2,
    fallback = '₱0.00',
  } = options;

  try {
    const formatter = new Intl.NumberFormat(locale, {
      style: 'currency',
      currency,
      minimumFractionDigits,
      maximumFractionDigits,
    });
    return formatter.format(amount);
  } catch (error) {
    console.warn('formatCurrency fallback triggered', error);
    return fallback;
  }
};

export const formatNumber = (value, options = {}) => {
  const amount = Number.isFinite(value) ? value : Number(value) || 0;
  const { locale = 'en-PH', minimumFractionDigits = 0, maximumFractionDigits = 0 } = options;

  return new Intl.NumberFormat(locale, {
    minimumFractionDigits,
    maximumFractionDigits,
  }).format(amount);
};

export const formatDate = (value, options = {}) => {
  if (!value) return 'N/A';
  const date = value instanceof Date ? value : new Date(value);
  if (Number.isNaN(date.getTime())) return 'N/A';

  const {
    locale = 'en-PH',
    dateStyle = 'medium',
    timeStyle = undefined,
  } = options;

  return new Intl.DateTimeFormat(locale, {
    dateStyle,
    timeStyle,
  }).format(date);
};

export const formatUnit = (unit) => {
  if (!unit) return '';
  const u = String(unit).toLowerCase();
  
  if (u === 'sacks_rice' || u === 'sacks_seed' || u === 'sack') return 'sack';
  if (u === 'kgs' || u === 'kg') return 'kg';
  if (u === 'tons') return 'ton';
  
  return unit.replace(/_/g, ' ');
};







