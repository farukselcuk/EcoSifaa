import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../../infrastructure/api';
import { Product } from '../../domain/entities/Product';

const ProductList: React.FC = () => {
    const [products, setProducts] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    useEffect(() => {
        const fetchProducts = async () => {
            try {
                const response = await api.get('/products');
                setProducts(response.data);
                setLoading(false);
            } catch (err) {
                setError('Failed to fetch products');
                setLoading(false);
            }
        };

        fetchProducts();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>{error}</div>;

    return (
        <div className="container mx-auto px-4 py-8">
            <div className="flex justify-between items-center mb-6">
                <h1 className="text-2xl font-bold">Products</h1>
                <Link
                    to="/products/new"
                    className="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700"
                >
                    Add Product
                </Link>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {products.map((product) => (
                    <div
                        key={product.id}
                        className="border rounded-lg p-4 hover:shadow-lg transition-shadow"
                    >
                        <h2 className="text-xl font-semibold mb-2">{product.name}</h2>
                        <p className="text-gray-600 mb-2">{product.description}</p>
                        <p className="text-indigo-600 font-bold mb-2">${product.price}</p>
                        <p className="text-sm text-gray-500 mb-4">{product.category}</p>
                        <Link
                            to={`/products/${product.id}/edit`}
                            className="text-indigo-600 hover:text-indigo-800"
                        >
                            Edit
                        </Link>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default ProductList; 