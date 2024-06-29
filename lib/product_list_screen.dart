import 'dart:convert';
import 'package:curd_operation/add_product_screen.dart';
import 'package:curd_operation/product.dart';
import 'package:curd_operation/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductListInProgress = false;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProductItem(productList[index]);
            },
            separatorBuilder: (_, __) => Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
 //get operation hoiche form api
  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();
    const String getProductListUrl =
        "https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri = Uri.parse(getProductListUrl);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      final jsonProductList = decodedData['data'];

      for (Map<String, dynamic> p in jsonProductList) {
        Product product = Product(
            id: p["_id"] ?? "",
            ProductName: p['ProductName'] ?? "unknown",
            ProductCode: p['ProductCode'] ?? '',
            Img: p['Img'] ?? '',
            UnitPrice: p['UnitPrice'] ?? '',
            Qty: p['Qty'] ?? '',
            TotalPrice: p['TotalPrice'] ?? '');

        productList.add(product);
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Get product list success")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("get product failed")));
    }
    _getProductListInProgress = false;
    setState(() {});
  }

  Widget _buildProductItem(Product product) {
    return ListTile(
      leading: Image.network(product.Img),
      title: Text(product.ProductName),
      subtitle: Wrap(
        spacing: 10,
        children: [
          Text("Unit price: ${product.UnitPrice}"),
          Text("Quantity: ${product.Qty}"),
          Text("Total price: ${product.TotalPrice}")
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () async{
             final result = await  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(product: product,),
                ),
              );
             if(result == true){
               _getProductList();
             }
            },

            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(product.id);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
    );
  }

  //paramettar keno pass korte holo

  Future<void> _deleteProduct(String ProductId) async{

     setState(() {
       _getProductListInProgress=true;
     });
    final String deleteProductUrl="https://crud.teamrabbil.com/api/v1/DeleteProduct/$ProductId";
    Uri uri=Uri.parse(deleteProductUrl);
    Response response= await get(uri);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
       _getProductList();
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("successfully Deleted")));
    } else{
      _getProductListInProgress=false;
      setState(() {

      });
    }

  }




  void _showDeleteConfirmationDialog(String ProductId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are you sure you want to delete?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(ProductId);
                Navigator.pop(context);
              },
              child: Text("Delete"),
            )
          ],
        );
      },
    );
  }
}

