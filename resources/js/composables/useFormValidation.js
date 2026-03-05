import { ref } from 'vue';

export function useFormValidation() {
    const errors = ref({});

    const emojiRegex = /[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F1E0}-\u{1F1FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{FE00}-\u{FE0F}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{200D}\u{20E3}\u{231A}-\u{231B}\u{23E9}-\u{23F3}\u{23F8}-\u{23FA}\u{25AA}-\u{25AB}\u{25B6}\u{25C0}\u{25FB}-\u{25FE}\u{2614}-\u{2615}\u{2648}-\u{2653}\u{267F}\u{2693}\u{26A1}\u{26AA}-\u{26AB}\u{26BD}-\u{26BE}\u{26C4}-\u{26C5}\u{26CE}\u{26D4}\u{26EA}\u{26F2}-\u{26F3}\u{26F5}\u{26FA}\u{26FD}\u{2702}\u{2705}\u{2708}-\u{270D}\u{270F}]/gu;

    // Reusable validation rules
    const rules = {
        required: (value) => !!value || 'This field is required.',
        maxLength: (max) => (value) => !value || String(value).length <= max || `Maximum ${max} characters allowed.`,
        minLength: (min) => (value) => !value || String(value).length >= min || `Minimum ${min} characters required.`,
        email: (value) => !value || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value) || 'Please enter a valid email address.',
        phone: (value) => !value || /^(09|\+639)\d{9}$/.test(value) || 'Please enter a valid Philippine mobile number (e.g. 09123456789).',
        numeric: (value) => !value || !isNaN(Number(value)) || 'Please enter a valid number.',
        minValue: (min) => (value) => !value || Number(value) >= min || `Value must be at least ${min}.`,
        maxValue: (max) => (value) => !value || Number(value) <= max || `Value must be at most ${max}.`,
        noEmoji: (value) => !value || !emojiRegex.test(value) || 'Emojis are not allowed in this field.',
        alphaSpaces: (value) => !value || /^[a-zA-Z\s\.\-]+$/.test(value) || 'Only letters, spaces, hyphens, and periods are allowed.',
    };

    /**
     * Strip emojis from a string
     */
    const stripEmojis = (value) => {
        if (typeof value !== 'string') return value;
        return value.replace(emojiRegex, '').trim();
    };

    /**
     * Strip emojis from all string properties of an object, safely updating it in place.
     */
    const sanitizeForm = (formObj, options = {}) => {
        const exclude = options.exclude || [];

        Object.keys(formObj).forEach(key => {
            // Skip excluded keys completely
            if (exclude.includes(key)) return;

            const val = formObj[key];
            if (typeof val === 'string') {
                formObj[key] = stripEmojis(val);
            }
        });
    };

    /**
     * Validate a single field
     */
    const validateField = (fieldName, value, fieldRules) => {
        let fieldError = null;
        for (const rule of fieldRules) {
            const result = rule(value);
            if (result !== true && typeof result === 'string') {
                fieldError = result;
                break; // Stop at first error
            }
        }

        if (fieldError) {
            errors.value[fieldName] = fieldError;
            return false;
        } else {
            delete errors.value[fieldName];
            return true;
        }
    };

    /**
     * Validate entire form
     * validationsSchema: { fieldName: [rules.required, rules.maxLength(255)] }
     */
    const validateForm = (formObj, validationsSchema) => {
        errors.value = {}; // Reset previous errors
        let isValid = true;

        for (const [field, fieldRules] of Object.entries(validationsSchema)) {
            const value = formObj[field];
            const isFieldValid = validateField(field, value, fieldRules);
            if (!isFieldValid) isValid = false;
        }

        return isValid;
    };

    const clearErrors = () => {
        errors.value = {};
    };

    return {
        errors,
        rules,
        validateField,
        validateForm,
        sanitizeForm,
        clearErrors,
        stripEmojis
    };
}
