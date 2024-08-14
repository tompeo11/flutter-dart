import 'package:flutter/material.dart';
import 'package:my_app/entity/cart.dart';
import 'package:my_app/entity/order.dart';
import 'package:my_app/widget/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routName = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Scaffold(
        appBar: AppBar(title: const Text("Your cart",)),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Text('Total ', style: TextStyle(fontSize: 20),),
                    const Spacer(),
                    Chip(
                      label: Text('\$${cart.totalAmount}'),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    TextButton(
                      child: Text(
                        "Order now",
                        style: TextStyle(color: Theme.of(context).primaryColor),),
                      onPressed: () => {
                        context.read<Orders>().addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        ),
                        cart.clear(),
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
                child: ListView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (ctx, idx) => CartItemWidget(
                        keyCartItem: cart.items.keys.toList()[idx],
                        productId: cart.items.values.toList()[idx].productId,
                        unitPrice: cart.items.values.toList()[idx].unitPrice,
                        quantity: cart.items.values.toList()[idx].quantity,
                        name: cart.items.values.toList()[idx].name,
                    )
                ),
            )
          ],
        )
    );
  }
}
