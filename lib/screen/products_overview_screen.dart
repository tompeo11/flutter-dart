import 'package:flutter/material.dart';
import 'package:my_app/provider/product_provider.dart';

import 'package:provider/provider.dart';

import '../entity/cart.dart';
import '../widget/badge.dart';
import '../widget/navbar_drawer.dart';
import '../widget/products_grid.dart';
import 'cart_screen.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routName = "product-overview";
  const ProductsOverviewScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductsOverviewScreen();
}

class _ProductsOverviewScreen extends State<ProductsOverviewScreen> {
  @override
  void didChangeDependencies() {
    context.watch<ProductProvider>().fetchAndSetProducts().then((value) => null);
    super.didChangeDependencies();
  }

  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: FilterOptions.favorites,
                  child: Text('Only favorites')),
              const PopupMenuItem(
                  value: FilterOptions.all, child: Text('Show All')),
            ],
            onSelected: (FilterOptions selectedValue) => {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              })
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cartData, __) => Badge(
              value: cartData.itemCount.toString(),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
              ),
            ),
          )
        ],
      ),
      drawer: const NavbarDrawer(),
      body: RefreshIndicator(
        child: ProductsGrid(_showFavoritesOnly),
        onRefresh: () async => await context.read<ProductProvider>().fetchAndSetProducts(),
      )
    );
  }
}
