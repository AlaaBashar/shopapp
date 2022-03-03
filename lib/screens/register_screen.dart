import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          CacheHelper.saveData(key: 'token', value: state.registerModel!.data!.token)
              .then((value) {
            setState(() {
              token = state.registerModel!.data!.token.toString();
            });
            openNewPage(context, const HomeScreen(), popPreviousPages: true);
            },
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  strokeWidth: 3,
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
                                  'SIGN UP',
                                  style:
                                  TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  'Create an Account,it\'s free',
                                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                DefaultTextFieldWidget(
                                  isSuffixShow: true,
                                  suffixIcon: Icons.clear,
                                  suffixOnPressed: ()=> nameController.clear(),
                                  controller: nameController,
                                  hintText: 'Name',
                                  icon: const Icon(Icons.text_fields),
                                  height: 60.0,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name Must Be Not Empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                DefaultTextFieldWidget(
                                  suffixIcon: RegisterBloc.get(context).suffixIcon,
                                  suffixOnPressed: suffixOnPressed,
                                  isSuffixShow: true,
                                  isObscure: RegisterBloc.get(context).isVisible,
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
                                  isSuffixShow: true,
                                  suffixIcon: Icons.clear,
                                  suffixOnPressed: ()=> phoneController.clear(),
                                  controller: phoneController,
                                  hintText: 'phone',
                                  icon: const Icon(Icons.phone_android),
                                  height: 60.0,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Phone Must Be Not Empty';
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
                                  onPressed: onRegister,
                                  text: 'Sign Up',
                                  color: Colors.lightBlue,
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
    RegisterBloc.get(context).add(RegisterPasswordVisibilityEvent());
  }

  void onRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    RegisterBloc.get(context).add(
      RegisterEvent(
        context: context,
        path: 'register',
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
      ),
    );
  }

  Future<void> _onRefresh() async{
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();

  }
}
