from django.urls import path
from .views import parse_expression

urlpatterns = [
    path("api/parse/", parse_expression),
]
