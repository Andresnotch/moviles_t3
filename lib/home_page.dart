import 'package:donativos/donativos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentSelectedRadio;
  var assetsRadioGroup = {
    0: "assets/paypal.png",
    1: "assets/credit_card.png",
  };
  var radioGroup = {
    0: "Paypal",
    1: "Tarjeta",
  };

  double totalCredit = 0.0;
  double totalPaypal = 0.0;
  double percent = 0.0;
  String selectedDonation = '100';

  var donateOptions = [
    '100',
    '350',
    '850',
    '1000',
    '9999',
  ];

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioItem) => ListTile(
            leading: Image.asset(
              assetsRadioGroup[radioItem.key]!,
              height: 64,
              width: 44,
            ),
            title: Text("${radioItem.value}"),
            trailing: Radio(
              value: radioItem.key,
              groupValue: currentSelectedRadio,
              onChanged: (int? newSelectedRadio) {
                currentSelectedRadio = newSelectedRadio;
                setState(() {});
              },
            ),
          ),
        )
        .toList();
  }

  DropdownMenuItem<String> dropDownItemsGenerator(String items) {
    return DropdownMenuItem(
      value: items,
      child: Text(items),
    );
  }

  void calcularDonaciones() {
    totalPaypal +=
        currentSelectedRadio == 0 ? double.parse(selectedDonation) : 0.0;
    totalCredit +=
        currentSelectedRadio == 1 ? double.parse(selectedDonation) : 0.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "Es para una buena causa",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const Text(
              "Elija modo de donativo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: radioGroupGenerator(),
              ),
            ),
            ListTile(
              title: const Text("Cantidad a donar:"),
              trailing: Column(
                children: [
                  DropdownButton(
                    value: selectedDonation,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: donateOptions.map(dropDownItemsGenerator).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDonation = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Stack(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 25,
                      backgroundColor: Colors.purpleAccent,
                      value: (totalPaypal + totalCredit) / 10000 > 1.0
                          ? 1.0
                          : (totalPaypal + totalCredit) / 10000,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.purple),
                    ),
                    Align(
                      child: Text(
                        ((totalCredit + totalPaypal) / 100).toString() + "%",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      alignment: Alignment.topCenter,
                    )
                  ],
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(1500, 35)),
                    onPressed: calcularDonaciones,
                    child: const Text("Donar")),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.remove_red_eye),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Donativos(
                donativos: {
                  "paypal": totalPaypal,
                  "credit": totalCredit,
                },
              ),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
