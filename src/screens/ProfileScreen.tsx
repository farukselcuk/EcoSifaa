import React from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';

export default function ProfileScreen() {
  return (
    <ScrollView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.title}>Profil</Text>
        <Text style={styles.subtitle}>Yakında burada profil bilgileri olacak...</Text>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  content: {
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    color: '#2E7D32',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
  },
}); 