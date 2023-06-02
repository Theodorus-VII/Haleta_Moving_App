import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { ROLES_KEY } from '../decorator/roles.decorator';
import { Role, User } from '@prisma/client';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (!requiredRoles){
        return true;
    }
    const req = context.switchToHttp().getRequest();
    const user = req.user
    console.log(user?.roles)
    return requiredRoles.some((role) => user?.roles?.includes(role)) || user?.roles?.includes(Role.ADMIN) || requiredRoles.length == 0;
  }
}
