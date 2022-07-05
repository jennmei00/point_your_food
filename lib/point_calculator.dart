import 'package:flutter/material.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textField.dart';

class PointCalculator extends StatefulWidget {
  const PointCalculator({Key? key}) : super(key: key);
  static const routeName = '/point_calculator';

  @override
  State<PointCalculator> createState() => _PointCalculatorState();
}

class _PointCalculatorState extends State<PointCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fettController = TextEditingController();
  final TextEditingController _kalorienController = TextEditingController();
  final TextEditingController _bezogenAufController =
      TextEditingController(text: '100');
  final TextEditingController _berechnungFuerController =
      TextEditingController(text: '100');
  double foodPoints = 0;
  // final TextEditingController _punkteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              // keyboardType: TextInputType.,
              controller: _fettController,
              mandatory: true,
              hintText: 'in gramm',
              labelText: 'Fett'),
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              keyboardType: TextInputType.number,
              controller: _kalorienController,
              mandatory: true,
              hintText: 'in kcal',
              labelText: 'Kalorien'),
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              keyboardType: TextInputType.number,
              controller: _bezogenAufController,
              mandatory: true,
              hintText: 'in gramm',
              labelText: 'Bezogen auf'),
          CustomTextField(
              onChanged: (val) => _calculatePoints(),
              keyboardType: TextInputType.number,
              controller: _berechnungFuerController,
              mandatory: true,
              hintText: 'in gramm',
              labelText: 'Berechnung für'),
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
          // const SizedBox(height: 10),
          // ElevatedButton(
          //     onPressed: () {
          //       if (_formKey.currentState!.validate()) {
          //         _calculatePoints();
          //       }
          //     },
          //     child: const Text('Punkte berechnen')),
        ],
      ),
    );
  }

  void _calculatePoints() {
    double points = 0;
    if (_fettController.text != '' &&
        _kalorienController.text != '' &&
        _bezogenAufController.text != '' &&
        _berechnungFuerController.text != '') {
      double fett = double.tryParse(_fettController.text.replaceAll(',', '.'))!;
      double kalorien =
          double.tryParse(_kalorienController.text.replaceAll(',', '.'))!;
      double bezogenAuf =
          double.tryParse(_bezogenAufController.text.replaceAll(',', '.'))!;
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
