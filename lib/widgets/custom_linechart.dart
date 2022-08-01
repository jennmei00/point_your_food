import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        minimum:
            AllData.weighs.isEmpty ? DateTime.now() : AllData.weighs.last.date,
        maximum: AllData.weighs.isEmpty
            ? DateTime.now().add(const Duration(days: 50))
            : AllData.weighs.first.date,
        intervalType: DateTimeIntervalType.days,
        interval: 7,
        dateFormat: DateFormat("dd.MM", "de"),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat('###.## kg', 'de'),
        minimum: AllData.weighs.isEmpty ? null : _getMinimum(),
        maximum: AllData.weighs.isEmpty ? null : _getMaximum(),
      ),
      series: _getDefaultLineSeries(),
    );
  }

  List<LineSeries<_ChartData, DateTime>> _getDefaultLineSeries() {
    List<LineSeries<_ChartData, DateTime>> list = [];
    List<_ChartData> dataSource = _getChartData();

    list.add(LineSeries<_ChartData, DateTime>(
      dataSource: dataSource,
      xValueMapper: (_ChartData data, _) => data.x,
      yValueMapper: (_ChartData data, _) => data.y,
    ));

    if (AllData.profiledata.startWeight!.weight != null) {
      list.add(LineSeries<_ChartData, DateTime>(
          dataSource: [
            _ChartData(AllData.weighs.last.date!,
                AllData.profiledata.startWeight!.weight!),
            _ChartData(AllData.weighs.first.date!,
                AllData.profiledata.startWeight!.weight!),
          ],
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          color: Colors.red,
          dashArray: [5, 7],
          name: 'Startgewicht'));
    }

    if (AllData.profiledata.targetWeight!.weight != null) {
      list.add(LineSeries<_ChartData, DateTime>(
          dataSource: [
            _ChartData(AllData.weighs.last.date!,
                AllData.profiledata.targetWeight!.weight!),
            _ChartData(AllData.weighs.first.date!,
                AllData.profiledata.targetWeight!.weight!),
          ],
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          color: Colors.green,
          dashArray: [5, 7],
          name: 'Zielgewicht'));
    }

    return list;
  }

  List<_ChartData> _getChartData() {
    List<_ChartData> chartData = <_ChartData>[];

    for (var element in AllData.weighs) {
      chartData.add(_ChartData(element.date!, element.weight!));
    }

    return chartData;
  }

  double _getMinimum() {
    double d = 0;
    if (AllData.profiledata.startWeight!.weight != null) {
      if (AllData.profiledata.startWeight!.weight! <
          AllData.weighs.last.weight!) {
        d = AllData.profiledata.startWeight!.weight! - 10;
      } else {
        d = AllData.weighs.last.weight! - 10;
      }
    } else {
      d = AllData.weighs.last.weight! - 10;
    }
    return d;
  }

  double _getMaximum() {
    double d = 0;
    if (AllData.profiledata.startWeight!.weight != null) {
      if (AllData.profiledata.startWeight!.weight! >
          AllData.weighs.first.weight!) {
        d = AllData.profiledata.startWeight!.weight! + 5;
      } else {
        d = AllData.weighs.first.weight! + 5;
      }
    } else {
      d = AllData.weighs.first.weight! + 5;
    }
    return d;
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
