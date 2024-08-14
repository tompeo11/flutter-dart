import 'package:flutter/material.dart';
import 'package:my_app/entity/cart.dart';
import 'package:my_app/entity/order.dart';
import 'package:my_app/provider/products_provider.dart';
import 'package:my_app/screen/admin_product_screen.dart';
import 'package:my_app/screen/admin_product_edit_screen.dart';
import 'package:my_app/screen/cart_screen.dart';
import 'package:my_app/screen/order_screen.dart';
import 'package:my_app/screen/products_detail_screen.dart';
import 'package:my_app/screen/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            accentColor: Colors.lightGreen,
          ),
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductsDetailScreen.routeName: (ctx) => const ProductsDetailScreen(),
          CartScreen.routName: (ctx) => const CartScreen(),
          OrderScreen.routName: (ctx) => const OrderScreen(),
          AdminProductScreen.routName: (ctx) => const AdminProductScreen(),
          AdminProductEditScreen.routeName: (ctx) => const AdminProductEditScreen(),
        },
      ),
    );
  }
}
