"""
URL configuration for vocard project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('auth/', include('dj_rest_auth.urls')),
    path('auth/', include('allauth.urls')),
    path('auth/', include('authentication.urls'), name='auth'),
    path('words/', include('defaultword.urls'), name = 'word'),
    path('examples/', include('defaultwordexample.urls'), name='examples'),
    path('quiz/', include("defaultwordquiz.urls"), name = 'quiz'),
    path('img/', include('defaultwordimg.urls'), name='img'),
    path('user-example/', include('userexample.urls'), name='user_example'),
    path('user-stats/', include('user_stats.urls'), name='user_stats'),
    path('ai/', include('openai_api.urls'), name= 'openai_api')
]
