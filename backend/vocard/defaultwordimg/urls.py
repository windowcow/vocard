from django.urls import path
from defaultwordimg import views

urlpatterns = [
    path('', views.default_img_list),
    path('<str:word>/', views.default_img_detail),
]