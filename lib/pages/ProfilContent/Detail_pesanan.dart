import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:variegata_app/pages/ProfilContent/Riwayat.dart';

class Detail_transaksi extends StatefulWidget {
  final Map<String, dynamic> transaction;
  const Detail_transaksi({super.key, required this.transaction,});

  @override
  State<Detail_transaksi> createState() => _Detail_transaksiState();
}

class _Detail_transaksiState extends State<Detail_transaksi> {
  String formatPrice(String price) {
    double parsedPrice = double.tryParse(price) ?? 0.0;

    String formattedPrice = 'Rp ' +
        parsedPrice.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
        );

    return formattedPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FA),
      appBar: AppBar(
        title: Text(
          "Detail Pemesanan",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Color(0xFFE2F4E9),
                          borderRadius: BorderRadius.circular(3)),
                      child: Center(
                        child: Text(
                          "Sudah Bayar",
                          style: TextStyle(
                              color: Color(0xFF458A61),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xFFD9D9D9),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal Pembelian",
                          style: TextStyle(
                              color: Color(0xFFADADAD),
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                            DateFormat('dd, MMMM yyyy').format(DateTime.parse(widget.transaction['created_at'])),
                          style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Belanja",
                          style: TextStyle(
                              color: Color(0xFFADADAD),
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          formatPrice(widget.transaction['total_price']),
                          style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 6,
                color: Color(0xFFD9D9D9),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ringkasan Pemesanan",
                      style: TextStyle(
                        color: Color(0xFF505050),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 355,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFDBDBDB),
                              offset: Offset(0, 0),
                              blurRadius: 9,
                              spreadRadius: -4,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, right: 15, bottom: 15),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image(
                                    image: AssetImage(
                                        "assets/img/dashboard/Wortel.jpg"),
                                    width: 47,
                                    height: 47,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 260,
                                        child: Text(
                                          'Wortel Segar Asli Langsung dari perkebunan petani',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                        "${widget.transaction['qty']} Produk",
                                        style: TextStyle(
                                          color: Color(0xFFADADAD),
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 6,
                color: Color(0xFFD9D9D9),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Info Pengiriman",
                      style: TextStyle(
                        color: Color(0xFF505050),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Alamat",
                                style: TextStyle(
                                    color: Color(0xFFADADAD),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Firdaus",
                              style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "082314127929",
                              style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 225,
                              child: Text(
                                "Daerah Besito Gang 10,Rumah warna abu - abu gerbang warna hitam, kec. gebog kab. gebog Kota Kudus",
                                style: TextStyle(
                                    color: Color(0xFF505050),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 6,
                color: Color(0xFFD9D9D9),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rincian Pembayaran",
                      style: TextStyle(
                        color: Color(0xFF505050),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Belanja",
                          style: TextStyle(
                            color: Color(0xFF505050),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          formatPrice(widget.transaction['total_price']),
                          style: TextStyle(
                            color: Color(0xFF505050),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}