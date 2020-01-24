import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/products/widgets/product_item.dart';
import 'package:waitero/services/database/products_repo.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({
    Key key,
  }) : super(key: key);

  @override
  _ManageProductsPageState createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  final CollectionReference productsRef = ProductsRepo().ref;
  bool isLoading = false;
  List<Product> products = <Product>[];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    setState(() {
      isLoading = true;
    });
    final QuerySnapshot snapshot =
        await productsRef.orderBy('name', descending: true).getDocuments();
    setState(() {
      isLoading = false;
      products = snapshot.documents
          .map<Product>(
            (DocumentSnapshot doc) => Product.fromDocument(doc),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 34,
        ),
        onPressed: () {
          Router.navigator.pushNamed(Router.addProduct);
        },
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Manage Products',
                    style: GoogleFonts.alata(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                child: isLoading
                    ? Center(child: Container(child: const CircularProgressIndicator(), width: MediaQuery.of(context).size.width * 0.25, height: MediaQuery.of(context).size.height * 0.25,),)
                    : Container(
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.3,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                          ),
                          primary: false,
                          itemBuilder: (_, int index) {
                            return ProductItem(
                              product: products[index],
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
