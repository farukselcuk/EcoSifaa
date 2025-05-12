import React from 'react';
import { View, Text, StyleSheet, Image, ScrollView, TouchableOpacity } from 'react-native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';

type RootStackParamList = {
  Home: undefined;
  Plants: undefined;
  Conditions: undefined;
  Profile: undefined;
};

type HomeScreenProps = {
  navigation: NativeStackNavigationProp<RootStackParamList, 'Home'>;
};

const popularPlants = [
  {
    name: 'Adaçayı',
    desc: 'Bağışıklık güçlendirici, sindirim dostu.',
    img: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=200&q=80',
  },
  {
    name: 'Ihlamur',
    desc: 'Soğuk algınlığı ve gripte destekleyici.',
    img: 'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?auto=format&fit=crop&w=200&q=80',
  },
  {
    name: 'Zencefil',
    desc: 'Mide bulantısına ve bağışıklığa iyi gelir.',
    img: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=200&q=80',
  },
];

const popularConditions = [
  {
    name: 'Soğuk Algınlığı',
    desc: 'Ihlamur, zencefil ve adaçayı ile doğal destek.',
  },
  {
    name: 'Bağışıklık Zayıflığı',
    desc: 'Adaçayı ve zencefil ile bağışıklık güçlendirme.',
  },
  {
    name: 'Sindirim Problemleri',
    desc: 'Zencefil ve adaçayı ile sindirim desteği.',
  },
];

export default function HomeScreen({ navigation }: HomeScreenProps) {
  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.logo}>🌿 EcoSifaa</Text>
        <Text style={styles.subtitle}>Şifalı Bitkiler Dünyasını Keşfedin</Text>
        <Text style={styles.description}>
          Doğal bitkilerle şifalanın faydalarını keşfederek günlük yaşamınızı daha sağlıklı hale getirin.
        </Text>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.primaryBtn} onPress={() => navigation.navigate('Plants')}>
            <Text style={styles.primaryBtnText}>Bitkileri Keşfet</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.secondaryBtn} onPress={() => navigation.navigate('Conditions')}>
            <Text style={styles.secondaryBtnText}>Rahatsızlıklar</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Popüler Bitkiler */}
      <Text style={styles.sectionTitle}>Popüler Şifalı Bitkiler</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.horizontalList}>
        {popularPlants.map((plant, idx) => (
          <View key={idx} style={styles.card}>
            <Image source={{ uri: plant.img }} style={styles.cardImage} />
            <Text style={styles.cardTitle}>{plant.name}</Text>
            <Text style={styles.cardDesc}>{plant.desc}</Text>
          </View>
        ))}
      </ScrollView>

      {/* Popüler Rahatsızlıklar */}
      <Text style={styles.sectionTitle}>Rahatsızlıklar</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.horizontalList}>
        {popularConditions.map((cond, idx) => (
          <View key={idx} style={styles.cardCond}>
            <Text style={styles.cardTitle}>{cond.name}</Text>
            <Text style={styles.cardDesc}>{cond.desc}</Text>
          </View>
        ))}
      </ScrollView>
    </ScrollView>
  );
}

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
  buttonRow: {
    flexDirection: 'row',
    gap: 12,
  },
  primaryBtn: {
    backgroundColor: '#fff',
    paddingVertical: 10,
    paddingHorizontal: 22,
    borderRadius: 25,
    marginRight: 8,
  },
  primaryBtnText: {
    color: '#2eae36',
    fontWeight: 'bold',
    fontSize: 16,
  },
  secondaryBtn: {
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: '#fff',
    paddingVertical: 10,
    paddingHorizontal: 22,
    borderRadius: 25,
  },
  secondaryBtnText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2eae36',
    marginTop: 32,
    marginLeft: 20,
    marginBottom: 12,
  },
  horizontalList: {
    paddingLeft: 16,
    marginBottom: 8,
  },
  card: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 16,
    marginRight: 16,
    width: 180,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOpacity: 0.08,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 2 },
    elevation: 2,
  },
  cardImage: {
    width: 120,
    height: 80,
    borderRadius: 8,
    marginBottom: 10,
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#2eae36',
    marginBottom: 4,
    textAlign: 'center',
  },
  cardDesc: {
    fontSize: 13,
    color: '#666',
    textAlign: 'center',
  },
  cardCond: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 16,
    marginRight: 16,
    width: 180,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOpacity: 0.08,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 2 },
    elevation: 2,
  },
}); 