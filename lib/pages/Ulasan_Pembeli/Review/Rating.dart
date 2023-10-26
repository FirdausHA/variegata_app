import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Ulasan/Data_Ulasan.dart';

class Rating extends StatefulWidget {
  final dynamic product;
  const Rating({Key? key, required this.product}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double selectedRating = 0;
  TextEditingController commentController = TextEditingController();

  bool isSubmitting = false;

  Future<String?> _getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> submitReview(double rating, String comment) async {
    setState(() {
      isSubmitting = true;
    });

    final String? authToken = await _getAuthToken();

    String apiUrl = 'https://variegata.my.id/api/reviews'; // Ganti dengan URL endpoint Anda
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken', // Ganti dengan token autentikasi jika diperlukan
    };
    Map<String, dynamic> data = {
      'rating': rating,
      'comment': comment,
      'product_id': widget.product['id'], // Sesuaikan dengan bagaimana Anda mengambil product_id
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // Jika request berhasil, Anda dapat menangani respons di sini
      print('Review submitted successfully');
      // Tampilkan dialog sukses
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Penilaian Berhasil Terbuat'),
            content: Text('Terima kasih telah memberi penilaian kepada produk kami.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog sukses
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ulasan(product: widget.product,)),
                  );
                },
                child: Text('Lanjut'),
              ),
            ],
          );
        },
      );
    } else {
      // Jika request gagal, Anda dapat menangani kesalahan di sini
      print('Failed to submit review. Error: ${response.statusCode}');
      // Beri tahu pengguna bahwa terjadi kesalahan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gagal Mengirim Penilaian'),
            content: Text('Terjadi kesalahan saat mengirim penilaian. Silakan coba lagi nanti.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog kesalahan
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
    }

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String productName = widget.product['name'];
    String productImage = widget.product['image'];

    return Scaffold(
      backgroundColor: Color(0xFFF6F7FA),
      appBar: AppBar(
        title: Text(
          "Nilai Produk",
          style: TextStyle(color: Color(0xFF33363F)),
        ),
        backgroundColor: Color(0xFFF6F7FA),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF33363F),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 6,
            color: Color(0xFFD9D9D9),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Kualitas Produk",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RatingBar.builder(
                      initialRating: selectedRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          selectedRating = rating;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Bagikan Pendapat Anda",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: commentController,
                    maxLines: 3,
                    maxLength: 60,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(60),
                    ],
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GestureDetector(
          onTap: () {
            submitReview(selectedRating, commentController.text);
            // Tampilkan indikator kemajuan saat mengirim ulasan
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Penilaian sedang dikirim...'),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            child: Center(
              child: Text(
                "KIRIM",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xffa3bfae),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
