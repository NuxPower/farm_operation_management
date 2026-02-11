#!/bin/sh

cd /var/www/html

# Create an empty .env if none exists.
# Laravel will read environment variables directly from the system,
# which Railway sets via its dashboard.
if [ ! -f .env ]; then
    echo "No .env file found, creating empty .env (using system environment variables)..."
    touch .env
fi

# Generate application key if not set
if [ -z "$APP_KEY" ]; then
    php artisan key:generate --force
fi

# Create storage link if it doesn't exist
php artisan storage:link --force 2>/dev/null || true

# Cache configuration, routes, and events
php artisan config:cache || echo "Warning: config:cache failed"
php artisan route:cache || echo "Warning: route:cache failed"
php artisan view:cache || echo "Warning: view:cache failed"
php artisan event:cache || echo "Warning: event:cache failed"

# Run migrations (skip errors for existing tables)
php artisan migrate --force 2>/dev/null || echo "Warning: migrate skipped (tables may already exist)"

# Configure Nginx PORT - Railway sets PORT env var
LISTEN_PORT=${PORT:-8080}
echo "==> Configuring nginx to listen on port: $LISTEN_PORT"
sed -i "s/listen 8080;/listen $LISTEN_PORT default_server;/g" /etc/nginx/sites-available/default

# Verify nginx config
echo "==> Testing nginx configuration..."
nginx -t 2>&1

echo "==> Starting supervisord..."

# Start Supervisor (nginx + php-fpm)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
