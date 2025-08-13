from django.urls import path
from .views import parse_expression
from .views import three_operand
urlpatterns = [
    path("api/parse/", parse_expression),
    path("api/operand/", three_operand),
]
