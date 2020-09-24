import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'DotMyConcepts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          elevation: 1,
          color: Colors.white,
          brightness: Brightness.light,
          textTheme: GoogleFonts.latoTextTheme(
            textTheme.copyWith(
              headline6: textTheme.headline6.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          iconTheme: Theme.of(context).iconTheme,
        ),
        scaffoldBackgroundColor: Colors.white,
        dividerTheme: DividerThemeData(
          color: Colors.black38,
          space: 1,
        ),
        textTheme: GoogleFonts.latoTextTheme(
          textTheme
              .apply(
                bodyColor: Colors.blueGrey[900],
              )
              .copyWith(
                overline: textTheme.overline.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                bodyText1: textTheme.bodyText1.copyWith(letterSpacing: 1.0),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
