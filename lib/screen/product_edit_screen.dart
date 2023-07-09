import 'package:d7/restapi/restcilnt.dart';
import 'package:d7/style/style.dart';
import 'package:flutter/material.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen(
    this.productItem, {
    super.key,
  });
  final Map productItem;
  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  bool loading = false;
  Map<String, dynamic> formvalues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };
  @override
  void initState() {
    super.initState();
    formvalues.update("Img", (value) => widget.productItem["Img"]);
    formvalues.update(
        "ProductCode", (value) => widget.productItem["ProductCode"]);
    formvalues.update(
        "ProductName", (value) => widget.productItem["ProductName"]);

    formvalues.update("Qty", (value) => widget.productItem["Qty"]);
    formvalues.update(
        "TotalPrice", (value) => widget.productItem["TotalPrice"]);
    formvalues.update("UnitPrice", (value) => widget.productItem["UnitPrice"]);
    setState(() {});
  }

  inputOnChange(key, avalue) {
    setState(() {
      formvalues.update(key, (value) => avalue);
    });
  }

  formOnSubmit() async {
    if (formvalues['ProductName']!.length == 0) {
      errorToast('Product Name requried');
    } else if (formvalues['ProductCode']!.length == 0) {
      errorToast('Product Code requried');
    } else if (formvalues['Img']!.length == 0) {
      errorToast('Image requried');
    } else if (formvalues['UnitPrice']!.length == 0) {
      errorToast('Unit Price requried');
    } else if (formvalues['TotalPrice']!.length == 0) {
      errorToast('Total Price requried');
    } else if (formvalues['Qty']!.length == 0) {
      errorToast('Quantity requried');
    } else {
      setState(() {
        loading = true;
      });
      await productUpdateRequest(formvalues, widget.productItem['_id']);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Update Product'),
        //backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          //screenBackground(context),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      TextFormField(
                        initialValue: formvalues['ProductName'],
                        decoration: appInputDecoration('Product Name'),
                        onChanged: (value) {
                          inputOnChange("ProductName", value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: formvalues['ProductCode'],
                        onChanged: (value) {
                          inputOnChange("ProductCode", value);
                        },
                        decoration: appInputDecoration('Product Code'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: formvalues['Img'],
                        onChanged: (value) {
                          inputOnChange("Img", value);
                        },
                        decoration: appInputDecoration('Product Image'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: formvalues['UnitPrice'],
                        onChanged: (value) {
                          inputOnChange("UnitPrice", value);
                        },
                        decoration: appInputDecoration('Unit Price'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: formvalues['TotalPrice'],
                        onChanged: (value) {
                          inputOnChange("TotalPrice", value);
                        },
                        decoration: appInputDecoration('Total Price'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      appDropDownStyle(
                        DropdownButton(
                          value: formvalues['Qty'],
                          items: const [
                            DropdownMenuItem(
                              value: '',
                              child: Text('Select Quantity'),
                            ),
                            DropdownMenuItem(
                              value: '1 pcs',
                              child: Text('1 pcs'),
                            ),
                            DropdownMenuItem(
                              value: '2 pcs',
                              child: Text('2 pcs'),
                            ),
                            DropdownMenuItem(
                              value: '3 pcs',
                              child: Text('3 pcs'),
                            ),
                            DropdownMenuItem(
                              value: '5 pcs',
                              child: Text('5 pcs'),
                            ),
                          ],
                          onChanged: (value) {
                            inputOnChange('Qty', value);
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: buttonStyle(),
                          onPressed: () {
                            formOnSubmit();
                          },
                          child: successButton('Submit'),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
