import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:variegata_app/pages/ProfilContent/Riwayat.dart';
import 'package:flutter/services.dart';
import 'package:variegata_app/pages/Ulasan_Pembeli/Ulasan/Ulasan.dart';


class NilaiProduk extends StatefulWidget {
  final dynamic product;
  const NilaiProduk({super.key, required this.product});

  @override
  State<NilaiProduk> createState() => _NilaiProdukState();
}


class _NilaiProdukState extends State<NilaiProduk> {

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
                      'https://variegata.my.id/storage/$productImage', // Menggunakan image dari jaringan
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
                      initialRating: 0,
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
                        print(rating);
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
                    maxLines: 3,
                    maxLength: 60,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          60), // Ganti dengan jumlah kata yang diinginkan
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
            Navigator.pop(
              context,
              // MaterialPageRoute(
              //     builder: (context) => const UlasanPembeli()),
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