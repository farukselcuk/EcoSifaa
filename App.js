import React from 'react';
import { Text, View, StyleSheet, ScrollView } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';

// Ana sekme navigasyonu
const Tab = createBottomTabNavigator();

// Ana Sayfa Bileşeni
function HomeScreen() {
  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.logo}>🌿 EcoSifaa</Text>
        <Text style={styles.subtitle}>Şifalı Bitkiler Dünyası</Text>
        <Text style={styles.description}>
          Doğal bitkilerle sağlıklı yaşam için yanınızdayız.
        </Text>
      </View>
      
      <Text style={styles.sectionTitle}>Popüler Bitkiler</Text>
      <View style={styles.card}>
        <Text style={styles.cardTitle}>Adaçayı</Text>
        <Text style={styles.cardDesc}>Bağışıklık güçlendirici, sindirim dostu bitki.</Text>
      </View>
      
      <View style={styles.card}>
        <Text style={styles.cardTitle}>Ihlamur</Text>
        <Text style={styles.cardDesc}>Soğuk algınlığı ve gripte destekleyici.</Text>
      </View>
      
      <View style={styles.card}>
        <Text style={styles.cardTitle}>Zencefil</Text>
        <Text style={styles.cardDesc}>Mide bulantısına ve bağışıklığa iyi gelir.</Text>
      </View>
    </ScrollView>
  );
}

// Bitkiler Bileşeni
function PlantsScreen() {
  return (
    <View style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.header2}>Şifalı Bitkiler</Text>
        <Text style={styles.subtitle2}>Doğanın şifa kaynakları</Text>
        
        <View style={styles.listItem}>
          <View style={styles.listContent}>
            <Text style={styles.listTitle}>Adaçayı</Text>
            <Text style={styles.listDesc}>Bağışıklık güçlendirici, sindirim dostu.</Text>
          </View>
        </View>
        
        <View style={styles.listItem}>
          <View style={styles.listContent}>
            <Text style={styles.listTitle}>Ihlamur</Text>
            <Text style={styles.listDesc}>Soğuk algınlığı ve gripte destekleyici.</Text>
          </View>
        </View>
        
        <View style={styles.listItem}>
          <View style={styles.listContent}>
            <Text style={styles.listTitle}>Zencefil</Text>
            <Text style={styles.listDesc}>Mide bulantısına ve bağışıklığa iyi gelir.</Text>
          </View>
        </View>
      </View>
    </View>
  );
}

// Rahatsızlıklar Bileşeni
function ConditionsScreen() {
  return (
    <View style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.header2}>Rahatsızlıklar</Text>
        <Text style={styles.subtitle2}>Bitkilerle doğal tedavi yöntemleri</Text>
        
        <View style={styles.listItem2}>
          <View style={styles.listIcon}>
            <Text style={styles.iconText}>S</Text>
          </View>
          <View style={styles.listContent}>
            <Text style={styles.listTitle}>Soğuk Algınlığı</Text>
            <Text style={styles.listDesc}>Ihlamur, zencefil ve adaçayı ile doğal destek.</Text>
          </View>
        </View>
        
        <View style={styles.listItem2}>
          <View style={styles.listIcon}>
            <Text style={styles.iconText}>B</Text>
          </View>
          <View style={styles.listContent}>
            <Text style={styles.listTitle}>Bağışıklık Zayıflığı</Text>
            <Text style={styles.listDesc}>Adaçayı ve zencefil ile bağışıklık güçlendirme.</Text>
          </View>
        </View>
        
        <View style={styles.listItem2}>
          <View style={styles.listIcon}>
            <Text style={styles.iconText}>S</Text>
          </View>
          <View style={styles.listContent}>
            <Text style={styles.listTitle}>Sindirim Problemleri</Text>
            <Text style={styles.listDesc}>Zencefil ve adaçayı ile sindirim desteği.</Text>
          </View>
        </View>
      </View>
    </View>
  );
}

