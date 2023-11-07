import 'package:crud_operation_spring/model/product.dart';
import 'package:crud_operation_spring/provider/product_provider.dart';
import 'package:crud_operation_spring/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
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
          actions: [
            IconButton(
                onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Add more items"),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: [
                                      TextForm(
                                        controller: nameController, text: 'Product Name',
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextForm(
                                        controller: quantityController, text: 'Product Quantity',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextForm(
                                        controller: priceController, text: 'Product Price',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(onPressed: ()=> saveToDb(), child: const Text("Save"),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    },
                icon: const Icon(Icons.add)),
          ],
        ),
        body: provider.isLoading
            ? getLoadingUi()
            : provider.error.isNotEmpty
                ? getErrorUi(provider.error)
                : getBodyUi(provider.products));
  }

  Widget getLoadingUi() {
    return Center(
      child: Column(
        children: const [
          SpinKitFadingCircle(
            color: Colors.green,
            size: 80,
          ),
          Text(
            "Loading...",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget getErrorUi(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget getBodyUi(List<Products> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(child: Text(products[index].id.toString())),
        title: Text(products[index].name),
        subtitle: Text("Ksh. ${products[index].price.toString()}"),
        trailing: Text("${products[index].quantity.toString()} items"),
      ),
    );
  }

  saveToDb() {
    print(nameController.text);
    print(quantityController.text);
    print(priceController.text);
  }
}
