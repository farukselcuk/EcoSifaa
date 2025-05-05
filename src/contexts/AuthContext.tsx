import React, { createContext, useContext, useState, useEffect } from 'react';
import api from '../infrastructure/api';

interface AuthContextType {
    isAuthenticated: boolean;
    user: any | null;
    login: (email: string, password: string) => Promise<void>;
    logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [isAuthenticated, setIsAuthenticated] = useState(false);
    const [user, setUser] = useState<any | null>(null);

    useEffect(() => {
        const token = localStorage.getItem('token');
        if (token) {
            setIsAuthenticated(true);
            // Token'dan user bilgisini çıkar
            const userData = JSON.parse(atob(token.split('.')[1]));
            setUser(userData);
        }
    }, []);

    const login = async (email: string, password: string) => {
        try {
            const response = await api.post('/auth/login', { email, password });
            const { token, user } = response.data;
            localStorage.setItem('token', token);
            setIsAuthenticated(true);
            setUser(user);
        } catch (error) {
            throw new Error('Login failed');
        }
    };

    const logout = () => {
        localStorage.removeItem('token');
        setIsAuthenticated(false);
        setUser(null);
    };

    return (
        <AuthContext.Provider value={{ isAuthenticated, user, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => {
    const context = useContext(AuthContext);
    if (context === undefined) {
        throw new Error('useAuth must be used within an AuthProvider');
    }
    return context;
}; 