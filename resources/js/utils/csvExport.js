/**
 * CSV Export Utility for Farm Reports
 * Generates CSV files client-side
 */
export const csvExport = {
    /**
     * Convert array of objects to CSV string
     * @param {Array} data - Array of objects
     * @param {Array} headers - Array of header labels
     * @param {Array} fields - Array of field keys corresponding to headers
     * @returns {string} CSV string
     */
    toCSV(data, headers, fields) {
        if (!data || !data.length) {
            return '';
        }

        const csvRows = [];

        // Add headers
        csvRows.push(headers.join(','));

        // Add data
        for (const row of data) {
            const values = fields.map(field => {
                const val = row[field];
                // Handle null/undefined
                if (val === null || val === undefined) return '';
                // Escape quotes and wrap in quotes if contains comma
                const stringVal = String(val);
                if (stringVal.includes(',') || stringVal.includes('"') || stringVal.includes('\n')) {
                    return `"${stringVal.replace(/"/g, '""')}"`;
                }
                return stringVal;
            });
            csvRows.push(values.join(','));
        }

        return csvRows.join('\n');
    },

    /**
     * Trigger download of CSV string
     * @param {string} csvContent 
     * @param {string} filename 
     */
    downloadCSV(csvContent, filename) {
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        if (link.download !== undefined) {
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', filename);
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    },

    /**
     * Export Financial Report to CSV
     */
    exportFinancialReport(data, options = {}) {
        const { title = 'Financial Report' } = options;

        // Flatten data for CSV
        // For financial report, we might want two sections or just the detailed expenses
        // Let's export the expenses by category list as the main tabular data

        const headers = ['Category', 'Amount', 'Percentage'];
        const fields = ['category', 'amount', 'percentage'];

        const csvContent = this.toCSV(data.expensesByCategory, headers, fields);

        // Prepend summary lines
        const summary = [
            `Report: ${title}`,
            `Generated: ${new Date().toLocaleDateString()}`,
            `Total Revenue: ${data.totalRevenue}`,
            `Total Expenses: ${data.totalExpenses}`,
            `Net Profit: ${data.netProfit}`,
            '',
            'Detailed Expenses:'
        ].join('\n') + '\n';

        this.downloadCSV(summary + csvContent, `${title.replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.csv`);
    },

    /**
     * Export Crop Yield Report to CSV
     */
    exportCropYieldReport(data, options = {}) {
        const { title = 'Crop Yield Report' } = options;

        const headers = ['Date', 'Field', 'Variety', 'Yield (kg)', 'Quality'];
        const fields = ['harvest_date', 'field_name', 'variety_name', 'yield', 'quality_grade'];

        const csvContent = this.toCSV(data.harvests, headers, fields);

        const summary = [
            `Report: ${title}`,
            `Generated: ${new Date().toLocaleDateString()}`,
            `Total Harvests: ${data.totalHarvests}`,
            `Total Yield: ${data.totalYield} kg`,
            `Avg Yield/Ha: ${data.avgYieldPerHa} kg/ha`,
            '',
            'Harvest Records:'
        ].join('\n') + '\n';

        this.downloadCSV(summary + csvContent, `${title.replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.csv`);
    },

    /**
     * Export Weather Report to CSV
     */
    exportWeatherReport(data, options = {}) {
        const { title = 'Weather Report', fieldName = 'All Fields' } = options;

        // For weather, we might not have list data in the same way, but let's assume we might export history if available
        // If not, we export the summary metrics

        const summary = [
            `Report: ${title}`,
            `Field: ${fieldName}`,
            `Generated: ${new Date().toLocaleDateString()}`,
            '',
            'Current Conditions:',
            `Temperature: ${data.current?.temperature || 'N/A'} C`,
            `Humidity: ${data.current?.humidity || 'N/A'} %`,
            `Wind Speed: ${data.current?.wind_speed || 'N/A'} km/h`,
            `Conditions: ${data.current?.conditions || 'N/A'}`,
            '',
            'GDD Summary:',
            `Total GDD: ${data.gdd?.total || 0}`,
            `Weekly Avg GDD: ${data.gdd?.weekly_avg || 0}`
        ].join('\n');

        this.downloadCSV(summary, `${title.replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.csv`);
    },

    /**
     * Generic table export
     */
    exportTable(data, options = {}) {
        const { title = 'Export', headers = [], fields = [] } = options;
        const csvContent = this.toCSV(data, headers, fields);
        this.downloadCSV(csvContent, `${title.replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.csv`);
    }
};

export default csvExport;
