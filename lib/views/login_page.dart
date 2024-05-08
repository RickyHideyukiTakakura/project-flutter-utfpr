import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSignIn = true;

  late String title;
  late String actionButton;
  late String toggleButton;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isSignIn = action;

      if (isSignIn) {
        title = "Welcome";
        actionButton = "Sign in";
        toggleButton = "Don't have an account? Sign up now";
      } else {
        title = "Create Account";
        actionButton = "Register";
        toggleButton = "Already have an account? Go to the login page";
      }
    });
  }

  signIn() async {
    setState(() => isLoading = true);

    try {
      await context
          .read<AuthService>()
          .signIn(emailController.text, passwordController.text);
    } on AuthException catch (error) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }

  signUp() async {
    setState(() => isLoading = true);

    try {
      await context
          .read<AuthService>()
          .signUp(emailController.text, passwordController.text);
    } on AuthException catch (error) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 240),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 48,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the email field';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        prefixIcon: Icon(
                          Icons.mail,
                          size: 16,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 48,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the password field';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 16,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 48,
                    ),
                    child: Align(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            isSignIn ? signIn() : signUp();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (isLoading)
                              ? [
                                  const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                  Text(
                                    actionButton,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setFormAction(!isSignIn),
                    child: Text(toggleButton),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
