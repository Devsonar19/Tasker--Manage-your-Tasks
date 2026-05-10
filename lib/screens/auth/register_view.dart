import 'package:flutter/material.dart';
import '../../services/auth/auth_services.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/custom_textfield.dart';
import '../main_layout.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        await AuthServices().signUpFirestore(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainLayout()),
          );
        }
      } catch (e) {
        if (mounted) {
          ErrorDialog.show(context, e);
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),

                  CustomTextfield(
                    controller: emailController,
                    label: "Email",
                    validator: (val) => val!.isEmpty || !val.contains('@') ? "Enter a valid email" : null,
                  ),
                  CustomTextfield(
                    controller: passwordController,
                    label: "Password",
                    isPassword: true,
                    validator: (val) => val!.length < 6 ? "Password must be at least 6 characters" : null,
                  ),
                  CustomTextfield(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    isPassword: true,
                    validator: (val) {
                      if (val != passwordController.text) return "Passwords do not match";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: isLoading ? null : _register,
                    child: isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white))
                        : const Text("Sign Up", style: TextStyle(fontSize: 16)),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const LoginView()),
                    ),
                    child: const Text("Already have an account? Login", style: TextStyle(color: Colors.black54)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
