/// شاشة تسجيل الدخول
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 1)); // محاكاة التحقق

      if (!mounted) return;

      // في الإنتاج: التحقق من كلمة المرور المخزنة
      context.go('/dashboard');
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar('خطأ في تسجيل الدخول');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // الشعار والعنوان
                    _buildHeader(isDark, colorScheme),

                    const Spacer(),

                    // نموذج تسجيل الدخول
                    _buildLoginForm(colorScheme),

                    const Spacer(flex: 3),

                    // معلومات النسخة
                    Text(
                      'الإصدار ${AppConstants.appVersion}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, ColorScheme colorScheme) {
    return Column(
      children: [
        // الشعار
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.admin_panel_settings_rounded,
            size: 56,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),

        // العنوان
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),

        Text(
          'قم بإدخال كلمة المرور للدخول',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // حقل كلمة المرور
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              hintText: 'أدخل كلمة المرور',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال كلمة المرور';
              }
              if (value.length < 4) {
                return 'كلمة المرور قصيرة جداً';
              }
              return null;
            },
            onFieldSubmitted: (_) => _login(),
          ),
          const SizedBox(height: 24),

          // زر تسجيل الدخول
          FilledButton(
            onPressed: _isLoading ? null : _login,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),

          const SizedBox(height: 16),

          // زر البصمة
          OutlinedButton.icon(
            onPressed: () {
              // فحص البصمة
            },
            icon: const Icon(Icons.fingerprint_rounded),
            label: const Text('الدخول بالبصمة'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
