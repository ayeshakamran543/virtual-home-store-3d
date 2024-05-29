import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/AppConstants.dart';
import 'package:fyp_project/Provider/AddToCartProvider.dart';
import 'package:fyp_project/Screens/AuthScreens/CustomAuthWidgets.dart';
import 'package:fyp_project/Screens/ModelViewer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductsTab extends StatelessWidget {
  final String name;
  final Map<int, Product> products;

  const ProductsTab({super.key, required this.products, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: kStyleBlack22600.copyWith(color: kColorWhite)),
        centerTitle: true,
        backgroundColor: kColorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        iconTheme: IconThemeData(color: kColorWhite),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return buildProductCard(context, products.values.toList()[index]);
        },
      ),
    );
  }

  Widget buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        navigateToProductDetails(context, product);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 4,
          color: kColorPrimary3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                product.thumbnail,
                height: 200.h,
                fit: BoxFit.cover,
                width: 350.w,
              ),
              ListTile(
                tileColor: kColorPrimary3,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' \$${product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${product.rating}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 5.0, left: 5.0),
                          child: buildStarRating(product.rating),
                        ),
                      ],
                    ),
                    Text(
                      'By ${product.brand}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'In ${product.category}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CustomButton(
                        text: 'View In AR',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModelViewerScreen(
                                modelPath: product.modelPath,
                              ),
                            ),
                          );

                          // Get.to(() => ModelViewerScreen(
                          //       modelPath: product.modelPath,
                          //     ));
                        },
                        color: kColorPrimary)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStarRating(double rating) {
    int numberOfStars = rating.toInt();
    List<Widget> stars = List.generate(
      numberOfStars,
      (_) => Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: 20,
      ),
    );
    if (rating - numberOfStars >= 0.5) {
      stars.add(
        Icon(
          Icons.star_half,
          color: Colors.amberAccent,
          size: 20,
        ),
      );
    }
    return Row(children: stars);
  }

  void navigateToProductDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetails(product: product)),
    );
  }
}

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  void showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('Your product is added to cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: kColorPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddtoCartModel>(builder: (context, favoritesModel, child) {
      final cart = Provider.of<AddtoCartModel>(context);
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: kColorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15.r),
            ),
          ),
          iconTheme: IconThemeData(color: kColorWhite),
          title: Center(
            child: Text('Product Details',
                style: kStyleBlack22600.copyWith(color: kColorWhite)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                widget.product.thumbnail,
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Details:',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kColorPrimary),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Name:  ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          widget.product.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Price:  ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Category:  ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          widget.product.category,
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Brand:  ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '${widget.product.brand}',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Rating: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '${widget.product.rating}',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 5.0, left: 5.0),
                          child: buildStarRating(widget.product.rating),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Stock: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '${widget.product.stock} ',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Description: ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: kColorPrimary),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${widget.product.description}',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Product Gallery : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: kColorPrimary,
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Transform.translate(
                              offset: Offset(0, 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: widget.product.images
                                    .asMap()
                                    .entries
                                    .where((entry) => entry.key.isEven)
                                    .map((entry) {
                                  int index = entry.key;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Image.asset(
                                      widget.product.images[index],
                                      height: 200.h,
                                      width: 210.w,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...widget.product.images
                                    .asMap()
                                    .entries
                                    .where((entry) => entry.key.isOdd)
                                    .map((entry) {
                                  int index = entry.key;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Image.asset(
                                      widget.product.images[index],
                                      height: 210.h,
                                      width: 210.w,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                                SizedBox(
                                  height: 40.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Consumer<AddtoCartModel>(
                      builder: (context, cart, child) {
                        return CustomButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            showAddToCartDialog(context);
                            cart.addToCart(widget.product);
                          },
                          color: kColorPrimary,
                        );
                      },
                    ),
                    SizedBox(
                      height: 45,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget buildStarRating(double rating) {
  int numberOfStars = rating.toInt();
  List<Widget> stars = List.generate(
    numberOfStars,
    (_) => Icon(
      Icons.star,
      color: Colors.amberAccent,
      size: 20,
    ),
  );
  if (rating - numberOfStars >= 0.5) {
    stars.add(
      Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: 20,
      ),
    );
  }
  return Row(children: stars);
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final String modelPath; // Added model path

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.modelPath, // Added model path
  });
}

Map<int, Product> tileProducts = {
  1: Product(
    id: 1,
    title: 'Black Floor Tile',
    description: 'Black floor tile suitable for modern interiors.',
    price: 25.0,
    discountPercentage: 0.0,
    rating: 4.8,
    stock: 50,
    brand: 'FloorLux',
    category: 'Tiles',
    thumbnail: 'asset/images/blackTile2.jpg',
    images: [
      'asset/images/blackTile1.jpg',
      'asset/images/blackTile3.jpg',
    ],
    modelPath: 'asset/models/blackTile.glb', // Example model path
  ),
  2: Product(
    id: 2,
    title: 'White Floor Tile',
    description: 'White floor tile perfect for classic interiors.',
    price: 30.0,
    discountPercentage: 5.0,
    rating: 4.7,
    stock: 40,
    brand: 'FloorElegance',
    category: 'Tiles',
    thumbnail: 'asset/images/WhiteTile1.jpg',
    images: [
      'asset/images/WhiteTile2.jpg',
      'asset/images/WhiteTile3.jpg',
    ],
    modelPath: 'asset/models/whiteTile.glb', // Example model path
  ),
  3: Product(
    id: 3,
    title: 'Grey Floor Tile',
    description: 'Grey floor tile ideal for contemporary designs.',
    price: 28.0,
    discountPercentage: 0.0,
    rating: 4.6,
    stock: 45,
    brand: 'FloorModern',
    category: 'Tiles',
    thumbnail: 'asset/images/GreyTile1.jpg',
    images: [
      'asset/images/GreyTile2.jpg',
      'asset/images/GreyTile3.jpg',
    ],
    modelPath: 'asset/models/greyTile.glb', // Example model path
  ),
};
////////////////////////////////////////marbleProducts////////////////////////////////////////
Map<int, Product> marbleProducts = {
  1: Product(
    id: 1,
    title: 'Marble',
    description:
        'Luxurious cream-colored marble slab, perfect for elegant interiors.',
    price: 150.0,
    discountPercentage: 0.0,
    rating: 4.9,
    stock: 30,
    brand: 'MarbleLux',
    category: 'Marble',
    thumbnail: 'asset/images/marble.jpg',
    images: [
      'asset/images/marble2.jpg',
      'asset/images/marble3.jpg',
    ],
    modelPath: 'asset/models/marble.glb',
  ),
};
////////////////////////////////////////electronicProducts////////////////////////////////////////
Map<int, Product> electronicsProducts = {
  1: Product(
    id: 1,
    title: 'Washing Machine',
    description:
        'Efficient front-load washing machine with multiple wash cycles.',
    price: 499.0,
    discountPercentage: 10.0,
    rating: 4.5,
    stock: 20,
    brand: 'WashTech',
    category: 'Electronics',
    thumbnail: 'asset/images/WashingMachine1.jpg',
    images: [
      'asset/images/WashingMachine2.jpg',
      'asset/images/WashingMachine3.jpg',
    ],
    modelPath: 'asset/models/machine.glb', // Example model path
  ),
  2: Product(
    id: 2,
    title: '4K Smart TV',
    description:
        'Immerse yourself in stunning 4K resolution with this smart TV.',
    price: 799.0,
    discountPercentage: 15.0,
    rating: 4.8,
    stock: 15,
    brand: 'TechVision',
    category: 'Electronics',
    thumbnail: 'asset/images/TV1.jpg',
    images: [
      'asset/images/TV2.jpg',
      'asset/images/TV3.jpg',
    ],
    modelPath: 'asset/models/tv.glb', // Example model path
  ),
  3: Product(
    id: 3,
    title: 'Refrigerator',
    description:
        'Spacious and energy-efficient French door refrigerator for your kitchen.',
    price: 1499.0,
    discountPercentage: 5.0,
    rating: 4.7,
    stock: 25,
    brand: 'CoolTech',
    category: 'Electronics',
    thumbnail: 'asset/images/Fridge1.jpg',
    images: [
      'asset/images/Fridge2.jpg',
      'asset/images/Fridge3.jpg',
    ],
    modelPath: 'asset/models/fridge.glb', // Example model path
  ),
};
////////////////////////////////////////furnitureProducts////////////////////////////////////////
Map<int, Product> furnitureProducts = {
  1: Product(
    id: 1,
    title: 'Black Sofa',
    description: 'Elegant black sofa to enhance your living room decor.',
    price: 500.0,
    discountPercentage: 0.0,
    rating: 4.6,
    stock: 10,
    brand: 'ComfortHome',
    category: 'Furniture',
    thumbnail: 'asset/images/BlackSofa1.jpg',
    images: [
      'asset/images/BlackSofa2.jpg',
      'asset/images/BlackSofa3.jpg',
    ],
    modelPath: 'asset/models/sofa.glb', // Example model path
  ),
  2: Product(
    id: 2,
    title: 'Simple Brown Chair',
    description: 'Classic brown chair for a cozy corner in your home.',
    price: 149.0,
    discountPercentage: 0.0,
    rating: 4.3,
    stock: 15,
    brand: 'HomeEssentials',
    category: 'Furniture',
    thumbnail: 'asset/images/chair1.jpg',
    images: [
      'asset/images/chair1.jpg',
      'asset/images/chair1.jpg',
    ],
    modelPath: 'asset/models/chair.glb', // Example model path
  ),
  3: Product(
    id: 3,
    title: 'Brown Table',
    description: 'Sturdy brown table perfect for your dining or living area.',
    price: 299.0,
    discountPercentage: 0.0,
    rating: 4.5,
    stock: 20,
    brand: 'FurniCraft',
    category: 'Furniture',
    thumbnail: 'asset/images/table1.jpg',
    images: [
      'asset/images/table2.jpg',
      'asset/images/table3.jpg',
    ],
    modelPath: 'asset/models/table.glb', // Example model path
  ),
};
////////////////////////////////////////Doors////////////////////////////////////////
Map<int, Product> doorProducts = {
  1: Product(
    id: 1,
    title: 'Black Door',
    description: 'Stylish black door to add sophistication to your entryway.',
    price: 299.0,
    discountPercentage: 0.0,
    rating: 4.7,
    stock: 10,
    brand: 'ModernHome',
    category: 'Doors',
    thumbnail: 'asset/images/blackDoor1.jpg',
    images: [
      'asset/images/blackDoor2.jpg',
      'asset/images/blackDoor3.jpg',
    ],
    modelPath: 'asset/models/blackDoor.glb', // Example model path
  ),
  2: Product(
    id: 2,
    title: 'Brown Door',
    description:
        'Classic brown door suitable for traditional and modern homes.',
    price: 349.0,
    discountPercentage: 0.0,
    rating: 4.6,
    stock: 12,
    brand: 'HeritageDoors',
    category: 'Doors',
    thumbnail: 'asset/images/BrwnDoor1.jpg',
    images: [
      'asset/images/brownDoor2.jpg',
      'asset/images/brownDoor3.jpg',
    ],
    modelPath: 'asset/models/brownDoor.glb', // Example model path
  ),
  3: Product(
    id: 3,
    title: 'White Door',
    description:
        'Clean and minimalist white door for a fresh look in your home.',
    price: 279.0,
    discountPercentage: 0.0,
    rating: 4.8,
    stock: 15,
    brand: 'PureLiving',
    category: 'Doors',
    thumbnail: 'asset/images/whiteDoor1.jpg',
    images: [
      'asset/images/whiteDoor2.jpg',
      'asset/images/whiteDoor3.jpg',
    ],
    modelPath: 'asset/models/whiteDoor.glb', // Example model path
  ),
};
