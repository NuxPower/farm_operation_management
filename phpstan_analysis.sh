#!/bin/bash
# Increase memory limit to 2GB and run PHPStan
php -d memory_limit=2G vendor/bin/phpstan analyse --error-format=table > phpstan_results.txt
echo "Analysis complete. Results saved to phpstan_results.txt"
