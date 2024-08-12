import 'package:apptareas/app/view/contador/contador_page.dart';
import 'package:apptareas/app/view/splash/splash_page.dart';
import 'package:apptareas/app/view/task_list/lista_tareas_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const backgroundColor = Color(0xFFF5F5F5);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Poppins',
          bodyColor: textColor,
          displayColor: textColor,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage()
    );
  }
}