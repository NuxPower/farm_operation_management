#!/bin/bash

# Check if an email address was provided
if [ -z "$1" ]; then
    echo "Usage: ./run_test_email.sh <email_address>"
    echo "Example: ./run_test_email.sh hanyunikul@gmail.com"
    exit 1
fi

EMAIL=$1

echo "Sending test emails to $EMAIL..."
echo "This will send ONE of each notification type."

# Run the artisan command
php artisan email:test "$EMAIL"
