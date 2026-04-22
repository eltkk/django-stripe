# Django Stripe Integration

A Django application for selling items with Stripe Checkout.

## Features

- Browse items with name, description and price
- Buy items via Stripe Checkout
- Django Admin panel for managing items

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/eltkk/django-stripe.git
cd django-stripe
```

### 2. Create a virtual environment and install dependencies

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Configure environment variables

Copy `.env` and fill in your Stripe keys:

```bash
cp .env .env.local
```

Edit `.env` with your actual values:

```
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLIC_KEY=pk_test_...
DJANGO_SECRET_KEY=your-secret-key
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
```

Get your Stripe API keys from [https://dashboard.stripe.com/apikeys](https://dashboard.stripe.com/apikeys).

### 4. Run migrations

```bash
python manage.py migrate
```

### 5. Create a superuser for Admin

```bash
python manage.py createsuperuser
```

### 6. Run the development server

```bash
python manage.py runserver
```

Open [http://localhost:8000/admin/](http://localhost:8000/admin/) to add items via the admin panel.

Then visit [http://localhost:8000/item/1/](http://localhost:8000/item/1/) to see an item page.

## API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/item/<id>/` | Item detail page with Buy button |
| GET | `/buy/<id>/` | Returns Stripe Checkout session ID as JSON |
| GET | `/admin/` | Django Admin panel |

## Docker Deployment

### Build and run

```bash
docker build -t django-stripe .
docker run -p 8000:8000 --env-file .env django-stripe
```

### Run migrations inside container

```bash
docker run --env-file .env django-stripe python manage.py migrate
docker run --env-file .env django-stripe python manage.py createsuperuser
```

## Project Structure

```
django-stripe/
├── config/              # Django project settings
│   ├── settings.py
│   ├── urls.py
│   ├── wsgi.py
│   └── asgi.py
├── store/               # Main application
│   ├── migrations/
│   ├── templates/
│   │   └── store/
│   │       └── item.html
│   ├── admin.py
│   ├── apps.py
│   ├── models.py
│   ├── urls.py
│   └── views.py
├── manage.py
├── requirements.txt
├── Dockerfile
└── .env
```
