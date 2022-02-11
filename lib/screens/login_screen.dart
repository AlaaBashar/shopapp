import 'package:flutter/material.dart';
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
  UserModel? loginModel;

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
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
  }

  void onLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    ProgressCircleDialog.show(context);
    DioHelper.postData(
      path:'login',
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },).then((value) {
      print('Data is :----------------------------');
// ignore: avoid_print
      print(value.data);
      loginModel= UserModel.fromJson(value.data);
      ProgressCircleDialog.dismiss(context);
      ShowToast.display(
        context: context,
        message: loginModel!.message,
        color: Colors.greenAccent,
        icon:Icons.check,
      );
    }).catchError((error){
      print('Data is :----------------------------');
      print(error.toString());

    });


  }


}
