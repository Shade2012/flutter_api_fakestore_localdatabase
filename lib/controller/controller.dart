import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_fakestore_localdatabase/model/model.dart';
import 'package:flutter_api_fakestore_localdatabase/pages/bland_page.dart';
import 'package:flutter_api_fakestore_localdatabase/pages/favoritepage_view/favoritpage_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductController extends GetxController {
  Database? database;
  RxBool isLoading = false.obs;
  RxList<FakeStore> fakestore = <FakeStore>[].obs;
  RxList<FakeStore> filteredData = <FakeStore>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchProduct();
    initDatabase();
  }

  void fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      isLoading.value = true;
      final result = await Connectivity().checkConnectivity();
      if(result != ConnectivityResult.none){
        if (response.statusCode == 200) {
          fakestore.value = fakeStoreFromJson(response.body);
          filteredData.assignAll(fakestore);
          // saveDataToLocalDatabase(fakestore);
          isLoading.value = false;
        } else {
          print('Error: ${response.statusCode}');
        }
      } else {

      }
    } catch (e) {
      print(e);
    }
  }
  void initDatabase() async {
    String db_name = "db_user";
    int db_version = 1;
    String table = "user";
    String id = "idColumn";
    String idProduct = "id";
    String title = "title";
    String image = "image";
    String price = "price";
    String description = "description";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + db_name;

    if (database == null) {
      database = await openDatabase(path, version: db_version, onCreate: (db, version) {
        print(path);
        db.execute('''
        CREATE TABLE IF NOT EXISTS $table (
              $id INTEGER PRIMARY KEY ,
              $idProduct INTEGER,
              $title VARCHAR(255),
              $image VARCHAR(255),
              $price MEDIUMINT,
              $description VARCHAR(255)
            )''');
      });
    }
  }


  void saveDataToLocalDatabase(FakeStore userModel, BuildContext context) async {
    String table = "user";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_user";
    database = await openDatabase(path);

    try {
      List<Map<String, dynamic>> existingData = await database!.query(table, where: "id = ?", whereArgs: [userModel.id],);
      if(existingData.isEmpty){
        await database!.insert(table, userModel.toJson());
        print("Inserted Data: ${userModel.toJson()}");
        Get.snackbar("Pesan", "Item berhasil dimasukkan ke keranjang");
      }else{
        Get.snackbar("Pesan", "Item sudah ada di keranjang");
      }
    } catch (e) {
      print("Error inserting data into the database: $e");
    }
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword == null || enteredKeyword.isEmpty) {
      filteredData.assignAll(fakestore);
    } else {
      enteredKeyword = enteredKeyword.toLowerCase();
      filteredData.assignAll(fakestore.where((product) {
        return product.title.toLowerCase().contains(enteredKeyword) ||
            product.description.toLowerCase().contains(enteredKeyword);
      }).toList());
    }
  }



  Future<void> delete(int id) async {
    String table = "user";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_user";
    database = await openDatabase(path);

    // SnackBar(content: Text("Item berhasil di hapus"));
    try {
      await database!.delete(table, where: "id = ?", whereArgs: [id]);
      Get.snackbar("Pesan", "Item berhasil dihapus dari keranjang");
      Get.off(Bland());
      Get.off(FavoritePage());
    } catch (e) {
      print("Error deleting data from the database: $e");
    }

  }

  Future<List<FakeStore>> getDataUser() async {
    String table = "user";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_user";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<FakeStore> user = data.map((e) => FakeStore.fromJson(e)).toList();
    return user;
  }



}
