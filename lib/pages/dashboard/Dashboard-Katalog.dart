import "package:flutter/material.dart";
import "package:variegata_app/common/widget/bottom_navbar.dart";
import "package:variegata_app/common/widget/iklan_carousel.dart";
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Detail_Toko.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Toko_Alat.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Toko_Benih.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Toko_Pestisida.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Toko_Pupuk.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Toko_Tanaman.dart';
import 'package:variegata_app/pages/catalog_shop/Keranjang/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class KatalogShop extends StatefulWidget {
  const KatalogShop({super.key});

  @override
  State<KatalogShop> createState() => _KatalogShopState();
}

class _KatalogShopState extends State<KatalogShop> {
  List<Map<String, dynamic>> data = [];

  String apiUrl = 'https://variegata.my.id/api/products/category/1';
  bool isLoading = true;

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  final String Url = 'https://variegata.my.id/api/products/category/2';
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF33363F),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BotNavbar(),
              ),
            );
          },
        ),
        title: Text(
          "Toko Variegata",
          style: TextStyle(color: Color(0xFF33363F)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            color: Color(0xFF33363F),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // child: Search_box()
                ),
                Iklan_carousel(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopTanaman(),
                            ));
                      },
                      child: katalog(
                        'katalog_tanaman.png',
                        'Tanaman',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopBenih(),
                            ));
                      },
                      child: katalog(
                        'katalog_benih.png',
                        'Benih',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopPupuk(),
                            ));
                      },
                      child: katalog(
                        'katalog_pupuk.png',
                        'Pupuk',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopPestisida(),
                            ));
                      },
                      child: katalog(
                        'katalog_pestisida.png',
                        'Pestisida',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopAlat(),
                            ));
                      },
                      child: katalog(
                        'katalog_alat.png',
                        'Alat',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            width: MediaQuery.of(context).size.width,
                            height: 99,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage('assets/img/bg-ktg1.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Toko Variegata',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Cari Kebutuhan Berkebun mu\ndengan cara yang mudah',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: FutureBuilder<List<dynamic>>(
                            future: fetchProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.length ?? 10,// You can set this to any number of items you want to show initially
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 120,
                                        height: 231,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        margin: EdgeInsets.only(left: 8),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center(child:Text('Data error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No data available.'));
                              } else {
                                return Container(
                                  height: 231, // Height of the container
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal, // Scroll horizontally
                                    itemCount: snapshot.data!.length, // Use all available items
                                    itemBuilder: (context, index) {
                                      var product = snapshot.data![index];
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: -4,
                                                  blurRadius: 14,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => DetailProduk(product: product),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.vertical(top: Radius.circular(5),),
                                                    child: Image.network(
                                                      'https://variegata.my.id/storage/${product['image']}',
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Icon(Icons.error);
                                                      },
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: 110,
                                                    ),
                                                  ),
                                                  SizedBox(height: 9,),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 9),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          product['name'],
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(height: 9,),
                                                        Text(
                                                          '\Rp.${product['price']}',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(height: 9,),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color: Color(0xFFBBD6B8),
                                                              size: 15,
                                                            ),
                                                            SizedBox(width: 2,),
                                                            Text(
                                                              'Kudus',
                                                              style: TextStyle(
                                                                color: Color(0xFFADADAD),
                                                                fontSize: 9,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 2),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                              color: Color(0xFFFFC400),
                                                              size: 10,
                                                            ),
                                                            SizedBox(width: 2,),
                                                            Text(
                                                              '4.9 | Belum Terjual',
                                                              style: TextStyle(
                                                                color: Color(0xFFADADAD),
                                                                fontSize: 9,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Icon(Icons.more_horiz,
                                                        color: Color(0xFFADADAD),
                                                        size: 20,
                                                      ),
                                                      SizedBox(width: 5,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            width: MediaQuery.of(context).size.width,
                            height: 99,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage('assets/img/bg-ktg1.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Barang Terlaris',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Cari Kebutuhan Berkebun mu\ndengan cara yang mudah',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: FutureBuilder<List<dynamic>>(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.length ?? 10,
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 120,
                                        height: 231,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        margin: EdgeInsets.only(left: 8),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center( child: Text('Data error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No data available.'));
                              } else {
                                return Container(
                                  height: 231, // Height of the container
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal, // Scroll horizontally
                                    itemCount: snapshot.data!.length, // Use all available items
                                    itemBuilder: (context, index) {
                                      var product = snapshot.data![index];
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: -4,
                                                  blurRadius: 14,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => DetailProduk(product: product),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.vertical(top: Radius.circular(5),
                                                    ),
                                                    child: Image.network(
                                                      'https://variegata.my.id/storage/${product['image']}',
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Icon(Icons.error);
                                                      },
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: 110,
                                                    ),
                                                  ),
                                                  SizedBox(height: 9,),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 9),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          product['name'],
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(height: 9,),
                                                        Text(
                                                          '\Rp.${product['price']}',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 9,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.location_on,
                                                              color: Color(0xFFBBD6B8),
                                                              size: 15,
                                                            ),
                                                            SizedBox(width: 2,),
                                                            Text(
                                                              'Kudus',
                                                              style: TextStyle(
                                                                color: Color(0xFFADADAD),
                                                                fontSize: 9,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 2),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                              color: Color(0xFFFFC400),
                                                              size: 10,
                                                            ),
                                                            SizedBox(width: 2,),
                                                            Text(
                                                              '4.9 | Belum Terjual',
                                                              style: TextStyle(
                                                                color: Color(0xFFADADAD),
                                                                fontSize: 9,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons.more_horiz,
                                                        color: Color(0xFFADADAD),
                                                        size: 20,
                                                      ),
                                                      SizedBox(width: 5,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget katalog(String image, String title) {
    return Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: 48,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset('assets/img/$image'),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
    }
}