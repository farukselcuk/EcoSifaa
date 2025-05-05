import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import Login from './pages/Login';
import ProductList from './components/ProductList';
import ProductForm from './components/ProductForm';

const PrivateRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const { isAuthenticated } = useAuth();
    return isAuthenticated ? <>{children}</> : <Navigate to="/login" />;
};

const App: React.FC = () => {
    return (
        <AuthProvider>
            <Router>
                <Routes>
                    <Route path="/login" element={<Login />} />
                    <Route
                        path="/"
                        element={
                            <PrivateRoute>
                                <ProductList />
                            </PrivateRoute>
                        }
                    />
                    <Route
                        path="/products/new"
                        element={
                            <PrivateRoute>
                                <ProductForm />
                            </PrivateRoute>
                        }
                    />
                    <Route
                        path="/products/:id/edit"
                        element={
                            <PrivateRoute>
                                <ProductForm />
                            </PrivateRoute>
                        }
                    />
                </Routes>
            </Router>
        </AuthProvider>
    );
};

export default App; 