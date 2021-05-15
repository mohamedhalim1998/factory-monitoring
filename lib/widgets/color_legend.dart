import 'package:factory_monitor/widgets/color_icon.dart';
import 'package:flutter/material.dart';

class ColorLegend extends StatelessWidget {
  final Map<String, Color> colorMap;
  ColorLegend(this.colorMap);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: getLegendItems(),
      ),
    );
  }

  List<Widget> getLegendItems() {
    List<Widget> list = [];
    colorMap.forEach(
      (key, value) {
        list.add(
          ColorIcon(
            color: value,
            title: key,
          ),
        );
      },
    );
    return list;
  }
}
