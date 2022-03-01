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
          print('--RegisterSuccessState----------------------------------------------------');
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
        return Scaffold(
          appBar: AppBar(),

          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Register now to browse our hot offers',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DefaultTextFieldWidget(
                    isSuffixShow: false,
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
                    isSuffixShow: false,
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
                  DefaultButtonWidget(
                    fontSize: 16.0,
                    onPressed: onRegister,
                    text: 'REGISTER',
                    color: Colors.lightBlue,
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
}
