import 'package:d7/screen/product_create_screen.dart';
import 'package:d7/screen/product_gridview_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProductGridViewScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductCreateScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
