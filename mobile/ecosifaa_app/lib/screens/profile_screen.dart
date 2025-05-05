import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecosifaa_mobile/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecosifaa_mobile/screens/login_screen.dart';
import 'package:ecosifaa_mobile/providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  bool _isDarkMode = false;
  bool _isLoggedIn = false;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _isLoggedIn = _username.isNotEmpty;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await _apiService.logout();
    await prefs.remove('username');
    
    setState(() {
      _isLoggedIn = false;
      _username = '';
    });
  }

  Future<void> _login() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );

    if (result == true) {
      // Giriş başarılı, kullanıcı bilgilerini güncelle
      final prefs = await SharedPreferences.getInstance();
      // Gerçek uygulamada kullanıcı adını API'den almanız gerekebilir
      // Burada basitlik için sabit değer atıyoruz
      const username = "admin";
      await prefs.setString('username', username);
      
      setState(() {
        _isLoggedIn = true;
        _username = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profil başlığı
          if (_isLoggedIn) ...[
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.shade100,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _username,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
          ] else ...[
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.login,
                      size: 50,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Giriş yaparak tüm özelliklere erişin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Giriş Yap'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
          ],

          // Uygulama Ayarları
          const SizedBox(height: 16),
          const Text(
            'Uygulama Ayarları',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Tema ayarı
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                leading: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Colors.green,
                ),
                title: const Text('Tema'),
                subtitle: Text(themeProvider.isDarkMode ? 'Koyu Tema' : 'Açık Tema'),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(),
                  activeColor: Colors.green,
                ),
              );
            },
          ),
          
          const Divider(),
          
          // Çıkış yapma
          if (_isLoggedIn) ...[
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text('Çıkış Yap'),
              onTap: _logout,
            ),
            const Divider(),
          ],
          
          // Uygulama Bilgileri
          const SizedBox(height: 16),
          const Text(
            'Uygulama Bilgileri',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.green,
            ),
            title: const Text('Uygulama Versiyonu'),
            subtitle: const Text('1.0.0'),
          ),
          
          ListTile(
            leading: const Icon(
              Icons.email_outlined,
              color: Colors.green,
            ),
            title: const Text('İletişim'),
            subtitle: const Text('info@ecosifaa.com'),
          ),
        ],
      ),
    );
  }
} 