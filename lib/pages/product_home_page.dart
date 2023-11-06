import 'package:crud_operation_spring/model/product.dart';
import 'package:crud_operation_spring/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();


}

class _ProductHomePageState extends State<ProductHomePage> {
  @override
  void initState() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Page"),
        centerTitle: true,
      ),
      body: provider.isLoading ? getLoadingUi() : provider.error.isNotEmpty ? getErrorUi(provider.error) : getBodyUi(provider.products)
    );
  }

  Widget getLoadingUi() {
    return Center(
      child: Column(
        children: const [
          SpinKitFadingCircle(
            color: Colors.green,
            size: 80,
          ),
          Text("Loading...", style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }

  Widget getErrorUi(String error) {
    return Center(
      child: Text(error, style: const TextStyle(fontSize: 18),),
    );
  }

  Widget getBodyUi(List<Products> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(child: Text((products[index].id +1).toString())),
        title: Text(products[index].name),
        subtitle: Text(products[index].price.toString()),
        trailing: Text(products[index].price.toString()),
      ),
    );
  }
}
