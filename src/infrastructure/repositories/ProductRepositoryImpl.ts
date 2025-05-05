import { PrismaClient } from '@prisma/client';
import { Product } from '../../domain/entities/Product';
import { ProductRepository } from '../../domain/repositories/ProductRepository';

export class ProductRepositoryImpl implements ProductRepository {
    private prisma: PrismaClient;

    constructor() {
        this.prisma = new PrismaClient();
    }

    async findAll(): Promise<Product[]> {
        return this.prisma.product.findMany();
    }

    async findById(id: number): Promise<Product | null> {
        return this.prisma.product.findUnique({
            where: { id },
        });
    }

    async findByCategory(category: string): Promise<Product[]> {
        return this.prisma.product.findMany({
            where: { category },
        });
    }

    async create(product: Omit<Product, 'id' | 'createdAt' | 'updatedAt'>): Promise<Product> {
        return this.prisma.product.create({
            data: product,
        });
    }

    async update(id: number, product: Partial<Omit<Product, 'id' | 'createdAt' | 'updatedAt'>>): Promise<Product> {
        return this.prisma.product.update({
            where: { id },
            data: product,
        });
    }

    async delete(id: number): Promise<void> {
        await this.prisma.product.delete({
            where: { id },
        });
    }
} 