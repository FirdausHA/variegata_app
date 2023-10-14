import 'package:flutter/material.dart';
import 'package:variegata_app/pages/ProfilContent/Riwayat.dart';

class Ulasan extends StatefulWidget {
  const Ulasan({super.key});

  @override
  State<Ulasan> createState() => _UlasanState();
}

class _UlasanState extends State<Ulasan> {
  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(
                  builder: (context) => RiwayatPembelian(),
                ),
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
                      image: AssetImage("assets/img/produk_bawang.jpg"),
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
                      'Tanaman Philodendron Monstera Deliciosa',
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
                            "Firdaus",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: List.generate(
                              3,
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
                              'terserah deh',
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
        ));
  }
}