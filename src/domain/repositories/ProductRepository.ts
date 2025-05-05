import { Product } from '../entities/Product';

export interface ProductRepository {
    findAll(): Promise<Product[]>;
    findById(id: number): Promise<Product | null>;
    findByCategory(category: string): Promise<Product[]>;
    create(product: Omit<Product, 'id' | 'createdAt' | 'updatedAt'>): Promise<Product>;
    update(id: number, product: Partial<Omit<Product, 'id' | 'createdAt' | 'updatedAt'>>): Promise<Product>;
    delete(id: number): Promise<void>;
} 