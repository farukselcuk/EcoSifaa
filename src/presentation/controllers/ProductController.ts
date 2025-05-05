import { Request, Response } from 'express';
import { ProductService } from '../../application/services/ProductService';

export class ProductController {
    constructor(private productService: ProductService) {}

    async getAllProducts(req: Request, res: Response): Promise<void> {
        try {
            const products = await this.productService.getAllProducts();
            res.json(products);
        } catch (error) {
            res.status(500).json({ message: 'Error fetching products' });
        }
    }

    async getProduct(req: Request, res: Response): Promise<void> {
        try {
            const id = req.params.id;
            const product = await this.productService.getProduct(id);
            if (product) {
                res.json(product);
            } else {
                res.status(404).json({ message: 'Product not found' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error fetching product' });
        }
    }

    async getProductsByCategory(req: Request, res: Response): Promise<void> {
        try {
            const { category } = req.params;
            const products = await this.productService.getProductsByCategory(category);
            res.json(products);
        } catch (error) {
            res.status(500).json({ message: 'Error fetching products by category' });
        }
    }

    async createProduct(req: Request, res: Response): Promise<void> {
        try {
            const product = await this.productService.createProduct(req.body);
            res.status(201).json(product);
        } catch (error) {
            res.status(500).json({ message: 'Error creating product' });
        }
    }

    async updateProduct(req: Request, res: Response): Promise<void> {
        try {
            const id = req.params.id;
            const product = await this.productService.updateProduct(id, req.body);
            res.json(product);
        } catch (error) {
            res.status(500).json({ message: 'Error updating product' });
        }
    }

    async deleteProduct(req: Request, res: Response): Promise<void> {
        try {
            const id = req.params.id;
            await this.productService.deleteProduct(id);
            res.status(204).send();
        } catch (error) {
            res.status(500).json({ message: 'Error deleting product' });
        }
    }
} 