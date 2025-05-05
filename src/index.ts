import express from 'express';
import { ProductController } from './presentation/controllers/ProductController';
import { ProductService } from './application/services/ProductService';
import { ProductRepositoryImpl } from './infrastructure/repositories/ProductRepositoryImpl';
import { AuthController } from './presentation/controllers/AuthController';
import { authMiddleware } from './infrastructure/middleware/auth';
import cors from 'cors';

const app = express();
app.use(express.json());
app.use(cors());

// Dependency injection
const productRepository = new ProductRepositoryImpl();
const productService = new ProductService(productRepository);
const productController = new ProductController(productService);
const authController = new AuthController();

// Auth routes
app.post('/api/auth/login', (req, res) => authController.login(req, res));

// Product routes (protected)
app.get('/api/products', authMiddleware, (req, res) => productController.getAllProducts(req, res));
app.get('/api/products/:id', authMiddleware, (req, res) => productController.getProduct(req, res));
app.post('/api/products', authMiddleware, (req, res) => productController.createProduct(req, res));
app.put('/api/products/:id', authMiddleware, (req, res) => productController.updateProduct(req, res));
app.delete('/api/products/:id', authMiddleware, (req, res) => productController.deleteProduct(req, res));
app.get('/api/products/category/:category', authMiddleware, (req, res) => productController.getProductsByCategory(req, res));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
}); 