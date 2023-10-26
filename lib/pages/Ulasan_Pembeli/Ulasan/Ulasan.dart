import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:variegata_app/pages/Ulasan_Pembeli/Review/Review.dart';

class UlasanPembeli extends StatefulWidget {
  final dynamic product;
  const UlasanPembeli({super.key,required this.product});

  @override
  State<UlasanPembeli> createState() => _UlasanPembeliState();
}

class _UlasanPembeliState extends State<UlasanPembeli> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
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
            "Ulasan Pembeli",
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
              thickness: 3,
              color: Color(0xFFD9D9D9),
            ),
            Container(
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
                        width: 38,
                        height: 38,
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
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: List.generate(
                              5,
                                  (index) => Icon(
                                Icons.star,
                                color: Color(0xFFFFC400),
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 290,
                            child: Text(
                              'Apa aja lah ya',
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
                        ],
                      ),
                    ],
                  ),
                ],
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
                    MaterialPageRoute( builder: (context) => NilaiProduk(product: widget.product,),
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