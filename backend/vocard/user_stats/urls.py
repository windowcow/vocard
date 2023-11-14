from django.urls import path
from user_stats import views

urlpatterns = [
    path('<str:usr_id>/', views.user_stats_list),
    path('<str:usr_id>/<str:word>/', views.user_stats_detail),
]