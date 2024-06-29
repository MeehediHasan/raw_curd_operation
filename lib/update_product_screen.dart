import 'dart:convert';
import 'package:curd_operation/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    //widget dite hocche keno
    _nameController.text = widget.product.ProductName;
    _productCodeTEController.text = widget.product.ProductCode;
    _unitPriceTEController.text = widget.product.UnitPrice;
    _quantityTEController.text = widget.product.Qty;
    _totalPriceTEController.text = widget.product.TotalPrice;
    _imageTEController.text = widget.product.Img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("update Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
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
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "product Code", labelText: "Product Code"),
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
                  visible: _updateProductInProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateProduct();
                      }
                      ;
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //ekhane api update er jonno banaite hobe
  Future<void> _updateProduct() async {
    setState(() {
      _updateProductInProgress = true;
    });
    Map<String, String> inputData = {
      "ProductName": _nameController.text,
      "UnitPrice": _unitPriceTEController.text,
      "ProductCode": _productCodeTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "Img": _imageTEController.text,
      // "CreatedDate": "2024-06-27T11:47:12.936Z",
      // "_id": "667ef1512e2e89e21c0c4943"
    };
    final String updateProductUrl =
        "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}";
    Uri uri = Uri.parse(updateProductUrl);
    Response response = await post(uri,
        headers: {"content-type": 'application/json'},
        body: jsonEncode(inputData));

    if (response.statusCode == 200) {
      _updateProductInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("product updated success!")));
      print(response.statusCode);
      print(response.body);

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("product updated failed!")));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _productCodeTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _imageTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();
  }
}
