import 'package:crud_operation_spring/model/pets.dart';
import 'package:crud_operation_spring/pages/product_home_page.dart';
import 'package:crud_operation_spring/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<PetsProvider>(context, listen: false);
    provider.getPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider With Api"),
        elevation: 0,
        centerTitle: true,
      ),
      body: provider.isLoading
          ? getLoadingUi()
          : provider.error.isNotEmpty
              ? getErrorUi(provider.error)
              : getBodyUi(provider.pets),
    );
  }

  Widget getLoadingUi() {
    return Center(
      child: Column(
        children: const [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 70.0,
          ),
          Text("Loading...", style: TextStyle(fontSize: 30.0, color: Colors.blue),)
        ],
      ),
    );
  }

  Widget getErrorUi(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(fontSize: 16.0, color: Colors.red),
      ),
    );
  }

  Widget getBodyUi(Pets pets) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProductHomePage()));
      },
      child: ListView.builder(
          itemCount: pets.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(pets.data[index].petName),
              subtitle: Text(pets.data[index].userName),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(pets.data[index].petImage),),
              trailing: pets.data[index].isFriendly
                  ? const Icon(
                      Icons.pets,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.pets,
                      color: Colors.red,
                    ),
            );
          }),
    );
  }
}
