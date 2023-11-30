// ignore_for_file: use_build_context_synchronously

import 'package:controle_atividade_extracurricular/app/modules/auth/register/register_page.dart';
import 'package:controle_atividade_extracurricular/app/provider/app_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../splash/splash_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authProvider = AppUserProvider();
  bool _isLoading = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _hideAnimation = false;

  void _sendPasswordResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isNotEmpty && email.contains('@')) {
      try {
        await _authProvider.sendPasswordResetEmail(email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('E-mail de redefinição de senha enviado.',
                textAlign: TextAlign.center),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Falha ao enviar o e-mail de redefinição de senha.',
                textAlign: TextAlign.center),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content:
              Text('Digite um e-mail válido.', textAlign: TextAlign.center),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_toggleAnimation);
    _passwordFocusNode.addListener(_toggleAnimation);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_toggleAnimation);
    _passwordFocusNode.removeListener(_toggleAnimation);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
      setState(() {
        _hideAnimation = true;
      });
    } else {
      setState(() {
        _hideAnimation = false;
      });
    }
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) {
      return;
    }
    try {
      await _authProvider.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashPage()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
        case 'invalid-email':
          errorMessage = 'E-mail inválido ou usuário não encontrado.';
          break;
        case 'wrong-password':
          errorMessage = 'Senha incorreta. Tente novamente.';
          break;
        // Adicione este caso para lidar com a mensagem genérica de erro
        case 'invalid-login-credentials':
          errorMessage =
              'Credenciais de login inválidas. Verifique seu e-mail e senha.';
          break;
        // Outros casos...
        default:
          errorMessage = 'Ocorreu um erro ao tentar fazer o login: ${e.code}';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ocorreu um erro inesperado ao tentar fazer o login.',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToRegisterScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!_hideAnimation)
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 200,
                child: Image.asset('assets/images/bus.jpg'),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Campo obrigatório';
                        }
                        if (!value!.contains('@')) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Campo obrigatório';
                        }
                        if (value!.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isLoading ? null : _submitForm,
                      child: const Text('Entrar',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: _isLoading ? null : _navigateToRegisterScreen,
                      child: const Text('Não tem uma conta? Cadastre-se'),
                    ),
                    if (_isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    TextButton(
                      onPressed: _isLoading ? null : _sendPasswordResetEmail,
                      child: const Text('Esqueceu a senha?'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
