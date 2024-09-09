import 'package:flutter/material.dart';
import 'package:my_app/entity/HttpException.dart';
import 'package:my_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routName = "/auth";
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(0, 300, 200, 1).withOpacity(0.5),
                  const Color.fromRGBO(300, 200, 0, 1).withOpacity(0.9),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  AuthCard(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

enum AuthMode {SIGNUP, LOGIN}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<StatefulWidget> createState() => _AuthCard();

}

class _AuthCard extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.LOGIN;
  final Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Notification') ,
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
        )
      ],
    ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    print(_authData['email']);
    print(_authData['password']);

    setState(() {_isLoading = true;});

    if (_authMode == AuthMode.LOGIN) {
      //login
      try {
        await context.read<AuthProvider>().login(_authData['email']!, _authData['password']!);
      } on HttpException catch(e) {
        _showErrorDialog(e.toString());
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    } else {
      //signup
      await context.read<AuthProvider>().signup(_authData['email']!, _authData['password']!);
    }
    setState(() { _isLoading = false; });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.LOGIN) {
      setState(() { _authMode = AuthMode.SIGNUP; });
    } else {
      setState(() { _authMode = AuthMode.LOGIN; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      elevation: 8.0,
      child: Container(
        width: deviceSize.width * 0.75,
        height: _authMode == AuthMode.SIGNUP ? 320 : 260,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onSaved: (value) {_authData['email'] = value!;},
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                  onSaved: (value) {_authData['password'] = value!;},
                ),
                if (_authMode == AuthMode.SIGNUP)
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.SIGNUP
                        ? (value) {
                      if (value != _passwordController.text) {
                        return 'Password not match';
                      }
                      return null;
                    }
                        : null,
                  ),
                const SizedBox(height: 20,),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                      onPressed: _submit,
                      child: Text(_authMode == AuthMode.LOGIN ? 'LOGIN': 'SIGNUP')
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text('${_authMode == AuthMode.LOGIN ? 'SIGNUP': 'LOGIN'} INSTEAD'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
