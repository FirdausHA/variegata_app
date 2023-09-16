import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

import 'package:variegata_app/pages/budidaya/Detail_Hama.dart';

class HamaPenyakit extends StatefulWidget {
  final int plantId;
  HamaPenyakit({Key? key, required this.plantId}) : super(key: key);

  @override
  _HamaPenyakitState createState() => _HamaPenyakitState();
}

class _HamaPenyakitState extends State<HamaPenyakit> {
  bool isLoading = true;

  Future<List<dynamic>> fetchHama() async {
    final apiUrl = 'https://variegata.my.id/api/hamas/plants/${widget.plantId}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      return json.decode(response.body);
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load products');
    }
  }

  Future<void> _refreshProducts() async {
    setState(() {
      isLoading = true;
    });
    await fetchHama();
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildShimmerProductCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.3,
                    blurRadius: 20,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 12,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 80,
                  height: 10,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 50,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 30,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daftar Hama & Penyakit",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Tanaman rentan terhadap serangan hama dan penyakit yang dapat mengancam pertumbuhan dan hasil panen.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<dynamic>>(
                  future: fetchHama(),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (isLoading) {
                      return _buildShimmerProductCard(); // Placeholder Shimmer
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text('No data available');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailHamaPenyakit(product: product),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 0.3,
                                          blurRadius: 20,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: 'https://variegata.my.id/storage/${product['image']}',
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        product['tipe'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Image(
                                              image: AssetImage('assets/img/hama_icon.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Hama",
                                            style: TextStyle(
                                              color: Color(0xff7f7f7f),
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
