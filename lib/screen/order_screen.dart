import 'package:flutter/material.dart';
import 'package:my_app/entity/order.dart';
import 'package:my_app/widget/navbar_drawer.dart';
import 'package:provider/provider.dart';

import '../widget/order_item_widget.dart';

class OrderScreen extends StatelessWidget {
  static const routName = "/orders";

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<Orders>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders'),),
      drawer: const NavbarDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
          itemBuilder: (ctx, idx) => OrderItemWidget(
            order: orders.orders[idx]
          ),
      ),
    );
  }
}
