import { MongoClient } from 'mongodb';
import bcrypt from 'bcryptjs';

async function seed() {
    const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017/ecosifaa';
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log('MongoDB bağlantısı başarılı!');

        const db = client.db();
        const usersCollection = db.collection('users');

        // Eski kullanıcıları temizle
        await usersCollection.deleteMany({});

        // Yeni admin kullanıcısı oluştur
        const hashedPassword = await bcrypt.hash('admin123', 10);
        const adminUser = {
            email: 'admin@alternatifsaglik.com',
            password: hashedPassword,
            name: 'Admin',
            role: 'ADMIN',
            createdAt: new Date()
        };

        await usersCollection.insertOne(adminUser);
        console.log('Admin kullanıcısı başarıyla oluşturuldu!');

    } catch (error) {
        console.error('Hata:', error);
    } finally {
        await client.close();
    }
}

seed(); 