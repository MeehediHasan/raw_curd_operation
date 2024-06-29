import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productTECodeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool addNewProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  decoration:
                      InputDecoration(hintText: "Name", labelText: "Name"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Write your product Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                TextFormField(
                  controller: _productTECodeController,
                  decoration: InputDecoration(
                      hintText: "Product code", labelText: "Product code"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Write your Product Code";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Unit price", labelText: "Unit price"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Write unit price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityTEController,
                  decoration: InputDecoration(
                      hintText: "Quantity", labelText: "Quantity"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Write your product quantity";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalPriceTEController,
                  decoration: InputDecoration(
                      hintText: "Total Price", labelText: "Total Price"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Write your product total price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                TextFormField(
                  controller: _imageTEController,
                  decoration:
                      InputDecoration(hintText: "Image", labelText: "Image"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Write your Image url";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: addNewProductInProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addNewProduct();
                      }
                      ;
                    },
                    child: Text("Add"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _addProduct() async{
  //   const String addNewProductUrl = "https://crud.teamrabbil.com/api/v1/CreateProduct";
  //   Uri uri= Uri.parse(addNewProductUrl);
  //    Response response = await post(uri);
  //
  // }

  // future, async,await
  void _addNewProduct() async {
    addNewProductInProgress = true;
    setState(() {});

    //step 1 : set url
    const String addNewProductUrl =
        "https://crud.teamrabbil.com/api/v1/CreateProduct";
    //step 2 : prepare data

    Map<String, dynamic> inputData = {
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": _productTECodeController.text.trim(),
      "UnitPrice": _totalPriceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "Img": _imageTEController.text.trim(),
    };

    // URI = uniform Resource Identifier
    // Step 3 : parse url to URI
    Uri uri = Uri.parse(addNewProductUrl);


    // step 4: Send Request
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'content-type': 'application/json'},
    );

    print(response.statusCode);
    // print(response.body);
    print(response.headers);

    addNewProductInProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
      _nameTEController.clear();
      _productTECodeController.clear();
      _unitPriceTEController.clear();
      _quantityTEController.clear();
      _imageTEController.clear();
      _totalPriceTEController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("New Product Added")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("add New Product Failed")));
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _productTECodeController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _imageTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();
  }
}
