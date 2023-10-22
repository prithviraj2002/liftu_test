import 'package:flutter/material.dart';
import 'package:lift_u_test/constants/dimensions.dart';
import 'package:lift_u_test/model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  Product product;

  ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.network(product.images[0]),
              const SizedBox(
                height: Dimens.dimens20,
              ),
              Text(
                product.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: Dimens.dimens20,
              ),
              Text(
                product.description,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: Dimens.dimens20,
              ),
              Text(
                product.price.toString(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: Dimens.dimens20,
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Image.network(product.images[index]);
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        width: Dimens.dimens10,
                      );
                    },
                    itemCount: product.images.length),
              ),
              const SizedBox(height: 70,)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        color: Colors.black,
        child: const Center(child: Text('Buy now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
      ),
    );
  }
}
