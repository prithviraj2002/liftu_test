import 'package:flutter/material.dart';
import 'package:lift_u_test/constants/dimensions.dart';
import 'package:lift_u_test/constants/strings.dart';
import 'package:lift_u_test/model/category_model.dart';
import 'package:lift_u_test/model/product_model.dart';
import 'package:lift_u_test/provider/product_provider.dart';
import 'package:lift_u_test/screens/product_detail.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  int categoryId = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(
              width: Dimens.dimens20,
            ),
            Text(AppStrings.welcomeUserText)
          ],
        ),
        actions: const [
          Icon(Icons.doorbell),
          SizedBox(width: Dimens.dimens20),
          Icon(Icons.menu)
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider productProvider,
            Widget? child) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Search for brand'),
                ),
                const SizedBox(
                  height: Dimens.dimens20,
                ),
                FutureBuilder(
                    future: productProvider.getAllCategories(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<Category> categories = snapshot.data;
                        return SizedBox(
                          height: Dimens.dimens50,
                          width: double.infinity,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      categoryId = categories[index].id;
                                    });
                                  },
                                  child: Chip(
                                      label: Text(categories[index].name, style: TextStyle(color: categoryId == categories[index].id ? Colors.purple : Colors.black),)),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return const SizedBox(
                                  width: Dimens.dimens10,
                                );
                              },
                              itemCount: categories.length),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                    }),
                const SizedBox(
                  height: Dimens.dimens10,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: productProvider.getAllProducts(categoryId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Product> products = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProductDetailScreen(product: products[index],)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(products[index].images[0], height: 100, width: 200,),
                                      Text(products[index].title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                                      Center(child: Text(products[index].description, maxLines: 1, overflow: TextOverflow.fade, style: const TextStyle(color: Colors.grey, fontSize: 10),)),
                                      Text(products[index].price.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0
                                ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

