import 'package:first_app/screens/customer_screen.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/screens/purchase_screen.dart';
import 'package:first_app/screens/sales_screen.dart';
import 'package:first_app/suppliers_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
     
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/sales': (context) => const SalesScreen(),
        '/purchases': (context) => const PurchasesScreen(),
        '/customers': (context) => const CustomersScreen(),
        '/suppliers': (context) => const SuppliersScreen(),
      },
    ));
}
