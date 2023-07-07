import 'package:camp_trip/routers/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'firebase_options.dart';
import 'main.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async => $initGetIt(serviceLocator);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouters();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Isedor Modern',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        // scaffoldBackgroundColor: ColorName.white,
        buttonTheme:  ButtonThemeData(
          height:48,
          minWidth: double.infinity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        textTheme: const TextTheme(
          // labelLarge: TextStyle(fontFamily: FontFamily.outfit, fontWeight: FontWeight.w700, color: ColorName.white, fontSize: 16),
          // bodyMedium: TextStyle(fontFamily: FontFamily.outfit, fontWeight: FontWeight.w400),
        ),
        // fontFamily: FontFamily.outfit,
      ),
      routerConfig: _router.r,
    );
  }
}
