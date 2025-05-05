import { Request, Response } from 'express';
import jwt from 'jsonwebtoken';

export class AuthController {
    private readonly JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

    async login(req: Request, res: Response): Promise<void> {
        const { email, password } = req.body;

        // Burada gerçek bir kullanıcı doğrulama işlemi yapılmalı
        // Şimdilik basit bir kontrol yapıyoruz
        if (email === 'admin@ecosifaa.com' && password === 'admin123') {
            const token = jwt.sign({ email }, this.JWT_SECRET, { expiresIn: '1h' });
            res.json({ token });
        } else {
            res.status(401).json({ message: 'Geçersiz email veya şifre' });
        }
    }
} 