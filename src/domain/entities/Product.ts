export interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    category: string;
    createdAt: Date;
    updatedAt: Date;
}

export class Product {
    constructor(
        public id: string,
        public name: string,
        public description: string,
        public price: number,
        public stock: number,
        public category: string,
        public imageUrl: string,
        public createdAt: Date,
        public updatedAt: Date
    ) {}

    updateStock(quantity: number): void {
        if (this.stock + quantity < 0) {
            throw new Error('Insufficient stock');
        }
        this.stock += quantity;
    }

    updatePrice(newPrice: number): void {
        if (newPrice < 0) {
            throw new Error('Price cannot be negative');
        }
        this.price = newPrice;
    }
} 