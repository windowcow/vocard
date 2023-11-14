from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User

class CustomUserAdmin(UserAdmin):
    readonly_fields = ['acc_created', 'last_sync']
    list_display = ('oauth_id', 'nickname', 'is_staff', 'is_superuser', 'acc_created', 'last_sync', 'total_studied', 'latest_studied')
    list_filter = ('is_staff', 'is_superuser', 'acc_created')
    fieldsets = (
        (None, {'fields': ('oauth_id', 'password')}),
        ('Personal info', {'fields': ('nickname', 'usr_id')}),
        ('Permissions', {'fields': ('is_superuser', 'is_staff')}),
        ('Study details', {'fields': ('total_studied', 'latest_studied')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('oauth_id', 'nickname', 'password1', 'password2'),
        }),
    )
    search_fields = ('oauth_id', 'nickname')
    ordering = ('acc_created',)
    filter_horizontal = ()

# Register your models here.
admin.site.register(User, CustomUserAdmin)
