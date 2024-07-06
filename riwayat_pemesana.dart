import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/groceries_data.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/profile_provider.dart';

class Riwayat_Pemesanan extends StatelessWidget {
  const Riwayat_Pemesanan({super.key});

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey[850] : Colors.teal.shade50,
        title: const Text('Riwayat Pemesanan'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: profileProvider.orderHistoryList.length,
        itemBuilder: (context, index) {
          final order = profileProvider.orderHistoryList[index];
          return ListTile(
            title: Text(order.product.name, style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
            subtitle: Text(order.orderDate.toString(), style: TextStyle(color: themeProvider.isDarkMode ? Colors.white70 : Colors.black87)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPesanan(order: order),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailPesanan extends StatelessWidget {
  final OrderHistory order;
  const DetailPesanan({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey[850] : Colors.teal.shade50,
        title: const Text('Detail Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk: ${order.product.name}', style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
            Text('Tanggal Pesan: ${order.orderDate.toString()}', style: TextStyle(color: themeProvider.isDarkMode ? Colors.white70 : Colors.black87)),
          ],
        ),
      ),
    );
  }
}
