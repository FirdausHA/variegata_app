import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:variegata_app/pages/catalog_shop/dashboard_catalog.dart'; // Import package shared_preferences

class PaymentHistoryPage extends StatefulWidget {
  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    // Panggil metode untuk mengambil data riwayat pembayaran saat widget diinisialisasi
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory() async {
    try {
      // Ambil bearer token dari local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('bearerToken');

      if (bearerToken == null) {
        // Handle jika token tidak tersedia di local storage
        print('Bearer token tidak tersedia di local storage.');
        return;
      }

      // Ganti URL dengan endpoint API Laravel Anda
      final response = await http.get(
        Uri.parse('https://variegata.my.id/api/user-transactions'),
        headers: {
          'Authorization': 'Bearer $bearerToken', // Tambahkan header Authorization
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          transactions = data['transactions'];
        });
      } else {
        // Handle kesalahan jika diperlukan
        print('Gagal mengambil data riwayat pembayaran.');
      }
    } catch (error) {
      // Handle kesalahan jaringan jika diperlukan
      print('Terjadi kesalahan jaringan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Riwayat Pembayaran",
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
                builder: (context) => KatalogShop(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          final transaction = transactions[index];
          return Card(
            child: ListTile(
              title: Text('Order ID: ${transaction['id']}'),
              subtitle: Text('Total Price: ${transaction['total_price']}'),
              // Tambahkan informasi lain yang ingin Anda tampilkan
            ),
          );
        },
      ),
    );
  }
}
