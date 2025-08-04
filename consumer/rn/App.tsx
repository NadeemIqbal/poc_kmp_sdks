import React, { useEffect, useState } from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
} from 'react-native';
import { KmpSharedSdk, User, Product } from 'kmp-shared-sdk-rn';

const App: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const sdk = new KmpSharedSdk();

  useEffect(() => {
    initializeSDK();
  }, []);

  const initializeSDK = async () => {
    try {
      await sdk.initialize();
      await loadData();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    }
  };

  const loadData = async () => {
    setIsLoading(true);
    setError(null);

    try {
      const [fetchedUsers, fetchedProducts] = await Promise.all([
        sdk.getUsers(),
        sdk.getProducts(),
      ]);

      setUsers(fetchedUsers);
      setProducts(fetchedProducts);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load data');
    } finally {
      setIsLoading(false);
    }
  };

  const showUserDetails = (user: User) => {
    Alert.alert(
      user.name,
      `Email: ${user.email}\nID: ${user.id}`,
      [{ text: 'OK' }]
    );
  };

  const showProductDetails = (product: Product) => {
    Alert.alert(
      product.title,
      `Description: ${product.description}\nPrice: $${product.price.toFixed(2)}\nID: ${product.id}`,
      [{ text: 'OK' }]
    );
  };

  const renderUserItem = (user: User, index: number) => (
    <TouchableOpacity
      key={user.id}
      style={styles.card}
      onPress={() => showUserDetails(user)}
    >
      <View style={styles.cardHeader}>
        <View style={styles.userIcon}>
          <Text style={styles.iconText}>👤</Text>
        </View>
        <View style={styles.cardContent}>
          <Text style={styles.cardTitle}>{user.name}</Text>
          <Text style={styles.cardSubtitle}>{user.email}</Text>
          <Text style={styles.cardId}>ID: {user.id}</Text>
        </View>
      </View>
    </TouchableOpacity>
  );

  const renderProductItem = (product: Product, index: number) => (
    <TouchableOpacity
      key={product.id}
      style={styles.card}
      onPress={() => showProductDetails(product)}
    >
      <View style={styles.cardHeader}>
        <View style={styles.productIcon}>
          <Text style={styles.iconText}>🛒</Text>
        </View>
        <View style={styles.cardContent}>
          <Text style={styles.cardTitle}>{product.title}</Text>
          <Text style={styles.cardSubtitle} numberOfLines={2}>
            {product.description}
          </Text>
          <View style={styles.cardFooter}>
            <Text style={styles.cardId}>ID: {product.id}</Text>
            <Text style={styles.cardPrice}>${product.price.toFixed(2)}</Text>
          </View>
        </View>
      </View>
    </TouchableOpacity>
  );

  const renderContent = () => {
    if (isLoading) {
      return (
        <View style={styles.centered}>
          <ActivityIndicator size="large" color="#007AFF" />
          <Text style={styles.loadingText}>Loading...</Text>
        </View>
      );
    }

    if (error) {
      return (
        <View style={styles.centered}>
          <Text style={styles.errorText}>Error: {error}</Text>
          <TouchableOpacity style={styles.retryButton} onPress={loadData}>
            <Text style={styles.retryButtonText}>Retry</Text>
          </TouchableOpacity>
        </View>
      );
    }

    return (
      <ScrollView style={styles.scrollView}>
        <View style={styles.section}>
          <Text style={styles.sectionHeader}>Users ({users.length})</Text>
          {users.map(renderUserItem)}
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionHeader}>Products ({products.length})</Text>
          {products.map(renderProductItem)}
        </View>
      </ScrollView>
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor="#FFFFFF" />
      <View style={styles.header}>
        <Text style={styles.headerTitle}>KMP Consumer App</Text>
        <TouchableOpacity style={styles.refreshButton} onPress={loadData}>
          <Text style={styles.refreshButtonText}>Refresh</Text>
        </TouchableOpacity>
      </View>
      {renderContent()}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333333',
  },
  refreshButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 6,
  },
  refreshButtonText: {
    color: '#FFFFFF',
    fontWeight: '600',
  },
  scrollView: {
    flex: 1,
  },
  section: {
    padding: 16,
  },
  sectionHeader: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 12,
    color: '#333333',
  },
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    padding: 16,
    marginBottom: 8,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  cardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  userIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#E3F2FD',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  productIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#E8F5E8',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  iconText: {
    fontSize: 18,
  },
  cardContent: {
    flex: 1,
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 4,
  },
  cardSubtitle: {
    fontSize: 14,
    color: '#666666',
    marginBottom: 4,
  },
  cardId: {
    fontSize: 12,
    color: '#999999',
  },
  cardFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 4,
  },
  cardPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#4CAF50',
  },
  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16,
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666666',
  },
  errorText: {
    fontSize: 16,
    color: '#F44336',
    textAlign: 'center',
    marginBottom: 16,
  },
  retryButton: {
    backgroundColor: '#F44336',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 6,
  },
  retryButtonText: {
    color: '#FFFFFF',
    fontWeight: '600',
  },
});

export default App;