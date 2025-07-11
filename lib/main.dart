// main.dart
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/dashboard.dart';
import 'pages/order.dart';
import 'pages/cart.dart';
import 'pages/stock.dart';


void main() => runApp(const TrixTechApp());

class TrixTechApp extends StatelessWidget {
  const TrixTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrixTech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/Dashboard': (context) => const DashboardPage(),
        '/Cart': (context) => const CartPage(),
        '/Stock': (context) => const StockPage(),
        '/Order': (context) => const OrderPage(),
      },
    );
  }
}
