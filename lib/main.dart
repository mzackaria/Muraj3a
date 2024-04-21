import 'package:efficientmuraja3a/ui/select_quarters/select_quarters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/quarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectQuartersViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SelectQuarterPage(title: 'Select you\'re known quarters'),
      ),
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
      body: Consumer<SelectQuartersViewModel>(
        builder: (context, viewModel, child) {
          return Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                ),
                itemCount: viewModel.quarters.length,
                itemBuilder: (BuildContext context, int index) {
                  Quarter quarter = viewModel.quarters[index];

                  // Return QuarterCard widget
                  return QuarterCard(hizb: quarter.hizb, quarter: quarter.quarter, isSelected: quarter.isSelected, onChanged: (isSelected){
                    if (isSelected) {
                      viewModel.addQuarter(quarter.hizb, quarter.quarter);
                    } else {
                      viewModel.removeQuarter(quarter.hizb, quarter.quarter);
                    }
                  },
                  );
                },
              )
          );
        }
      ),
    );
  }
}

class QuarterCard extends StatefulWidget {
  final int hizb;
  final int quarter;
  final bool isSelected;
  final ValueChanged<bool>? onChanged;

  QuarterCard({Key? key, required this.hizb, required this.quarter, required this.isSelected, this.onChanged}) : super(key: key);

  @override
  _QuarterCardState createState() => _QuarterCardState(hizb: hizb, quarter: quarter, isSelected: isSelected);
}


class _QuarterCardState extends State<QuarterCard> {

  int hizb = -1;
  String quarter = 'unknown';
  bool isSelected = false;

  Color _cardColor = Colors.white;

  @override
  void initState() {
    super.initState();
  }

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

    isSelected = isSelected;
    _cardColor = isSelected ? Colors.green: Colors.white;
  }

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