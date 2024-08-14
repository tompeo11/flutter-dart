import 'package:flutter/material.dart';
import 'package:my_app/widget/products_item.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class ProductGrid extends StatelessWidget {

  final bool _showFavoritesOnly;

  const ProductGrid(this._showFavoritesOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = context.watch<ProductsProvider>();
    final products = _showFavoritesOnly ? productsData.getFavoriteItems : productsData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2/3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15
        ),
        itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
          value: products[idx],
          child: const ProductsItem(),
        )
    );
  }
}