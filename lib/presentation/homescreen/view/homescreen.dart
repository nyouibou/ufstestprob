// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufstestprobprob/presentation/detailedscreen/view/detailedscreen.dart';
import 'package:ufstestprobprob/presentation/homescreen/controller/homescreencontroller.dart';
import 'package:ufstestprobprob/presentation/homescreen/widgets/shopcontainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<HomeScreenController>(context, listen: false).fetchData();
  }

  void _showAddProductDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Product"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Product Title"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: "Category"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                final price = double.tryParse(priceController.text) ?? 0.0;
                final category = categoryController.text;
                Provider.of<HomeScreenController>(context, listen: false)
                    .addProduct(title, description, price, category);

                Navigator.of(context).pop();
                final snackBar = SnackBar(
                  duration: Duration(milliseconds: 1400),
                  content: const Text('Failed to add contents'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homescreenProvider = Provider.of<HomeScreenController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Shop Head"),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 15,
              mainAxisExtent: 300,
              crossAxisSpacing: 15,
              crossAxisCount: 2),
          itemCount: homescreenProvider.productlist.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedScreen(
                      img: homescreenProvider.productlist[index].image ?? "",
                      title: homescreenProvider.productlist[index].title ?? "",
                      description:
                          homescreenProvider.productlist[index].description ??
                              "",
                      price:
                          "\$${homescreenProvider.productlist[index].price ?? ""}",
                      rating: homescreenProvider.productlist[index].rating?.rate
                              .toString() ??
                          "",
                    ),
                  ));
            },
            child: ShopContainer(
              img: homescreenProvider.productlist[index].image ?? "",
              category: homescreenProvider.productlist[index].category ?? "",
              price: "\$${homescreenProvider.productlist[index].price ?? ""}",
              title: homescreenProvider.productlist[index].title ?? "",
              rating: homescreenProvider.productlist[index].rating?.rate
                      .toString() ??
                  "",
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddProductDialog,
      ),
    );
  }
}
