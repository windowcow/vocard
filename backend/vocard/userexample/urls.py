from django.urls import path
from userexample import views

urlpatterns = [
    path('<str:usr_id>/', views.user_example_list),
    path('<str:usr_id>/<str:word>/', views.user_example_detail),
]