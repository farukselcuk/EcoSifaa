import { PrismaClient } from '@prisma/client';
import { Product } from '../../domain/entities/Product';
import { ProductRepository } from '../../domain/repositories/ProductRepository';

export class ProductRepositoryImpl implements ProductRepository {
    private prisma: PrismaClient;

    constructor() {
        this.prisma = new PrismaClient();
    }

    private mapToProduct(data: any): Product {
        return {
            ...data,
            updateStock: (quantity: number) => {
                this.prisma.product.update({
                    where: { id: data.id },
                    data: { stock: quantity }
                });
            },
            updatePrice: (newPrice: number) => {
                this.prisma.product.update({
                    where: { id: data.id },
                    data: { price: newPrice }
                });
            }
        };
    }

    async findAll(): Promise<Product[]> {
        const products = await this.prisma.product.findMany();
        return products.map(this.mapToProduct);
    }

    async findById(id: string): Promise<Product | null> {
        const product = await this.prisma.product.findUnique({
            where: { id }
        });
        return product ? this.mapToProduct(product) : null;
    }

    async findByCategory(category: string): Promise<Product[]> {
        const products = await this.prisma.product.findMany({
            where: { category }
        });
        return products.map(this.mapToProduct);
    }

    async create(product: Omit<Product, 'id' | 'createdAt' | 'updatedAt' | 'updateStock' | 'updatePrice'>): Promise<Product> {
        const created = await this.prisma.product.create({
            data: product
        });
        return this.mapToProduct(created);
    }

    async update(id: string, product: Partial<Omit<Product, 'id' | 'createdAt' | 'updatedAt' | 'updateStock' | 'updatePrice'>>): Promise<Product> {
        const updated = await this.prisma.product.update({
            where: { id },
            data: product
        });
        return this.mapToProduct(updated);
    }

    async delete(id: string): Promise<void> {
        await this.prisma.product.delete({
            where: { id }
        });
    }
} 