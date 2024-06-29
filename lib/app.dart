import 'package:curd_operation/product_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CrudApp());
}

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crud App",
      theme: _lightThemedata(),
      themeMode: ThemeMode.light,
      darkTheme: _darkThemeData(),
      home: ProductListScreen(),
    );

  }
  ThemeData _lightThemedata(){
    return ThemeData(
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent),),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red),
        ),

      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white),
      ),

    );


  }
  ThemeData _darkThemeData(){

    return ThemeData(
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent),),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red),
        ),

      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white),
      ),

    );
  }
}
