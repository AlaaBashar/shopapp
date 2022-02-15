import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/network/api.dart';
import '../../export_feature.dart';

void main() {
  DioHelper.init();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      ApiBloc(InitialState());
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApiBloc>(
          create: (context) => ApiBloc(InitialState()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.indigo),
            appBarTheme: const AppBarTheme(color: Colors.transparent,elevation: 0.0)),
        home: OnBoardingScreen(),
      ),
    );
  }
}
