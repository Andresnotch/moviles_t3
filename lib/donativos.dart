import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  final donativos;
  Donativos({Key? key, required this.donativos}) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donativos obtenidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/paypal.png"),
              trailing: Text(
                "${widget.donativos["paypal"] ?? 0.0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset("assets/credit_card.png"),
              trailing: Text(
                "${widget.donativos["credit"] ?? 0.0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money, size: 64),
              trailing: Text(
                "${widget.donativos["paypal"] + widget.donativos["credit"] ?? 0.0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            widget.donativos["paypal"] + widget.donativos["credit"] > 10000
                ? Image.asset("assets/gracias.png")
                : Center()
          ],
        ),
      ),
    );
  }
}