// Profil Bileşeni
function ProfileScreen() {
  return (
    <View style={styles.profileContainer}>
      <View style={styles.profileHeader}>
        <View style={styles.avatarContainer}>
          <Text style={styles.avatarText}>OS</Text>
        </View>
        <Text style={styles.profileName}>Ömer Selçuk</Text>
        <Text style={styles.profileDesc}>EcoSifaa Kullanıcısı</Text>
      </View>
      
      <View style={styles.menuContainer}>
        <View style={styles.menuItem}>
          <Text style={styles.menuText}>Hesap Bilgileri</Text>
        </View>
        
        <View style={styles.menuItem}>
          <Text style={styles.menuText}>Favori Bitkilerim</Text>
        </View>
        
        <View style={styles.menuItem}>
          <Text style={styles.menuText}>Ayarlar</Text>
        </View>
        
        <View style={styles.menuItem}>
          <Text style={styles.menuText}>Çıkış Yap</Text>
        </View>
      </View>
    </View>
  );
}

// Ana Uygulama Bileşeni
export default function App() {
  return (
    <NavigationContainer>
      <Tab.Navigator
        screenOptions={({ route }) => ({
          tabBarIcon: ({ focused, color, size }) => {
            let iconName;

            if (route.name === 'Ana Sayfa') {
              iconName = focused ? 'home' : 'home-outline';
            } else if (route.name === 'Bitkiler') {
              iconName = focused ? 'leaf' : 'leaf-outline';
            } else if (route.name === 'Rahatsızlıklar') {
              iconName = focused ? 'medkit' : 'medkit-outline';
            } else if (route.name === 'Profil') {
              iconName = focused ? 'person' : 'person-outline';
            }

            // Varsayılan ikon eğer bir şey bulunamazsa
            return <Ionicons name={iconName || 'help-circle-outline'} size={size} color={color} />;
          },
          tabBarActiveTintColor: '#2eae36',
          tabBarInactiveTintColor: 'gray',
          headerStyle: {
            backgroundColor: '#2eae36',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        })}
      >
        <Tab.Screen name="Ana Sayfa" component={HomeScreen} />
        <Tab.Screen name="Bitkiler" component={PlantsScreen} />
        <Tab.Screen name="Rahatsızlıklar" component={ConditionsScreen} />
        <Tab.Screen name="Profil" component={ProfileScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}

// Stil Tanımları
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#2eae36',
    padding: 24,
    borderBottomLeftRadius: 24,
    borderBottomRightRadius: 24,
    alignItems: 'center',
  },
  logo: {
    color: '#fff',
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  subtitle: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
  },
  description: {
    color: '#e0ffe0',
    fontSize: 14,
    textAlign: 'center',
    marginBottom: 16,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2eae36',
    marginTop: 24,
    marginLeft: 20,
    marginBottom: 12,
  },
  card: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 16,
    marginHorizontal: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOpacity: 0.08,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 2 },
    elevation: 2,
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#2eae36',
    marginBottom: 4,
  },
  cardDesc: {
    fontSize: 13,
    color: '#666',
  },
  // Plants Screen
  content: {
    padding: 20,
  },
  header2: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#2eae36',
    marginBottom: 8,
  },
  subtitle2: {
    color: '#666',
    fontSize: 16,
    marginBottom: 24,
  },
  listItem: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 12,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 2 },
    elevation: 2,
  },
  listContent: {
    flex: 1,
    justifyContent: 'center',
  },
  listTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#2eae36',
    marginBottom: 4,
  },
  listDesc: {
    color: '#666',
    fontSize: 14,
  },
  listItem2: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 12,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 2 },
    elevation: 2,
  },
  listIcon: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: '#e0f5e0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  iconText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2eae36',
  },
  // Profile Screen
  profileContainer: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  profileHeader: {
    backgroundColor: '#2eae36',
    padding: 30,
    alignItems: 'center',
    borderBottomLeftRadius: 24,
    borderBottomRightRadius: 24,
  },
  avatarContainer: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#fff',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  avatarText: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#2eae36',
  },
  profileName: {
    fontSize: 22,
    fontWeight: 'bold',
    color: '#fff',
    marginBottom: 4,
  },
  profileDesc: {
    fontSize: 14,
    color: '#e0ffe0',
  },
  menuContainer: {
    paddingHorizontal: 16,
    paddingVertical: 24,
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 12,
    marginBottom: 12,
  },
  menuText: {
    fontSize: 16,
    color: '#333',
    marginLeft: 16,
  }
}); 