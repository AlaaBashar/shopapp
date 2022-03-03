import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(
                  key: 'token', value: state.loginModel!.data!.token)
              .then((value) {
            setState(() {
              token = state.loginModel!.data!.token.toString();
            });
            openNewPage(context, const HomeScreen(), popPreviousPages: true);
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: LayoutBuilder(
              builder: (
                BuildContext context,
                BoxConstraints constraints,
              ) {
                return RefreshIndicator(
                  strokeWidth: 3,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(flex: 1,),
                                const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 35.0, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  'Welcome back ! Login with your credentials',
                                  style:
                                      TextStyle(fontSize: 20.0, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                DefaultTextFieldWidget(
                                  isSuffixShow: true,
                                  suffixIcon: Icons.clear,
                                  suffixOnPressed: ()=> emailController.clear(),
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
                                const Spacer(flex: 1,),
                                DefaultButtonWidget(
                                  fontSize: 16.0,
                                  onPressed: onLogin,
                                  text: 'Login',
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
                                        openNewPage(context, RegisterScreen());
                                      },
                                      child: const Text('SignUp Now'),
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
                );
              },
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

  Future<void> _onRefresh() async {
    emailController.clear();
    passwordController.clear();
  }
}
