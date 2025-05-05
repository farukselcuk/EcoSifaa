import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import Login from './presentation/pages/Login';
import ProductList from './presentation/components/ProductList';
import ProductForm from './presentation/components/ProductForm';
import PrivateRoute from './infrastructure/middleware/PrivateRoute';

const App: React.FC = () => {
    return (
        <AuthProvider>
            <Router>
                <Routes>
                    <Route path="/login" element={<Login />} />
                    <Route path="/" element={<PrivateRoute><ProductList /></PrivateRoute>} />
                    <Route path="/products/new" element={<PrivateRoute><ProductForm /></PrivateRoute>} />
                    <Route path="/products/:id/edit" element={<PrivateRoute><ProductForm /></PrivateRoute>} />
                    <Route path="*" element={<Navigate to="/" replace />} />
                </Routes>
            </Router>
        </AuthProvider>
    );
};

export default App; 