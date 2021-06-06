import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/modules/login/index.dart';
import 'package:flutter_record_lesson/modules/welcome/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'di/injector.dart';
import 'modules/home/src/home_page.dart';
import 'modules/profile/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness:
        Brightness.light, // this will change the brightness of the icons
    statusBarColor: Colors.white, // or any color you want
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Injector().configure(Flavor.debug);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.latoTextTheme(Theme.of(context).textTheme);
    final newTextTheme = textTheme
        .copyWith(
          overline: textTheme.overline!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          button: textTheme.button!.copyWith(
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: textTheme.bodyText1!.copyWith(letterSpacing: 1),
          bodyText2: textTheme.bodyText2!.copyWith(letterSpacing: 1),
          headline1: textTheme.headline1!.copyWith(letterSpacing: 1),
          headline2: textTheme.headline2!.copyWith(letterSpacing: 1),
          headline3: textTheme.headline3!.copyWith(letterSpacing: 1),
          headline4: textTheme.headline4!.copyWith(letterSpacing: 1),
          headline5: textTheme.headline5!.copyWith(letterSpacing: 1),
          headline6: textTheme.headline6!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
          subtitle1: textTheme.subtitle1!.copyWith(
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
          subtitle2: textTheme.subtitle2!.copyWith(letterSpacing: 1.0),
        )
        .apply(
          bodyColor: Colors.grey[900],
          displayColor: Colors.blueGrey[900],
        );
    return ChangeNotifierProvider.value(
      value: locator<AppBloc>(),
      child: MaterialApp(
        title: 'DotMyConcepts',
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 1,
            color: Colors.white,
            brightness: Brightness.light,
            textTheme: newTextTheme,
            iconTheme: Theme.of(context).iconTheme,
          ),
          scaffoldBackgroundColor: Colors.white,
          buttonTheme: ButtonThemeData(
            height: 48,
            textTheme: ButtonTextTheme.primary,
          ),
          dividerTheme: DividerThemeData(
            color: Colors.black38,
            space: 1,
          ),
          textTheme: newTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        home: locator<UserRepository>().getUserLoggedIn()
            ? (locator<UserRepository>().getLoggedInUser()!.selectedCategory !=
                    null
                ? HomePage()
                : WelcomePage())
            : LoginScreen(),
        builder: _buildWidget,
      ),
    );
  }

  Widget _buildWidget(BuildContext context, Widget? child) {
    /* ErrorWidget.builder = (errorDetails) {
      return buildError(context, errorDetails);
    };*/
    final botToastBuilder = BotToastInit();
    final myWidget = botToastBuilder(context, child);
    return myWidget;
  }
}
