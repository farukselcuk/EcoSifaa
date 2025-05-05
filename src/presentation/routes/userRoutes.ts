import express from 'express';
import { MongoClient } from 'mongodb';

const router = express.Router();
const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017/ecosifaa';
const client = new MongoClient(uri);

router.get('/', async (req, res) => {
    try {
        await client.connect();
        const db = client.db();
        const usersCollection = db.collection('users');
        const users = await usersCollection.find({}).toArray();
        res.json(users);
    } catch (error) {
        console.error('Get users error:', error);
        res.status(500).json({ message: 'Bir hata oluştu!' });
    } finally {
        await client.close();
    }
});

export default router; 