from django.urls import path
from defaultword import views

urlpatterns = [
    path('', views.default_word_list),
    path('<str:word>/', views.default_word_detail),
]