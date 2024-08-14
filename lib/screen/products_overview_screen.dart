import 'package:flutter/material.dart';
import 'package:my_app/entity/cart.dart';
import 'package:my_app/screen/cart_screen.dart';
import 'package:my_app/widget/badge.dart';
import 'package:my_app/widget/navbar_drawer.dart';
import 'package:my_app/widget/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductOverViewScreen();
}

class _ProductOverViewScreen extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My shop"),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: FilterOptions.favorites, child: Text('Only favorite')),
              const PopupMenuItem(
                  value: FilterOptions.all, child: Text('Show all')),
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
                onPressed: () => Navigator.of(context).pushNamed(CartScreen.routName),
              ),
            ),
          )
        ],
      ),
      drawer: const NavbarDrawer(),
      body: ProductGrid(_showFavoritesOnly),
    );
  }
}
