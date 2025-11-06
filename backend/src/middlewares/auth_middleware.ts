import {NextFunction, Request, Response} from 'express';
import jwt from "jsonwebtoken";

export interface AuthRequest extends Request {
    user?: {
        id: string;
        email: string;
        role: any;
    };
}

export const authMiddleware = (req: AuthRequest, res: Response, next: NextFunction) => {
    const token = req.headers['authorization']?.split(' ')[1];
    if (!token) {
        return res.status(401).json({ success: false, message: "Unauthorized - no token provided" });
    }

    try {
        const user = jwt.verify(token, process.env.JWT_SECRET!) as { id: string; email: string; role: any };
        req.user = user;
        next();
    } catch (error) {
        return res.status(401).json({ success: false, message: "Unauthorized - invalid token" });
    }
};

