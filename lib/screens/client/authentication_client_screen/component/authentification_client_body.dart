import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:csi5112group1project/context/user_context.dart';
import 'package:csi5112group1project/models/authentication.dart';
import 'package:provider/provider.dart';
import '../../../../apis/request.dart';
import '../../../../routes/router.gr.dart';
import 'dart:html';

class AuthentificationBuyerBody extends StatefulWidget {
  const AuthentificationBuyerBody({Key? key}) : super(key: key);

  @override
  _AuthentificationBuyerBodyState createState() =>
      _AuthentificationBuyerBodyState();
}

class _AuthentificationBuyerBodyState extends State<AuthentificationBuyerBody> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrlKey = GlobalKey<FormFieldState>();
  final _passwordCtrlKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    usernameController.text = 'dilchenko1@jiathis.com';
    passwordController.text = 'doI6vF';
    // usernameController.text = '';
    // passwordController.text = '';
    usernameController.addListener(() {
      if (usernameController.text != '') {
        _usernameCtrlKey.currentState!.validate();
      }
    });
    passwordController.addListener(() {
      if (passwordController.text != '') {
        _passwordCtrlKey.currentState!.validate();
      }
    });
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      final body = AuthenticationRequestBody(
        username: usernameController.text,
        password: passwordController.text,
      );
      var response = await Request.post('/login', jsonEncode(body));
      if (response.statusCode == 200) {
        var res =
            AuthenticationResponseBody.fromJson(jsonDecode(response.body));
        var user = Provider.of<UserContext>(context, listen: false);
        await user.setUser(res.jwtToken, res.user);
        context.navigateTo(const MainRoute());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(loginFailedSnackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/logo.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: TextFormField(
                  key: _usernameCtrlKey,
                  validator: (value) {
                    return (usernameController.text.isEmpty)
                        ? 'Please enter username.'
                        : null;
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 300,
                child: TextFormField(
                  key: _passwordCtrlKey,
                  validator: (value) {
                    return (passwordController.text.isEmpty)
                        ? 'Please enter password.'
                        : null;
                  },
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => signIn(),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text('New User?'),
                      TextButton(
                        onPressed: () =>
                            context.navigateTo(const SignUpRoute()),
                        child: const Text('Sign Up'),
                      )
                    ],
                  ),
                  const Text('|'),
                  TextButton(
                    onPressed: () => context.navigateTo(
                      const AdminRouter(
                        children: [
                          AdminLoginRoute(),
                        ],
                      ),
                    ),
                    child: const Text('Admin Login'),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

const loginFailedSnackBar = SnackBar(
    content: Text(
  'Your authentication information is incorrect. Please try again.',
  textAlign: TextAlign.center,
));
