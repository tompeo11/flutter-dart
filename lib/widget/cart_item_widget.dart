import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/cart.dart';

class CartItemWidget extends StatelessWidget {
  final int keyCartItem;
  final int productId;
  final double unitPrice;
  final int quantity;
  final String name;

  const CartItemWidget({
    super.key,
    required this.keyCartItem,
    required this.productId,
    required this.unitPrice,
    required this.quantity,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(productId),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) =>
                AlertDialog(
                  title: const Text('Notification!'),
                  content: const Text('Do you want to remove the item?'),
                  actions: [
                    TextButton(child: const Text('No'), onPressed: () => Navigator.of(context).pop(false),),
                    TextButton(child: const Text('Yes'), onPressed: () => Navigator.of(context).pop(true),),
                  ],
                )
              ,
          );
        },
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          padding: const EdgeInsets.all(20),
          child: const Icon(Icons.delete, color: Colors.white, size: 40,),
        ),
        onDismissed: (direction) => {
          context.read<Cart>().removeItem(keyCartItem)
        },
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('\$$unitPrice'),
                      )
                  ),
                ),
                title: Text(name),
                subtitle: Text('Total: \$${(unitPrice * quantity).toStringAsFixed(2)}'),
                trailing: Text('x$quantity'),
              ),
            )
        )
    );
  }
}