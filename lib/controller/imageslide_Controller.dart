import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/model.dart';
class ImageSlideController extends GetxController{
  final RxList<FakeStore> products = <FakeStore>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchImage();
  }
  void fetchImage() async {
    final response = await http.get( Uri.parse ('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productList = json.decode(response.body);

      // Take only the first 5 products
      final List<FakeStore> firstFiveProducts = productList
          .take(5)
          .map((productData) => FakeStore.fromJson(productData))
          .toList();

      products.addAll(firstFiveProducts);
      }
    }
  }

