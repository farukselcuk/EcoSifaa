import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import HomeScreen from './src/screens/HomeScreen';
import PlantsScreen from './src/screens/PlantsScreen';
import ConditionsScreen from './src/screens/ConditionsScreen';
import ProfileScreen from './src/screens/ProfileScreen';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator 
        initialRouteName="Home" 
        screenOptions={{ 
          headerShown: true,
          headerStyle: {
            backgroundColor: '#4CAF50',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        }}
      >
        <Stack.Screen 
          name="Home" 
          component={HomeScreen} 
          options={{ title: 'EcoSifaa' }}
        />
        <Stack.Screen 
          name="Plants" 
          component={PlantsScreen} 
          options={{ title: 'Bitkiler' }}
        />
        <Stack.Screen 
          name="Conditions" 
          component={ConditionsScreen} 
          options={{ title: 'Rahatsızlıklar' }}
        />
        <Stack.Screen 
          name="Profile" 
          component={ProfileScreen} 
          options={{ title: 'Profil' }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
} 