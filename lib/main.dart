import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = await CacheHelper.getData(key: 'token');
  print('Token-----------------------------------------------');
  print(token);
  print('Token-----------------------------------------------');
  Widget? widget;
  if (onBoarding) {
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        widget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? widget;

  const MyApp({
    Key? key,
    this.widget,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(InitialHomeState()),
      child: BlocConsumer<HomeBloc,HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(InitialLoginState()),
              ),
              BlocProvider<RegisterBloc>(
                create: (context) => RegisterBloc(InitialRegisterState()),
              ),
              // BlocProvider<HomeBloc>(
              //   create: (context) => HomeBloc(InitialHomeState()),
              // ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              darkTheme:darkMode,
              theme: lightMode,
              themeMode: HomeBloc.get(context).isDark == false ? ThemeMode.light : ThemeMode.dark,
              home: widget,
            ),
          );
        },
      ),
    );
  }
}
