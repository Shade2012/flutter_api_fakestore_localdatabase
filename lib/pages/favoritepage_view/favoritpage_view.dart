import 'package:flutter/material.dart';
import 'package:flutter_api_fakestore_localdatabase/controller/controller.dart';
import 'package:flutter_api_fakestore_localdatabase/model/model.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Favorit"),
        centerTitle: true,
      ),
      body:  FutureBuilder<List<FakeStore>>(
              future: controller.getDataUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      FakeStore user = snapshot.data![index];
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
                                    child: Icon(Icons.delete_forever)
                                ),
                                onTap: () async {
                                  await controller.delete(user.id);

                                },
                              ),

                              Container(
                                padding: EdgeInsets.only(top: 20),
                                width: 200,
                                child:FadeInImage(
                                  placeholder: AssetImage("asset/image_placeholder.png"),
                                  image:  NetworkImage(user.image,),
                                  fit: BoxFit.cover,
                                ),

                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white
                                ),
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                // Set the background color of the inner container
                                child: Text(
                                  user.title,
                                  style: Normaltext
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Tidak Ada Data"));
                }
              },
            ),


      );
  }
}
