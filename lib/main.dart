import 'package:flutter/material.dart';
import 'package:market_nest/view/splash_screen.dart';
import 'package:market_nest/viewmodels/auth_viewmodel.dart';
import 'package:market_nest/viewmodels/cart_view_moder.dart';
import 'package:provider/provider.dart';
import 'viewmodels/product_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ), // ✅ Cart ViewModel added
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MarketNest',
      home: SplashScreen(), // Or HomeScreen()
    );
  }
}
