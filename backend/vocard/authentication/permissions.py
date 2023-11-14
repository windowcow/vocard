from rest_framework import permissions

class IsOwnerOnly(permissions.BasePermission):
    def has_permission(self, request, view, obj):
        print(obj)
        return obj.nickname == request.user