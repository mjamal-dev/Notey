import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/views/landing_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Notey',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: AppColors.lightTextColor),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.orange),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.lightTextColor)),
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: AppColors.orange)),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: AppColors.orange),
          fontFamily: GoogleFonts.poppins().fontFamily,
          backgroundColor: AppColors.containerBackground,
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 50),
              backgroundColor: AppColors.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(
                  'There was an error initializing Firebase! ${snapshot.error}');
              return const Text('Something went wrong!');
            } else if (snapshot.hasData) {
              print('All good!');
              return const LandingView();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
