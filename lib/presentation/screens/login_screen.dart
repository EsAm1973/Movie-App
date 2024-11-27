import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Hey,',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.orange.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Welcome',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.orange.shade400,
                            fontWeight: FontWeight.bold)),
                    Text('Back',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.orange.shade400,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                hintStyle: const TextStyle(color: Colors.grey),
                                labelText: 'Username',
                                labelStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 32, 32, 32),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: const Color.fromARGB(
                                    255, 32, 32, 32), // Background color
                                labelStyle: const TextStyle(
                                    color: Colors.grey), // Label color
                                prefixIcon:
                                    const Icon(Icons.lock, color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10)),
                        onPressed: () {},
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      'or continue with',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor:
                                const Color.fromARGB(255, 32, 32, 32),
                            side: const BorderSide(color: Colors.white)),
                        onPressed: () {},
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Google',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t you have an account? ',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
