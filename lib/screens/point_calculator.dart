import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class PointCalculator extends StatefulWidget {
  const PointCalculator({Key? key, required this.fromSheet}) : super(key: key);
  static const routeName = '/point_calculator';
  final bool fromSheet;

  @override
  State<PointCalculator> createState() => _PointCalculatorState();
}

class _PointCalculatorState extends State<PointCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fettController = TextEditingController();
  final TextEditingController _kalorienController = TextEditingController();
  // final TextEditingController _bezogenAufController =
  //     TextEditingController(text: '100');
  final TextEditingController _berechnungFuerController =
      TextEditingController();
  double foodPoints = 0;
  // final TextEditingController _punkteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.fromSheet
        ? Scaffold(
            appBar: AppBar(title: const Text('Punkte berechnen')),
            body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: form()),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: form());
  }

  Form form() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              type: TextFieldType.decimal,
              controller: _kalorienController,
              mandatory: true,
              hintText: 'in kcal',
              labelText: 'Kalorien'),
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              type: TextFieldType.decimal,
              controller: _fettController,
              mandatory: true,
              hintText: 'in gramm',
              labelText: 'Fett'),
          const ListTile(
            title: Text('Bezogen auf'),
            subtitle: Text('in gramm'),
            trailing: Text(
              '100',
              style: TextStyle(fontSize: 20),
            ),
          ),
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              type: TextFieldType.decimal,
              controller: _berechnungFuerController,
              mandatory: true,
              hintText: 'in gramm',
              labelText: 'Berechnung für'),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                foodPoints.toStringAsFixed(1).replaceAll('.', ','),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text('Punkte'),
            ],
          ),
          widget.fromSheet
              ? OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(foodPoints);
                  },
                  child: const Text('Punkte übernehmen'))
              : const SizedBox(),
        ],
      ),
    );
  }

  void _calculatePoints() {
    double points = 0;
    if (_fettController.text != '' &&
        _kalorienController.text != '' &&
        _berechnungFuerController.text != '') {
      double fett = double.tryParse(_fettController.text.replaceAll(',', '.'))!;
      double kalorien =
          double.tryParse(_kalorienController.text.replaceAll(',', '.'))!;
      double bezogenAuf = 100;
      double berechnungFuer =
          double.tryParse(_berechnungFuerController.text.replaceAll(',', '.'))!;

      points =
          (fett * 0.11 + kalorien * 0.0165) * (berechnungFuer / bezogenAuf);
    }

    setState(() {
      foodPoints = roundPoints(points);
    });
  }
}
