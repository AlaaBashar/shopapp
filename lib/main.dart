import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'loginSuccess') ?? '';
  Widget? widget;
  if (onBoarding) {
    if (token.isEmpty) {
      widget = const LoginScreen();
    } else {
      widget = const HomeScreen();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(InitialLoginState()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(InitialHomeState())
            ..add(HomeGetDataEvent(context: context))
            ..add(HomeGetCategoriesDataEvent(context: context))
            ..add(HomeGetFavoritesDataEvent())
            ..add(HomeGetProfileDataEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo),
        ),
        home: widget,
      ),
    );
  }
}
