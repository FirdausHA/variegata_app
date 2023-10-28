import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:variegata_app/pages/ProfilContent/Detail%20Pemesanan.dart';
import 'package:variegata_app/pages/ProfilContent/Detail_pesanan.dart';
import 'package:variegata_app/pages/ProfilContent/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransactionListScreen(),
    );
  }
}

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  Future<String?> _getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<List<dynamic>> fetchUserTransactions(String token) async {
    final String? authToken = await _getAuthToken();

    final response = await http.get(
      Uri.parse('https://variegata.my.id/api/user-transactions'), // Ganti dengan URL API Anda
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> transactions = data['transactions'];

      transactions.sort((a, b) {
        DateTime dateA = DateTime.parse(a['created_at']);
        DateTime dateB = DateTime.parse(b['created_at']);
        return dateB.compareTo(dateA);
      });

      return data['transactions'];
    } else {
      throw Exception('Gagal mengambil data transaksi');
    }
  }

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
      appBar: AppBar(
        title: Text(
          "Riwayat Pembelian",
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
                builder: (context) => ProfilePage(),
              ),
            );
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _getAuthToken().then((authToken) => fetchUserTransactions(authToken!)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List? transactions = snapshot.data;
            return ListView.builder(
              itemCount: transactions?.length ?? 0,
              itemBuilder: (context, index) {
                if (transactions != null) {
                  final transaction = transactions[index];
                  DateTime date = DateTime.parse(transaction['created_at']);
                  String totalHarga = formatPrice(transaction['total_price']);

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Detail_transaksi(transaction: transaction)));
                        },
                        child: Container(
                          width: 355,
                          height: 220,
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
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Image.asset(
                                      'assets/img/profile/icon-produk.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Belanja",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                DateFormat('dd, MMMM yyyy').format(DateTime.parse(transaction['created_at'])),
                                                style: TextStyle(
                                                  color: Color(0xFFADADAD),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFE2F4E9),
                                                borderRadius: BorderRadius.circular(3)),
                                            child: Center(
                                              child: Text(
                                                "Sudah Bayar",
                                                style: TextStyle(
                                                    color: Color(0xFF458A61),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Color(0xFFD9D9D9),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Barang ${transactions[index]['qty']}',
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
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Belanja",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          totalHarga,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 102,
                                      height: 31,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(color: Color(0xFF9ED098))),
                                      child: Center(
                                        child: Text(
                                          "Beli Lagi",
                                          style: TextStyle(
                                              color: Color(0xFF9ED098),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
