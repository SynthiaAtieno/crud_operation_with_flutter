import 'package:crud_operation_spring/pages/home_page.dart';
import 'package:crud_operation_spring/pages/product_home_page.dart';
import 'package:crud_operation_spring/provider/pets_provider.dart';
import 'package:crud_operation_spring/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PetsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue ),
        // home: const ProductHomePage(),
         home: const HomePage(),
      ),
    );
  }
}
