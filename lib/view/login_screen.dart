import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:market_nest/utilies/utils.dart';
import 'package:market_nest/utils/colors.dart';
import 'package:market_nest/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:market_nest/viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewmodel>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 100),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/animations/splash_animation.json',
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to MarketNest',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                Text(
                  "Stay updated",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: greyColor,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                      context,
                      emailFocusNode,
                      passwordFocusNode,
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                /// LOGIN BUTTON / LOADER
                authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          final username = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (username.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter username and password',
                                ),
                              ),
                            );
                            return;
                          }

                          try {
                            final success = await authProvider.login(
                              username,
                              password,
                            );
                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid username or password'),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '❌ Login failed: ${e.toString()}',
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: greenColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 125),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Sign Up!',
                      style: TextStyle(
                        color: greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
