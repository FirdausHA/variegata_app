import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart'; // Import pustaka shimmer
import 'package:variegata_app/pages/Ulasan_Pembeli/Review/Rating.dart';
import 'package:variegata_app/pages/Ulasan_Pembeli/Review/Review.dart';
import 'package:variegata_app/pages/catalog_shop/Toko_Product/Detail_Toko.dart';

class Ulasan extends StatefulWidget {
  final dynamic product;

  const Ulasan({Key? key, required this.product}) : super(key: key);

  @override
  State<Ulasan> createState() => _UlasanState();
}

class _UlasanState extends State<Ulasan> {
  String _name = '';
  List<dynamic?> reviews = List.filled(10, null); // Placeholder untuk 10 ulasan

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchReviews(widget.product['id']);
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
    });
  }

  Future<String?> _getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _fetchReviews(int productId) async {
    final String? authToken = await _getAuthToken();

    final url = Uri.parse('https://variegata.my.id/api/reviews?product_id=$productId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final fetchedReviews = json.decode(response.body);
      setState(() {
        reviews = fetchedReviews;
      });
    } else {
      print('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    String productName = widget.product['name'];
    String productImage = widget.product['image'];

    return Scaffold(
      backgroundColor: Color(0xFFF6F7FA),
      appBar: AppBar(
        title: Text(
          "Ulasan Pembeli",
          style: TextStyle(color: Color(0xFF33363F)),
        ),
        backgroundColor: Color(0xFFF6F7FA),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF33363F),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailProduk(product: widget.product),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image(
                    image: NetworkImage(
                      'https://variegata.my.id/storage/$productImage',
                    ),
                    width: 39,
                    height: 39,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 290,
                  child: Text(
                    productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 3,
            color: Color(0xFFD9D9D9),
          ),
          Expanded(
            child: reviews.isEmpty
                ? Center(child: Text('Belum ada ulasan.'))
                : ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                if (reviews[index] == null) {
                  // Tampilkan placeholder shimmer saat data sedang dimuat
                  return ShimmerReviewItem();
                } else {
                  // Tampilkan data sebenarnya setelah dimuat
                  final review = reviews[index];
                  final rating = review['rating'];
                  final comment = review['comment'];

                  return Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF90AF9D),
                              ),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xFFECF4EB),
                              ),
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star,
                                      color: Color(0xFFFFC400),
                                      size: 15,
                                    ),
                                  ).sublist(0, int.parse(rating)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 290,
                                  child: Text(
                                    comment,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Color(0xFFD9D9D9),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Rating(product: widget.product),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffa3bfae),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "BERIKAN KOMENTAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerReviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.person,
                  color: Color(0xFF90AF9D),
                ),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFECF4EB),
                ),
              ),
              SizedBox(
                width: 17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 290,
                      height: 60,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Color(0xFFD9D9D9),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
