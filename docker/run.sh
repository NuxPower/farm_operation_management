#!/bin/sh

cd /var/www/html

# Generate .env from environment variables if no .env file exists
if [ ! -f .env ]; then
    echo "No .env file found, generating from environment variables..."
    env | grep -E '^(APP_|DB_|MAIL_|LOG_|CACHE_|SESSION_|QUEUE_|REDIS_|BROADCAST_|FILESYSTEM_|SANCTUM_|TRUSTED_|VITE_|AWS_|PUSHER_)' | sort > .env
    # Ensure APP_KEY is set
    if [ -n "$APP_KEY" ]; then
        grep -q "^APP_KEY=" .env || echo "APP_KEY=$APP_KEY" >> .env
    fi
fi

# Generate application key if not set
if ! grep -q "^APP_KEY=base64:" .env 2>/dev/null; then
    if [ -z "$APP_KEY" ]; then
        php artisan key:generate --force
    fi
fi

# Create storage link if it doesn't exist
php artisan storage:link --force 2>/dev/null || true

# Cache configuration, routes, and events
php artisan config:cache || echo "Warning: config:cache failed"
php artisan route:cache || echo "Warning: route:cache failed"
php artisan view:cache || echo "Warning: view:cache failed"
php artisan event:cache || echo "Warning: event:cache failed"

# Run migrations automatically
php artisan migrate --force || echo "Warning: migrate failed"

# Configure Nginx PORT
sed -i "s/listen 8080;/listen ${PORT:-8080};/g" /etc/nginx/sites-available/default

# Start Supervisor (nginx + php-fpm)
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
