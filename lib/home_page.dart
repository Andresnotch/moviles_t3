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
    0: "assets/paypal_logo.png",
    1: "assets/creditcard_logo.png",
  };
  var radioGroup = {
    0: "Paypal",
    1: "Tarjeta",
  };

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

  // TODO: completar metodo para generar los DropDownMenuItems
  // Es posible utilizar .map como en la de los radios
  dropDownItemsGenerator() {
    return [];
  }

  // TODO: metodo para calcular las donaciones
  // identifica si la donacion es por paypal o tarjeta
  // utiliza datos de los radio buttons y drop down
  void calcularDonaciones() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Es para una buena causa",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            Text(
              "Elija modo de donativo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            // Radios paypal y tarjeta
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: radioGroupGenerator(),
              ),
            ),
            // TODO: Agregar DropdownButton en el trailing
            // utilizar el metodo dropDownItemsGenerator() para pasar
            // como parametro a "items" del DropdownButton
            ListTile(
              title: Text("Cantidad a donar:"),
            ),
            // TODO: Agregar LinearProgressIndicator con altura de 20
            // TODO: Agregar Text con el % de donacion y max 2 decimales
            // TODO: Agregar Boton de DONAR y logica necesaria
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_red_eye),
        tooltip: "Ver donativos",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Donativos(
                donativos: {},
              ),
            ),
          );
        },
      ),
    );
  }
}
