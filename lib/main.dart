import 'package:flutter/material.dart';

import 'model/quarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SelectQuarterPage(title: 'Select you\'re known quarters'),
    );
  }
}

class SelectQuarterPage extends StatefulWidget {
  const SelectQuarterPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SelectQuarterPage> createState() => _SelectQuarterPageState();
}

class _SelectQuarterPageState extends State<SelectQuarterPage> {

  Set<Quarter> listSelectedQuarter = {};

  void _addQuarter(int hizb, int quarterNb) {
    Quarter quarter = Quarter(hizb: hizb, quarter: quarterNb);
    if (listSelectedQuarter.contains(quarter)) return;
    listSelectedQuarter.add(quarter);
  }

  void _removeQuarter(int hizb, int quarterNb) {
    Quarter quarter = Quarter(hizb: hizb, quarter: quarterNb);
    if (!listSelectedQuarter.contains(quarter)) return;
    listSelectedQuarter.remove(quarter);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 columns
            ),
            itemCount: 60*4,
            itemBuilder: (BuildContext context, int index) {
              // Calculate hizb and quarter
              int hizb = 60 - index ~/ 4;
              int quarter = index % 4 + 1;

              // Return QuarterCard widget
              return QuarterCard(hizb: hizb, quarter: quarter, onChanged: (isSelected){
                if (isSelected) {
                  _addQuarter(hizb, quarter);
                } else {
                  _removeQuarter(hizb, quarter);
                }
              },
              );
            },
        )
      ),
    );
  }
}

class QuarterCard extends StatefulWidget {
  final int hizb;
  final int quarter;
  final ValueChanged<bool>? onChanged;

  QuarterCard({Key? key, required this.hizb, required this.quarter, this.onChanged}) : super(key: key);

  @override
  _QuarterCardState createState() => _QuarterCardState(hizb: hizb, quarter: quarter);
}


class _QuarterCardState extends State<QuarterCard> {

  int hizb = -1;
  String quarter = 'unknown';
  bool isSelected = false;

  _QuarterCardState({required this.hizb, required int quarter, this.isSelected = false}) {
    switch(quarter) {
      case 1:
        this.quarter = "1st";
        break;
      case 2:
        this.quarter = "2nd";
        break;
      case 3:
        this.quarter = "3rd";
        break;
      case 4:
        this.quarter = "4th";
        break;
      default:
        this.quarter = "unknown";
        break;
    }
  }

  Color _cardColor = Colors.white;

  void _onClick() {
    setState(() {
      isSelected = !isSelected;
      _cardColor = isSelected ? Colors.green: Colors.white;

      if (widget.onChanged != null) {
        widget.onChanged!(isSelected); // Notify parent widget
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Set round corner radius
      ),
      color: _cardColor,
      child: InkWell(
        onTap: () {
          _onClick(); // Call the function to change the color
        },
        child: Container(
          child: Column(
            children: [
              Text(
                  "Hizb: $hizb"
              ),
              Text(
                  "rbu3: $quarter"
              )
            ],
          ),
          padding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}