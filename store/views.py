import stripe
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render

from .models import Item

stripe.api_key = settings.STRIPE_SECRET_KEY


def item_detail(request, pk):
    item = get_object_or_404(Item, pk=pk)
    return render(request, 'store/item.html', {
        'item': item,
        'stripe_public_key': settings.STRIPE_PUBLIC_KEY,
    })


def buy_item(request, pk):
    item = get_object_or_404(Item, pk=pk)
    session = stripe.checkout.Session.create(
        payment_method_types=['card'],
        line_items=[{
            'price_data': {
                'currency': 'usd',
                'product_data': {'name': item.name},
                'unit_amount': item.get_price_cents(),
            },
            'quantity': 1,
        }],
        mode='payment',
        success_url=request.build_absolute_uri('/') + 'success/',
        cancel_url=request.build_absolute_uri('/') + 'cancel/',
    )
    return JsonResponse({'session_id': session.id})
