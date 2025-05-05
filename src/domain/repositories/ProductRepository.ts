import { Product } from '../entities/Product';

export interface ProductRepository {
    findAll(): Promise<Product[]>;
    findById(id: string): Promise<Product | null>;
    findByCategory(category: string): Promise<Product[]>;
    create(product: Omit<Product, 'id' | 'createdAt' | 'updatedAt' | 'updateStock' | 'updatePrice'>): Promise<Product>;
    update(id: string, product: Partial<Omit<Product, 'id' | 'createdAt' | 'updatedAt' | 'updateStock' | 'updatePrice'>>): Promise<Product>;
    delete(id: string): Promise<void>;
} 