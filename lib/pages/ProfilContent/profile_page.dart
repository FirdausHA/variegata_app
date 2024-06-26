import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:variegata_app/auth/login_page.dart';
import 'package:variegata_app/pages/ProfilContent/Favorit.dart';
import 'package:variegata_app/pages/ProfilContent/Riwayat.dart';
import 'package:variegata_app/pages/ProfilContent/Status_Pemesanan.dart';
import 'package:variegata_app/pages/catalog_shop/ganti_alamat.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 58,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFD9D9D9),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  // padding: const EdgeInsets.only(
                                  //   left: 10,
                                  //   top: 13,
                                  //   bottom: 13,
                                  // ),
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/profile-picture.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  // padding: const EdgeInsets.only(
                                  //     left: 13, top: 10, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BhreKheley',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '+6283877176446',
                                        style: TextStyle(
                                          color: Color(0xFFADADAD),
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'nabil132@gmail.com',
                                        style: TextStyle(
                                          color: Color(0xFFADADAD),
                                          fontSize: 10,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                "Ubah",
                                style: TextStyle(
                                  color: Color(0xFF94AF9F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Pesanan & Aktivitas
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Pesanan & Aktivitas",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorit()));
                        },
                        child: IconMenu(
                          'favorit.svg',
                          'Favorit',
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StatusPemesanan()));
                        },
                        child: IconMenu(
                          'status-pemesanan.svg',
                          'Status Pemesanan',
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatPembelian()));
                        },
                        child: IconMenu(
                          'riwayat-pembelian.svg',
                          'Riwayat Pembelian',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xFFD9D9D9),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Pengaturan Akun",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconMenu(
                        'edit-profil.svg',
                        'Edit Profil',
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GantiAlamat()));
                        },
                        child: IconMenu(
                          'alamat-pengiriman.svg',
                          'Alamat Pengiriman',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xFFD9D9D9),
                ),
                //Informasi Lainnya
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Informasi Lainnya",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconMenu(
                        'pusat-bantuan.svg',
                        'Pusat Bantuan',
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                      IconMenu(
                        'tentang-kami.svg',
                        'Tentang Kami',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: Center(
                            child: Text(
                              'LOGOUT',
                              style: TextStyle(
                                color: Color(0xFFA4BFAF),
                                fontSize: 22,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFA4BFAF),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget IconMenu(String image, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            // width: 343,
            // height: 37,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/img/profile/$image',
                      width: 29,
                      height: 29,
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      title.toString(),
                      style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF505050),
                  size: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}