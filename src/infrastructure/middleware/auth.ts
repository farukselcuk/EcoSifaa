import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

export const authMiddleware = (req: Request, res: Response, next: NextFunction) => {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
        return res.status(401).json({ message: 'Yetkilendirme token\'ı bulunamadı' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
        (req as any).user = decoded;
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Geçersiz token' });
    }
}; 