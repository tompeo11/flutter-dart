import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import '../widget/admin_product_item_widget.dart';
import '../widget/navbar_drawer.dart';
import 'admin_product_edit_screen.dart';

class AdminProductScreen extends StatelessWidget {
  static const routeName = '/admin-product';

  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(AdminProductEditScreen.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const NavbarDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, idx) => AdminProductItemWidget(
                productsData.items[idx].id,
                productsData.items[idx].name,
                productsData.items[idx].imageUrl)),
      ),
    );
  }
}
