from django.urls import path
from defaultwordexample import views

urlpatterns = [
    path('', views.default_example_list),
    path('<str:word>/', views.default_example_detail),
]