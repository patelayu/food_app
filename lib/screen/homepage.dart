
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../Globals/allproducts.dart';
import '../contraller/productcontraller.dart';
import '../helper/dbhelper.dart';

import '../model/products.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDark = false;

  ProductController productController = Get.put(ProductController());

  Future? getData;

  @override
  void initState() {
    getData = DBHelper.dbHelper.fetchAllRecode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce App"),
        centerTitle: true,
        backgroundColor: Color(0xffC19A6B),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              setState(() {});
            },
            icon: (Get.isDarkMode)
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/CartPage");
            },
            icon: const Icon(Icons.shopping_cart_checkout_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.add_location_alt, color: Color(0xffC19A6B)),
                const SizedBox(width: 3),
                Text(
                  "Surat,Gujarat",
                  style: TextStyle(color: Colors.grey, fontSize: w * 0.05),
                ),
                SizedBox(width: w * 0.2),

              ],
            ),
            SizedBox(height: h * 0.02),
            const Text("Hi,Ayush",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff7F5A58),
                    fontWeight: FontWeight.bold)),
            SizedBox(height: h * 0.016),
            Text(
              "Find Your Food",
              style: TextStyle(
                fontSize: w * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: h * 0.02),
            Container(
              height: h * 0.07,
              decoration: BoxDecoration(
                  color: Color(0xffF8B88B),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  SizedBox(width: w * 0.01),
                  const Icon(Icons.search, color: Color(0xff614051)),
                  const Text(
                    " Search Food",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff614051),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            FutureBuilder(
              future: getData,
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.hasError) {
                  return Center(
                    child: Text(
                      "Error : ${snapShot.error}",
                    ),
                  );
                } else if (snapShot.hasData) {
                  List<ProductDB> data = snapShot.data;

                  return Expanded(
                    child: GridView.builder(
                      itemCount: Global.food.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                        MediaQuery.of(context).size.width / 2,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          elevation: 5,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: h * 0.6,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.vertical(
                                          top: Radius.circular(25),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "${Global.food[i].image}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "RS: ${Global.food[i].price}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Text(
                                          "30min",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${Global.food[i].name}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            productController.addProduct(
                                                product: Global.food[i]);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffF8B88B),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomRight:
                                                Radius.circular(25),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}