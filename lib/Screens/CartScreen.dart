import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/ProdutsTile.dart';
import 'package:fyp_project/Provider/AddToCartProvider.dart';
import 'package:fyp_project/Screens/AuthScreens/CustomAuthWidgets.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void clearCart() {
    // Get cart information
    List<Product> cartProducts =
        Provider.of<AddtoCartModel>(context, listen: false).favorites;
    double totalPrice = cartProducts.fold(
        0, (previousValue, element) => previousValue + element.price);

    // Add cart information to Firestore
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .add({
        'totalPrice': totalPrice,
        'products': cartProducts.map((product) {
          return {
            'title': product.title,
            'price': product.price,
            'category': product.category,
            // Add more fields as needed
          };
        }).toList(),
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error adding cart info to Firestore: $e');
    }

    // Clear cart locally
    Provider.of<AddtoCartModel>(context, listen: false).clearCart();
  }

  void showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('Your order is successfully placed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Cart", style: kStyleBlack22600.copyWith(color: kColorWhite)),
        centerTitle: true,
        backgroundColor: kColorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        iconTheme: IconThemeData(color: kColorWhite),
      ),
      body: Consumer<AddtoCartModel>(
        builder: (context, cartModel, child) {
          List<Product> cartProducts = cartModel.favorites;
          double totalPrice = cartProducts.fold(
              0, (previousValue, element) => previousValue + element.price);

          if (cartProducts.isEmpty) {
            return Center(
              child: Text('No products yet.'),
            );
          }

          return Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 10.w, right: 10.w),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(15),
                            tileColor: kColorPrimary3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            leading: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage(cartProducts[index].thumbnail),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.rectangle,
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              cartProducts[index].title,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${cartProducts[index].price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${cartProducts[index].category}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Provider.of<AddtoCartModel>(context,
                                        listen: false)
                                    .addToCart(cartProducts[index]);
                              },
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                    Text(
                      ' \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  ],
                ),
                20.verticalSpace,
                CustomButton(
                  text: 'Place Order',
                  onPressed: () {
                    clearCart();
                    showOrderSuccessDialog(context);
                  },
                  color: kColorPrimary,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
