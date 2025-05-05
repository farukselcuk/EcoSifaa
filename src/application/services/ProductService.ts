import { Product } from '../../domain/entities/Product';
import { ProductRepository } from '../../domain/repositories/ProductRepository';

export class ProductService {
    constructor(private productRepository: ProductRepository) {}

    async getAllProducts(): Promise<Product[]> {
        return this.productRepository.findAll();
    }

    async getProduct(id: string): Promise<Product | null> {
        return this.productRepository.findById(id);
    }

    async getProductsByCategory(category: string): Promise<Product[]> {
        return this.productRepository.findByCategory(category);
    }

    async createProduct(product: Omit<Product, 'id' | 'createdAt' | 'updatedAt' | 'updateStock' | 'updatePrice'>): Promise<Product> {
        return this.productRepository.create(product);
    }

    async updateProduct(id: string, product: Partial<Omit<Product, 'id' | 'createdAt' | 'updatedAt' | 'updateStock' | 'updatePrice'>>): Promise<Product> {
        return this.productRepository.update(id, product);
    }

    async deleteProduct(id: string): Promise<void> {
        await this.productRepository.delete(id);
    }
} 