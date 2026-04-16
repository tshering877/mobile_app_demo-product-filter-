import 'package:flutter/material.dart';
import 'product_model.dart';
import 'product_data.dart';

class ProductFilterPage_6608985 extends StatefulWidget {
  @override
  _ProductFilterPage_6608985State createState() =>
      _ProductFilterPage_6608985State();
}

class _ProductFilterPage_6608985State
    extends State<ProductFilterPage_6608985> {

  List<ProductModel_6608985> products =
  ProductData_6608985.getProducts();

  List<ProductModel_6608985> filteredProducts = [];
  String searchText = "";
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void filterProducts() {
    setState(() {
      filteredProducts = products.where((product) {
        final matchesSearch = product.name
            .toLowerCase()
            .contains(searchText.toLowerCase());

        final matchesCategory =
            selectedCategory == "All" ||
                product.category == selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  //Rating stars
  Widget buildStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: 14);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: 14);
        } else {
          return Icon(Icons.star_border, size: 14);
        }
      }),
    );
  }

  //Category chip
  Widget buildChip(String label) {
    bool isSelected = selectedCategory == label;

    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            selectedCategory = label;
            filterProducts();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    List<String> categories = [
      "All",
      "Smartphone",
      "Tablet",
      "Laptop",
      "Accessory",
      "Camera"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Tech shop"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            //SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchText = value;
                filterProducts();
              },
            ),

            SizedBox(height: 10),

            //CATEGORY
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map(buildChip).toList(),
              ),
            ),

            SizedBox(height: 10),

            //PRODUCT LIST
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {

                  final product = filteredProducts[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [

                        // IMAGE
                        Image.asset(
                          product.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),

                        SizedBox(width: 10),

                        //DETAILS
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              // NAME
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),

                              SizedBox(height: 5),

                              // CATEGORY
                              Text(
                                product.category,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),

                              SizedBox(height: 5),

                              //RATING
                              buildStars(product.rating),

                              SizedBox(height: 5),

                              //PRICE + DISCOUNT
                              Text(
                                "฿ ${product.price}  (-${product.discountPercent}%)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        //ICON
                        Icon(Icons.shopping_cart_outlined),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}