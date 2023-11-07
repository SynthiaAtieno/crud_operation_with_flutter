import 'dart:convert';

import 'package:crud_operation_spring/model/product.dart';
import 'package:crud_operation_spring/provider/product_provider.dart';
import 'package:crud_operation_spring/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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
          elevation: 0,
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
                                        controller: nameController,
                                        text: 'Product Name',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextForm(
                                        controller: quantityController,
                                        text: 'Product Quantity',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextForm(
                                        controller: priceController,
                                        text: 'Product Price',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => saveToDb(),
                                            child: const Text("Save"),
                                          ),
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

  void showFlashError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  saveToDb() async {
    if (nameController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      try {
        final uri = Uri.parse("http://192.168.3.1:8080/api/addProduct");
        Response response = await http.post(uri,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "name": nameController.text,
              "price": priceController.text,
              "quantity": quantityController.text,
            }));
        if (response.statusCode == 200) {
          showFlashError("Product created successfully");
          nameController.clear();
          quantityController.clear();
          priceController.clear();
          Navigator.pop(context);
        } else {
          showFlashError(response.statusCode.toString());
        }
        /*
      print(nameController.text);
      print(quantityController.text);
      print(priceController.text);*/
      } catch (e) {
        showFlashError(e.toString());
      }
    } else {
      showFlashError("Please fill all the fields");
    }
  }
}
