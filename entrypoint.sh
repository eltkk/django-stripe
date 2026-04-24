#!/bin/sh
python manage.py migrate
python manage.py shell -c "
import os
from django.contrib.auth import get_user_model
from store.models import Item
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', os.environ.get('DJANGO_ADMIN_PASSWORD', 'changeme'))
if not Item.objects.exists():
    Item.objects.create(name='Test Product', description='A sample product for testing Stripe integration.', price='9.99')
"
exec gunicorn config.wsgi:application --bind 0.0.0.0:${PORT:-8000}
