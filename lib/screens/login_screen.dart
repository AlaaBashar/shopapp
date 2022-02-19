import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var apiBloc = LoginBloc.get(context);
    return BlocConsumer<LoginBloc, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'LOGIN',
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Login now to browse our hot offers',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DefaultTextFieldWidget(
                    isSuffixShow: false,
                    controller: emailController,
                    hintText: 'Email Address',
                    icon: const Icon(Icons.email),
                    height: 60.0,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email Must Be Not Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DefaultTextFieldWidget(
                    suffixIcon: apiBloc.suffixIcon,
                    suffixOnPressed: suffixOnPressed,
                    isSuffixShow: true,
                    isObscure: apiBloc.isVisible,
                    height: 60.0,
                    controller: passwordController,
                    hintText: 'Password',
                    icon: const Icon(Icons.lock),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password Must Be Not Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DefaultButtonWidget(
                    fontSize: 16.0,
                    onPressed: onLogin,
                    text: 'LOGIN',
                    color: Colors.lightBlue,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          openNewPage(context, const RegisterScreen());
                        },
                        child: const Text('Register Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void suffixOnPressed() {
    LoginBloc.get(context).add(PasswordVisibilityEvent());
  }

  void onLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    LoginBloc.get(context).add(
      LoginEvent(
        context: context,
        path: 'login',
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }
}
