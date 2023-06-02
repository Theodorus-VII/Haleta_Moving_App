import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { PrismaService } from "src/prisma/prisma.service";

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy, 'jwt'){
    constructor(private config: ConfigService, private prisma: PrismaService){
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            ignoreExpiration: false,
            secretOrKey: config.get('JWT_SECRET')
        });
    }

    async validate(payload: {sub: number, email: string}){
        var user = await this.prisma.user.findUnique({
            where: {
                Id: payload.sub,
            }
        })
        var type;
        user = await this.prisma.user.findUnique({
            where: {
                Id: user.Id,
            }
        })
        // delete user.hash

        return {
            userId: user.Id,
            username: user.username,
            roles: user.role

        };
    }
}