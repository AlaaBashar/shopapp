import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      LoginBloc(InitialLoginState());
    },
    blocObserver: MyBlocObserver(),
  );
  bool onBoarding= CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'loginSuccess');
  print('token : $token');
  Widget widget;
  if (onBoarding) {
    widget = const LoginScreen();
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(widget: widget,));

}

class MyApp extends StatelessWidget {
  final Widget? widget;
  const MyApp({Key? key, this.widget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(InitialLoginState()),),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(InitialHomeState())..add(HomeGetDataEvent(context: context)),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.indigo),
            ),
        home: const OnBoardingScreen(),
      ),
    );
  }
}
