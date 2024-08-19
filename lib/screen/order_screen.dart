import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../entity/order.dart';
import '../widget/navbar_drawer.dart';
import '../widget/order_item_widget.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<Orders>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: const NavbarDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (ctx, idx) => OrderItemWidget(
          order: orders.orders[idx],
        ),
      ),
    );
  }
}
