import 'package:flutter/material.dart';
import 'package:my_app/entity/cart.dart';
import 'package:my_app/entity/order.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:my_app/screen/admin_product_screen.dart';
import 'package:my_app/screen/admin_product_edit_screen.dart';
import 'package:my_app/screen/cart_screen.dart';
import 'package:my_app/screen/order_screen.dart';
import 'package:my_app/screen/product_detail_screen.dart';
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
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
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
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          AdminProductScreen.routeName: (ctx) => const AdminProductScreen(),
          AdminProductEditScreen.routeName: (ctx) =>
              const AdminProductEditScreen(),
        },
      ),
    );
  }
}
