import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';

class CustomColumnNestedTable extends StatefulWidget {
  @override
  _CustomColumnNestedTableState createState() =>
      _CustomColumnNestedTableState();
}

class _CustomColumnNestedTableState extends State<CustomColumnNestedTable> {
  final String jsonSample =
      '[{"name":"Ram","email":{"1":"ram@gmail.com"},"age":23,"DOB":"1990-12-01","Date":"2020-03-26T18:57:28.301254Z"},'
      '{"name":"Shyam","email":{"1":"shyam23@gmail.com"},"age":18,"DOB":"1995-07-01"},'
      '{"name":"John","email":{"1":"john@gmail.com"},"age":10,"DOB":"2000-02-24"}]';
  bool toggle = true;
  List<JsonTableColumn>? columns;

  @override
  void initState() {
    super.initState();
    print(DateTime.now().toIso8601String());
    columns = [
      JsonTableColumn("name", label: "Name"),
      JsonTableColumn("age", label: "Age"),
      JsonTableColumn(
        "DOB",
        label: "Date of Birth",
        valueBuilder: formatDOB,
      ),
      JsonTableColumn(
        "age",
        label: "Eligible to Vote",
        valueBuilder: eligibleToVote,
      ),
      JsonTableColumn("email.1", label: "E-mail", defaultValue: "NA"),
      JsonTableColumn("Date", label: "Date", type: "date"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            JsonTable(
              json,
              columns: columns,
              showColumnToggle: true,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              getPrettyJSONString(jsonSample),
              style: TextStyle(fontSize: 13.0),
            ),
          ],
        ),
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  String formatDOB(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d MMM yyyy").format(dateTime);
  }

  String eligibleToVote(value) {
    if (value >= 18) {
      return "Yes";
    } else
      return "No";
  }
}
