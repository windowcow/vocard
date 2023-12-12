from django.urls import path
from authentication import views
from authentication.views import KakaoLogin, UserList, UserRetrieve, UserDestroy
from rest_framework_simplejwt.views import TokenRefreshView

urlpatterns = [
    path('users/', UserList.as_view(), name='user_list'),
    path('users/<str:pk>/', UserRetrieve.as_view(), name='user_detail'),
    path('users/remove/<str:pk>/', UserDestroy.as_view(), name='user_remove'),
    path('kakao/login/', views.kakao_login, name = 'kakao_login'),
    path('kakao/callback/', views.kakao_callback, name='kakao_callback'),
    path('kakao/login/finish/', KakaoLogin.as_view(), name="kakao_login_todjango"),
    # path('refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]