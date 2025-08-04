import 'package:flutter/material.dart';
import 'package:kmp_shared_sdk_flutter/kmp_shared_sdk_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KMP Consumer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'KMP Consumer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final KmpSharedSdk _sdk = KmpSharedSdk();
  List<User> _users = [];
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  String? _platformInfo;

  @override
  void initState() {
    super.initState();
    _initializeSDK();
  }

  Future<void> _initializeSDK() async {
    try {
      print('🔧 Initializing KMP SDK...');
      await _sdk.initialize();
      print('✅ KMP SDK initialized successfully');

      // Get platform info
      final platformInfo = await _sdk.getPlatformInfo();
      setState(() {
        _platformInfo = platformInfo;
      });
      print('📱 Platform Info: $platformInfo');

      await _loadData();
    } catch (e) {
      print('❌ KMP SDK initialization failed: $e');
      setState(() {
        _error = e.toString();
      });
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('📱 Fetching users from KMP SDK...');
      final users = await _sdk.getUsers();
      print('✅ Users fetched: ${users.length} users');

      print('📱 Fetching products from KMP SDK...');
      final products = await _sdk.getProducts();
      print('✅ Products fetched: ${products.length} products');

      setState(() {
        _users = users;
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading data from KMP SDK: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          if (_platformInfo != null)
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () => _showPlatformInfo(),
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              'Error: $_error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadData, child: const Text('Retry')),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_platformInfo != null)
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Platform Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(_platformInfo!),
                ],
              ),
            ),
          ),
        _buildSectionHeader('Users (${_users.length})'),
        ..._users.map((user) => _buildUserCard(user)),
        const SizedBox(height: 24),
        _buildSectionHeader('Products (${_products.length})'),
        ..._products.map((product) => _buildProductCard(product)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text('ID: ${user.id}', style: const TextStyle(fontSize: 12)),
          ],
        ),
        onTap: () => _showUserDetails(user),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.shopping_cart)),
        title: Text(product.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID: ${product.id}', style: const TextStyle(fontSize: 12)),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _showProductDetails(product),
      ),
    );
  }

  void _showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Email: ${user.email}'), Text('ID: ${user.id}')],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showProductDetails(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${product.description}'),
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
            Text('ID: ${product.id}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPlatformInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Platform Information'),
        content: Text(_platformInfo ?? 'Unknown'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
