import 'package:flutter/material.dart';

import 'package:flutter_r5_app/core/core.dart';
import 'package:flutter_r5_app/features/home/home.dart';
import 'package:flutter_r5_app/features/user/user.dart';

class BasePage extends StatefulWidget {
  const BasePage({
    this.isLogin = false,
    super.key,
  });

  final bool isLogin;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  BuildContext? _scaffoldContext;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;

      var authService = getIt.get<AuthService>();
      dynamic result;

      if (widget.isLogin) {
        result = await authService.signInWithEmailAndPassword(email, password);
      } else {
        result =
            await authService.createUserWithEmailAndPassword(email, password);
      }

      _handleAuthResult(result);
    }
  }

  void _handleAuthResult(result) {
    String errorMessage = '';

    switch (result) {
      case 1:
        errorMessage = widget.isLogin
            ? 'Credenciales incorrectas. Por favor, inténtelo de nuevo.'
            : 'Contraseña demasiado débil. Por favor, inténtelo de nuevo.';
        break;
      case 2:
        errorMessage =
            'Correo electrónico ya en uso. Por favor, inténtelo de nuevo.';
        break;
      case null:
        errorMessage = 'Ocurrió un error. Por favor, inténtelo de nuevo.';
        break;
    }

    if (errorMessage.isNotEmpty) {
      _showSnackBar(errorMessage);
    } else {
      _navigateToNextPage();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToNextPage() {
    if (widget.isLogin) {
      Navigator.pushReplacement(
        _scaffoldContext!,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext scaffoldContext) {
        _scaffoldContext = scaffoldContext;
        return Stack(
          children: [
            // Fondo gradiente
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Contenido del formulario y logo
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Logo
                            Image.asset(
                              AssetsImagesConstants.toDoIcon,
                              height: 80.0,
                              width: 80.0,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              widget.isLogin ? 'Iniciar Sesión' : 'Registro',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16.0),
                            EmailField(emailController: _emailController),
                            const SizedBox(height: 16.0),
                            PasswordField(
                                passwordController: _passwordController),
                            const SizedBox(height: 32.0),
                            ElevatedButton(
                              onPressed: () => _submitForm(),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                widget.isLogin
                                    ? 'Iniciar Sesión'
                                    : 'Registrarse',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.isLogin
                                      ? '¿No tienes una cuenta?'
                                      : '¿Ya tienes una cuenta?',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (widget.isLogin) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
                                        ),
                                      );
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    widget.isLogin
                                        ? 'Regístrate'
                                        : 'Iniciar Sesión',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
