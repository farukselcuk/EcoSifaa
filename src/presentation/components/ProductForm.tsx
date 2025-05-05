import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import api from '../../infrastructure/api';
import { Product } from '../../domain/entities/Product';

type ProductFormData = Omit<Product, 'id' | 'createdAt' | 'updatedAt'>;

const ProductForm: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const navigate = useNavigate();
    const [product, setProduct] = useState<ProductFormData>({
        name: '',
        description: '',
        price: 0,
        category: '',
    });
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');

    useEffect(() => {
        if (id) {
            const fetchProduct = async () => {
                try {
                    const response = await api.get(`/products/${id}`);
                    const { id: _, createdAt, updatedAt, ...productData } = response.data;
                    setProduct(productData);
                } catch (err) {
                    setError('Failed to fetch product');
                }
            };
            fetchProduct();
        }
    }, [id]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            if (id) {
                await api.put(`/products/${id}`, product);
            } else {
                await api.post('/products', product);
            }
            navigate('/');
        } catch (err) {
            setError('Failed to save product');
            setLoading(false);
        }
    };

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>
    ) => {
        const { name, value } = e.target;
        setProduct((prev) => ({
            ...prev,
            [name]: name === 'price' ? parseFloat(value) : value,
        }));
    };

    return (
        <div className="container mx-auto px-4 py-8">
            <h1 className="text-2xl font-bold mb-6">
                {id ? 'Edit Product' : 'Add Product'}
            </h1>
            {error && <div className="text-red-500 mb-4">{error}</div>}
            <form onSubmit={handleSubmit} className="max-w-lg">
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2">
                        Name
                    </label>
                    <input
                        type="text"
                        name="name"
                        value={product.name}
                        onChange={handleChange}
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        required
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2">
                        Description
                    </label>
                    <textarea
                        name="description"
                        value={product.description}
                        onChange={handleChange}
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        required
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2">
                        Price
                    </label>
                    <input
                        type="number"
                        name="price"
                        value={product.price}
                        onChange={handleChange}
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        required
                        min="0"
                        step="0.01"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2">
                        Category
                    </label>
                    <select
                        name="category"
                        value={product.category}
                        onChange={handleChange}
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        required
                    >
                        <option value="">Select a category</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Clothing">Clothing</option>
                        <option value="Books">Books</option>
                        <option value="Home">Home</option>
                    </select>
                </div>
                <div className="flex items-center justify-between">
                    <button
                        type="submit"
                        disabled={loading}
                        className="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                    >
                        {loading ? 'Saving...' : 'Save'}
                    </button>
                    <button
                        type="button"
                        onClick={() => navigate('/')}
                        className="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
                    >
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    );
};

export default ProductForm; 