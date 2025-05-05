import express from 'express';
import { MongoClient } from 'mongodb';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const router = express.Router();
const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017/ecosifaa';
const client = new MongoClient(uri);

router.post('/login', async (req, res) => {
    try {
        await client.connect();
        const db = client.db();
        const usersCollection = db.collection('users');

        const { email, password } = req.body;
        const user = await usersCollection.findOne({ email });

        if (!user) {
            return res.status(401).json({ message: 'E-posta veya şifre hatalı!' });
        }

        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            return res.status(401).json({ message: 'E-posta veya şifre hatalı!' });
        }

        const token = jwt.sign(
            { userId: user._id, email: user.email, role: user.role },
            'your-secret-key',
            { expiresIn: '1h' }
        );

        res.json({ token, user: { email: user.email, role: user.role } });
    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ message: 'Bir hata oluştu!' });
    } finally {
        await client.close();
    }
});

export default router; 