import 'package:factory_monitor/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  String searchQuery = "Device";
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return Card(
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => {widget.searchQuery = value},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0),
                hintText: "Search",
              ),
            ),
          ),
          IconButton(
            onPressed: () => {dataProvider.searchQuery = widget.searchQuery},
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
