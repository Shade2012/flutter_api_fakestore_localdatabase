import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_api_fakestore_localdatabase/controller/imageslide_Controller.dart';
import 'package:flutter_api_fakestore_localdatabase/utils/theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controller/controller.dart';
import '../../model/model.dart';
class ImageSlider extends StatelessWidget {
  final ImageSlideController productController = Get.put(ImageSlideController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
         children: [
           Container(
             alignment: Alignment.topLeft,
               child: Text("New Release ",style: HeadingText,)),
           Obx(
                () => CarouselSlider(
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: productController.products.map((FakeStore product) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width, // or set width to double.infinity
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity, // or set width to MediaQuery.of(context).size.width
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                              color: Colors.black.withOpacity(0.5),
                            ),

                            child: Text(
                              product.title,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
      ),
         ],
       ),
    );
  }
}

