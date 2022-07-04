import 'package:flutter/material.dart';
import 'package:punkte_zaehler/widgets/custom_textField.dart';

class PointCalculator extends StatefulWidget {
  const PointCalculator({Key? key}) : super(key: key);
  static const routeName = '/point_calculator';

  @override
  State<PointCalculator> createState() => _PointCalculatorState();
}

class _PointCalculatorState extends State<PointCalculator> {
  final TextEditingController _fettController = TextEditingController();
  final TextEditingController _kalorienController = TextEditingController();
  final TextEditingController _bezogenAufController = TextEditingController();
  final TextEditingController _berechnungFuerController =
      TextEditingController();
  double foodPoints = 0;
  // final TextEditingController _punkteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        CustomTextField(
            controller: _fettController,
            mandatory: true,
            hintText: 'in gramm',
            labelText: 'Fett'),
        CustomTextField(
            controller: _kalorienController,
            mandatory: true,
            hintText: 'in kcal',
            labelText: 'Kalorien'),
        CustomTextField(
            controller: _bezogenAufController,
            mandatory: true,
            hintText: 'in gramm',
            labelText: 'Bezogen auf'),
        CustomTextField(
            controller: _berechnungFuerController,
            mandatory: true,
            hintText: 'in gramm',
            labelText: 'Berechnung für'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$foodPoints',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text('Punkte'),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, child: const Text('Punkte berechnen')),
      ],
    );
  }
}
