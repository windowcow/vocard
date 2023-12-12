from django.urls import path
from defaultwordquiz import views

urlpatterns = [
    path('<int:num>/', views.default_quiz_list),
    path('<int:num>/<str:word>/', views.default_quiz_detail),
]