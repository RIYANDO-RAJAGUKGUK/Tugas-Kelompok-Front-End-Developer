import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PaymentSummaryPage extends StatefulWidget {
  final CartProvider cart;

  const PaymentSummaryPage({Key? key, required this.cart}) : super(key: key);

  @override
  _PaymentSummaryPageState createState() => _PaymentSummaryPageState();
}

class _PaymentSummaryPageState extends State<PaymentSummaryPage> {
  String selectedPaymentMethod = 'Kartu Kredit';

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController bankAccountNameController = TextEditingController();
  TextEditingController digitalWalletIdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    bankAccountNumberController.dispose();
    bankAccountNameController.dispose();
    digitalWalletIdController.dispose();
    super.dispose();
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor kartu kredit tidak boleh kosong';
    }
    if (value.length != 16) {
      return 'Nomor kartu kredit harus terdiri dari 16 digit';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Nomor kartu kredit hanya boleh berisi angka';
    }
    return null;
  }

  String? validateCardHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama pemilik kartu tidak boleh kosong';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Nama pemilik kartu hanya boleh mengandung huruf';
    }
    return null;
  }

  String? validateBankAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor rekening bank tidak boleh kosong';
    }
    if (value.length != 16) {
      return 'Nomor rekening bank harus terdiri dari 16 digit';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Nomor rekening bank hanya boleh berisi angka';
    }
    return null;
  }

  String? validateBankAccountName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama pemilik rekening tidak boleh kosong';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Nama pemilik rekening hanya boleh mengandung huruf';
    }
    return null;
  }

  String? validateDigitalWalletId(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID dompet digital tidak boleh kosong';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
          appBar: AppBar(
            backgroundColor: themeProvider.isDarkMode ? Colors.grey[850] : Colors.teal.shade50,
            title: Text('Checkout'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Ringkasan Pesanan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cart.itemCount,
                      itemBuilder: (context, index) {
                        final item = widget.cart.items.keys.elementAt(index);
                        final quantity = widget.cart.items[item]!;
                        return ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text('${item.name} x $quantity'),
                          subtitle: Text(NumberFormat.currency(
                            decimalDigits: 2,
                            locale: 'en_US',
                            symbol: '\$ ',
                          ).format(item.price * quantity)),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 16),
                    Text(
                      'Total Harga:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        decimalDigits: 2,
                        locale: 'en_US',
                        symbol: '\$ ',
                      ).format(widget.cart.totalPrice),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pilih Metode Pembayaran',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPaymentMethod,
                      onChanged: (newValue) {
                        setState(() {
                          selectedPaymentMethod = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Kartu Kredit',
                          child: Text('Kartu Kredit'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Transfer Bank',
                          child: Text('Transfer Bank'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Dompet Digital',
                          child: Text('Dompet Digital'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Metode Pembayaran',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (selectedPaymentMethod == 'Kartu Kredit') ...[
                      SizedBox(height: 20),
                      Text(
                        'Detail Kartu Kredit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: cardNumberController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Kartu Kredit',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: validateCardNumber,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: cardHolderNameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Pemilik Kartu',
                          border: OutlineInputBorder(),
                        ),
                        validator: validateCardHolderName,
                      ),
                    ],
                    if (selectedPaymentMethod == 'Transfer Bank') ...[
                      SizedBox(height: 20),
                      Text(
                        'Detail Transfer Bank',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: bankAccountNumberController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Rekening Bank',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: validateBankAccountNumber,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: bankAccountNameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Pemilik Rekening',
                          border: OutlineInputBorder(),
                        ),
                        validator: validateBankAccountName,
                      ),
                    ],
                    if (selectedPaymentMethod == 'Dompet Digital') ...[
                      SizedBox(height: 20),
                      Text(
                        'Detail Dompet Digital',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: digitalWalletIdController,
                        decoration: InputDecoration(
                          labelText: 'ID Dompet Digital',
                          border: OutlineInputBorder(),
                        ),
                        validator: validateDigitalWalletId,
                      ),
                    ],
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedPaymentMethod == 'Kartu Kredit') {} 
                          else if (selectedPaymentMethod == 'Transfer Bank') {} 
                          else if (selectedPaymentMethod == 'Dompet Digital') {}
                          widget.cart.clearCart();
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pembayaran Berhasil'),
                                content: Text('Terima kasih, pembayaran Anda telah berhasil.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context); 
                                      if (ModalRoute.of(context)?.settings.name == 'cart') {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white
                      ),
                      child: Text('Proses Pembayaran'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
