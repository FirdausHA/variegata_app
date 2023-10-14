import 'package:flutter/material.dart';
import 'package:variegata_app/pages/Ulasan_Pembeli/Review/Review_product_1.dart';
import 'package:variegata_app/pages/Ulasan_Pembeli/Review/Review_produk_2.dart';
import 'package:variegata_app/pages/Ulasan_Pembeli/Review/Review_produk_3.dart';

class Produk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nilai Produk'),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NilaiProduk()));
            },
            child: _buildProductCard(
              'assets/img/produk-philodendron.png',
              'Tanaman Philodendron Monstera Deliciosa',
              '3 Barang',
              'Rp15.000',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Review()));
            },
            child: _buildProductCard(
              'assets/img/produk_bawang.jpg',
              'Benih Bawang Bombay asli langsung dari petani',
              '2 Barang',
              'Rp10.000',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Review_produk()));
            },
            child: _buildProductCard(
              'assets/img/produk_tomat.png',
              'Tanaman Tomat Madu asli langsung dari petani',
              '3 Barang',
              'Rp10.000',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String imageAsset, String name, String quantity, String price) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Gambar produk
            Image.asset(
              imageAsset,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            // Nama, kuantitas, dan harga
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(quantity),
                  SizedBox(height: 8),
                  Text(price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
