import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Detail_Toko.dart';
import 'package:variegata_app/pages/dashboard/Dashboard-Katalog.dart';

class Product extends StatefulWidget {
  Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

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

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: BoxDecoration(
        color: Color(0xFFDBE4C6),
        image: DecorationImage(
          image: AssetImage('assets/img/dashboard/bg-daun.png'),
          fit: BoxFit.cover, // Atur properti fit
          alignment: Alignment.topLeft, // Atur posisi kiri atas
          repeat: ImageRepeat.repeat, // Ulangi gambar (opsional)
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Text(
              'Belanja Kebutuhan Lahan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Lengkap, terjamin asli, dan mudah.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Products(
                  'phildoderon.png',
                  'Tanaman pelhedoran Asli langsung dari perkebunan',
                  'Rp.10000',
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KatalogShop(),
                  ),
                );
              },
              child: Text(
                'Lihat Semua',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.0,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Products(String image, String title, String price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: FutureBuilder<List<dynamic>>(
        future: fetchProducts(),
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
            return Center(child: Text('Data error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            final products = snapshot.data!.take(5).toList();
            return Container(
              height: 231, // Height of the container
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Scroll horizontally
                itemCount: products.length, // Use all available items
                itemBuilder: (context, index) {
                  var product = snapshot.data![index];
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration( color: Colors.white,
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
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(5),),
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
                              Container(padding: EdgeInsets.symmetric(horizontal: 9),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
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
                                        Icon(
                                          Icons.star,
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
                                mainAxisAlignment:
                                MainAxisAlignment.end,
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
    );
  }
}
