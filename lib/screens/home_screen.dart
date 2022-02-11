
import 'package:flutter/material.dart';
import '../../export_feature.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButtonWidget(
              text: 'Login',
              onPressed: () {
                openNewPage(context,  const LoginScreen());
              },
            ),
            const SizedBox(height: 25.0,),
            DefaultButtonWidget(
              color: Colors.indigo,
              text: 'Register',
              onPressed: () {
                openNewPage(context, const RegisterScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

