import 'package:flutter/material.dart';
import 'package:my_app/provider/products_provider.dart';
import 'package:provider/provider.dart';

class ProductsDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  const ProductsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as int;
    final productDetail = context.read<ProductsProvider>().findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(productDetail.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 200,
              child: Image.network(productDetail.imageUrl, fit: BoxFit.cover,),
            ),
            const SizedBox(height: 10,),

            Text('\$${productDetail.unitPrice}', style: const TextStyle(fontSize: 20),),
            const SizedBox(height: 10,),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(productDetail.description, textAlign: TextAlign.justify,),
            )
          ],
        ),
      )
    );
  }
}
