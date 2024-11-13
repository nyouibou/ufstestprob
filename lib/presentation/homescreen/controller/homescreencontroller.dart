import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../model/modelapi.dart';

class HomeScreenController with ChangeNotifier {
  final myBox = Hive.box("products");

  // List to store product data
  List<SampleApiModel> productlist = [];

  // Function to fetch data from the API
  Future<void> fetchData() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body) as List;
      productlist = decodedData
          .map<SampleApiModel>((element) => SampleApiModel.fromJson(element))
          .toList();
      notifyListeners();
    }
  }

  // Function to add data to both the API and Hive
  Future<void> addProduct(
      String title, String description, double price, String category) async {
    // Construct product model
    final newProduct = SampleApiModel(
      title: title,
      description: description,
      price: price,
      category: category,
      image: "", // Set a default or fetch image separately if needed
    );

    // Adding data to the API
    var url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newProduct.toJson()),
    );

    if (response.statusCode == 201) {
      // Add to Hive local storage
      myBox.add({
        "title": title,
        "description": description,
        "price": price.toString(),
        "category": category,
      });

      // Update the local product list
      productlist.add(newProduct);
      notifyListeners();
    } else {
      print("Failed to add product to the API");
    }
  }

  // Function to delete data from Hive
  void deleteData(int index) {
    myBox.deleteAt(index);
    productlist.removeAt(index);
    notifyListeners();
  }
}
