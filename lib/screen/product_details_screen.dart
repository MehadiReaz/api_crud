import 'package:d7/screen/product_gridview_screen.dart';
import 'package:d7/style/style.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(this.productItem, {super.key});
  final Map productItem;
  //Map<String, dynamic> formValues = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productItem['ProductName']),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                productItem['Img'],
                fit: BoxFit.cover,
                height: 300,
                width: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${productItem['ProductName']}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '\$${productItem['UnitPrice']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'Product Code:  ${productItem['ProductCode']}',
                style:
                    const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: const Color.fromARGB(66, 95, 151, 241),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ' Product Details',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 200,
                      width: double.infinity,
                      color: Colors.black26,
                      child: const Column(children: [
                        Text(
                          'There is also another way for removing the "debug" banner from the Flutter app. Now after a new release there is no "debugShowCheckedModeBanner: false," code line in the main .dart file. So I think these methods are effective',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '* 3 Year Official Warrenty',
                          style: TextStyle(
                              backgroundColor: colorRed,
                              color: colorWhite,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          successToast("Product Added to the cart");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductGridViewScreen()));
        },
        label: const Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(' ADD to Cart'),
        ),
      ),
    );
  }
}
