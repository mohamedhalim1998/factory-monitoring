import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'color_legend.dart';

class DataGraph extends StatefulWidget {
  final List<Sensor> reads;

  const DataGraph({Key key, this.reads}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DataGraphState();
}

class DataGraphState extends State<DataGraph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 3,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xFF194D19),
              Color(0xFF6E2D2D),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                child: LineChart(
                  getLineChart(),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
            ),
            ColorLegend({
              "Temperture": Color(0xffaa4cfc),
              "Vibration": Color(0xff27b6fc),
              "Humidity": Color(0xFF2760FC),
            })
          ],
        ),
      ),
    );
  }

  LineChartData getLineChart() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          getTitles: (value) => '',
        ),
        leftTitles: SideTitles(
          getTitles: (value) => '',
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
          ),
          left: BorderSide(
            color: Color(0xff4e4965),
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 110,
      maxX: -5,
      maxY: 100,
      minY: -10,
      lineBarsData: [
        linesBarData(getGraphTemp(), Color(0xFFBD7DF5)),
        linesBarData(getGraphVib(), Color(0xff27b6fc)),
        linesBarData(getGraphHumid(), Color(0xE03A6EFC)),
      ],
    );
  }

  LineChartBarData linesBarData(List<FlSpot> data, Color color) {
    return LineChartBarData(
      spots: data,
      isCurved: false,
      colors: [
        color,
      ],
      barWidth: 2,
      isStrokeCapRound: false,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }

  List<FlSpot> getGraphTemp() {
    return List.generate(100,
        (index) => FlSpot(index.toDouble(), widget.reads[index].temperature));
  }

  List<FlSpot> getGraphVib() {
    return List.generate(100,
        (index) => FlSpot(index.toDouble(), widget.reads[index].vibration));
  }

  List<FlSpot> getGraphHumid() {
    return List.generate(
        100, (index) => FlSpot(index.toDouble(), widget.reads[index].humidity));
  }
}
