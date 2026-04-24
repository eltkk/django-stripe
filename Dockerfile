FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD python manage.py migrate && \
    python manage.py shell -c "
from django.contrib.auth import get_user_model
from store.models import Item
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
if not Item.objects.exists():
    Item.objects.create(name='Test Product', description='A sample product for testing Stripe integration.', price='9.99')
" && \
    gunicorn config.wsgi:application --bind 0.0.0.0:${PORT:-8000}
