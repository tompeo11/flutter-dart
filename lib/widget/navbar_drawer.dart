import 'package:flutter/material.dart';
import 'package:my_app/screen/admin_product_screen.dart';
import 'package:my_app/screen/order_screen.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text('Menu'),),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop_2_outlined),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: const Text('Orders'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrderScreen.routName),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AdminProductScreen.routName),
          ),
        ],
      ),
    );
  }
}