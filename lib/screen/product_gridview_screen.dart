import 'package:d7/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../restapi/restcilnt.dart';
import 'product_edit_screen.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});
  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List products = [];
  bool inProgress = false;

  @override
  void initState() {
    callData();
    super.initState();
    //getProducts();
  }

  callData() async {
    inProgress = true;
    var data = await productGridviewListRequest();
    setState(() {
      products = data;
      inProgress = false;
    });
  }

  void deleteItem(id) async {
    setState(() {
      inProgress = true;
    });
    await deletePoductRequest(id);
    await callData();
  }

  void productUpdate(context, productItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductEditScreen(
                  productItem,
                )));
  }

  void productDetailsScreen(context, productItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productItem,
                )));
  }
  // void getProducts() async {
  //   inProgress = true;
  //   setState(() {});
  //   Response response =
  //       await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));
  //   final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  //   if (response.statusCode == 200 && decodedResponse['status'] == 'success') {
  //     for (var e in decodedResponse['data']) {
  //       products.add(Product.toJson(e));
  //     }
  //   }
  //   inProgress = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST api'),
        actions: [
          IconButton(
              onPressed: () {
                callData();
              },
              icon: const Icon(Icons.replay_outlined))
        ],
      ),
      body: inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 200,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.5),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                productDetailsScreen(context, products[index]);
                              },
                              child: Container(
                                height: 100,
                                width: 200,
                                child: Image.network(
                                  products[index]['Img'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          products[index]["ProductName"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      'Price: ৳${products[index]["UnitPrice"]}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  style: IconButton.styleFrom(
                                      shape: const CircleBorder()),
                                  onPressed: () {
                                    productUpdate(context, products[index]);
                                  },
                                  child: const Icon(Icons.info_outline),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                OutlinedButton(
                                  style: IconButton.styleFrom(
                                      shape: const CircleBorder()),
                                  onPressed: () {
                                    deleteItem(products[index]["_id"]);
                                  },
                                  child: const Icon(Icons.delete_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
    );
  }
}
