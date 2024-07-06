import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/detail_page.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/models/groceries_data.dart';
import 'package:flutter_application_1/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(themeProvider.themeData.textTheme),
          ),
          home: LoginPage(),
          routes: {
            'detail': (context) {
              Groceries groceries = ModalRoute.of(context)!.settings.arguments as Groceries;
              return DetailPage(groceries: groceries);
            },
            'cart': (context) => CartPage(),
          },
        );
      },
    );
  }
}
