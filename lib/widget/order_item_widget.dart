import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/entity/order.dart';

class OrderItemWidget extends StatefulWidget {
  final Order order;

  const OrderItemWidget({super.key, required this.order});

  @override
  State<StatefulWidget> createState() => _OrderItemWidget();
}

class _OrderItemWidget extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        ListTile(
          title: Text('\$${widget.order.totalPrice}'),
          subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () => setState(() {
              _expanded = !_expanded;
            }),
          ),
        ),
        if (_expanded)
          SizedBox(
            height: 70 * widget.order.cartItems.length.toDouble(),
            child: ListView(
              children: widget.order.cartItems
                  .map((item) => ListTile(
                        title: Text(
                          item.name,
                          style: const TextStyle(color: Colors.lightBlueAccent),
                        ),
                        subtitle:
                            Text('\$${item.unitPrice} x ${item.quantity}'),
                      ))
                  .toList(),
            ),
          )
      ],
    ));
  }
}
