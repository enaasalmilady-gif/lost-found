import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        children: [
          // الوضع الليلي
          ListTile(
            title: const Text('الوضع الليلي'),
            leading: const Icon(Icons.dark_mode),
            trailing: Switch(
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (val) => settings.toggleTheme(val),
            ),
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'تخصيص لون التطبيق',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  children: [
                    _buildColorCircle(context, settings, Colors.blue),
                    _buildColorCircle(context, settings, Colors.red),
                    _buildColorCircle(context, settings, Colors.green),
                    _buildColorCircle(context, settings, Colors.purple),
                    _buildColorCircle(context, settings, Colors.orange),
                    _buildColorCircle(context, settings, Colors.teal),
                    _buildColorCircle(context, settings, Colors.deepOrange),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'حذف الحساب',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () => _confirmDeleteAccount(context, settings),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الحساب', style: TextStyle(color: Colors.red)),
        content: const Text(
          'هل أنت متأكد أنك تريد حذف حسابك نهائياً؟ ستفقد جميع بياناتك، ويمكنك إنشاء حساب جديد بنفس البريد لاحقاً.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              try {
                await AuthService().deleteAccount();
                if (context.mounted) {
                  // User stream should handle navigation, but we force it to be safe
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حذف الحساب بنجاح. أهلاً بك مجدداً.'),
                    ),
                  );
                }
              } on FirebaseAuthException catch (e) {
                if (context.mounted) {
                  if (e.code == 'requires-recent-login') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'لأمانك، يرجى تسجيل الخروج والدخول مجدداً ثم المحاولة.',
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل حذف الحساب: ${e.message}')),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('حدث خطأ غير متوقع عند الحذف.'),
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف الحساب'),
          ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(
    BuildContext context,
    SettingsProvider settings,
    Color color,
  ) {
    final isSelected = settings.seedColor.value == color.value;
    return GestureDetector(
      onTap: () => settings.setSeedColor(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }
}
