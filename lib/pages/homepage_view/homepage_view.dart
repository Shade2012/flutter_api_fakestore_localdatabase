import 'package:flutter/material.dart';
import 'package:flutter_api_fakestore_localdatabase/controller/controller.dart';
import 'package:flutter_api_fakestore_localdatabase/pages/favoritepage_view/favoritpage_view.dart';
import 'package:flutter_api_fakestore_localdatabase/pages/homepage_view/imageSlider.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';


class Homepage extends StatelessWidget {
  final controller = Get.put(ProductController());

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.1,
        actions: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  controller.runFilter(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),

                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              )

            ),
          ),
          IconButton( onPressed: () {
            Get.to(() => FavoritePage());
          } , icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: ImageSlider(),
          ),
          Obx(
                () => controller.isLoading.value
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                final product = controller.filteredData[index];
                return Container(
                  margin: EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                              padding: EdgeInsets.all(30),
                              alignment: Alignment.topRight,
                              child: Icon(Icons.add_shopping_cart)),
                          onTap: () {
                            controller.saveDataToLocalDatabase(
                                product, context);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          width: 200,
                          height: 200,
                          child: Image.network(product.image),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Text(
                            product.title,
                            style: Normaltext,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}



