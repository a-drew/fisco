import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

//Main method for all Flutter Applications
void main() => runApp(MyApp());

/**
 * This class is the root Widget of the application. It will be composed
 * of other widgets.
 */
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MainPage(),
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}
/**
 * This is a visualization widget that will build our visualization
 */
class _MainPageState extends State<MainPage> {
  List<String> _dataInterval = ['Last Week', 'Last Month'];
  String _selectedDataInterval = 'Last Week';
  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('Fisco App'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                hint: Text('Please choose a data interval'),
                value: _selectedDataInterval,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDataInterval = newValue;
                  });
                },
                items: _dataInterval.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
              if (_selectedDataInterval == 'Last Week') ... [
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.PieChart(
                    _createPieChartData(globals.lastWeekDataSet),
                    animate: true,
                    behaviors: [
                      new charts.DatumLegend(position: charts.BehaviorPosition.end)
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.BarChart(
                    _createBarChartData(globals.lastWeekDataSet),
                    animate: true,
                  ),
                )
              ]
              else if (_selectedDataInterval == 'Last Month') ... [
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.PieChart(
                    _createPieChartData(globals.lastMonthDataSet),
                    animate: true,
                    behaviors: [
                      new charts.DatumLegend(position: charts.BehaviorPosition.end)
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 200,
                  child:
                  charts.BarChart(
                    _createBarChartData(globals.lastMonthDataSet),
                    animate: true,
                  ),
                )
              ]
            ],
          ),
        ),
      );
    }
  }

  static List<charts.Series<globals.LastWeekCategoryVsExpense, String>>
  _createBarChartData(List<globals.LastWeekCategoryVsExpense> dataSet) {
    var data = new List<globals.LastWeekCategoryVsExpense>.from(dataSet);
    return [
      charts.Series<globals.LastWeekCategoryVsExpense, String>(
        id: 'LastWeekBarChart',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (globals.LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.category,
        measureFn: (globals.LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.expense,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (globals.LastWeekCategoryVsExpense row, _) => '${row.category}',
      )
    ];
  }
  static List<charts.Series<globals.LastWeekCategoryVsExpense, String>>
  _createPieChartData(List<globals.LastWeekCategoryVsExpense> dataSet) {
    var data = new List<globals.LastWeekCategoryVsExpense>.from(dataSet);
    // Sort data automatically by ascending order
    data.sort((a, b) => a.expense.compareTo(b.expense));
    int dataSize = data.length+1;
    int startingColorIndex = data.length-1;

    return [
      charts.Series<globals.LastWeekCategoryVsExpense, String>(
        id: 'LastWeekBarChart',
        colorFn: (_, index) {

          return charts.MaterialPalette.indigo.makeShades(dataSize)[startingColorIndex-index];
        },
        domainFn: (globals.LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.category,
        measureFn: (globals.LastWeekCategoryVsExpense dataPoint, _) =>
        dataPoint.expense,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (globals.LastWeekCategoryVsExpense row, _) => '${row.category}',
      )
    ];
  }
}

