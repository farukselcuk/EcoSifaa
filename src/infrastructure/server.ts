import express from 'express';
import cors from 'cors';
import { MongoClient } from 'mongodb';
import authRoutes from '../presentation/routes/authRoutes';
import userRoutes from '../presentation/routes/userRoutes';

const app = express();
const port = 3001;

app.use(cors());
app.use(express.json());

// MongoDB bağlantısı
const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017/ecosifaa';
const client = new MongoClient(uri);

async function connectDB() {
    try {
        await client.connect();
        console.log('MongoDB bağlantısı başarılı!');
    } catch (error) {
        console.error('MongoDB bağlantı hatası:', error);
    }
}

connectDB();

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
}); 