import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:file_picker/file_picker.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  String fileContent = "";
  String show = "";
  List<Widget> charts = [];
  Uint8List? file;

  Future<void> loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = result.files.single.bytes;
    }
    else {
      // User canceled the picker
    }
  }

  Future<void> selectWines() async {
    List<String> lines = [];
    String line = "";
    for(int i = 0; i < fileContent.length; i++) {
      if(fileContent![i] == '\n') {
        lines.add(line);
        line = "";
      }
      else {
        line += fileContent![i];
      }
    }
    List<double> alcohol = [], ash = [], color = [], nwine = [];
    for(int i = 0; i < lines.length; i++) {
      List<String> l = lines[i].split(",");
      alcohol.add(double.parse(l[1]));
      ash.add(double.parse(l[3]));
      color.add(double.parse(l[10]));
      nwine.add(i.toDouble());
    }

    final List<ChartData> dataAlcohol = createDataSource(nwine, alcohol);
    final List<ChartData> dataAsh = createDataSource(nwine, ash);
    final List<ChartData> dataColor = createDataSource(nwine, color);

    setState(() {
      charts = [];
      charts.add(SfCartesianChart(
        title: ChartTitle(text: "Wines"),
        legend: Legend(
          isVisible: true,

        ),
        series: <ChartSeries>[
          LineSeries<ChartData, double>(
            dataSource: dataAlcohol,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
          LineSeries<ChartData, double>(
            dataSource: dataAsh,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
          LineSeries<ChartData, double>(
            dataSource: dataColor,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      ));
    });
  }

  void giveData() {
    setState(() {
      fileContent = utf8.decode(file!);
    });
  }

  @override
  void initState() {
    super.initState();
    loadFile().then((value) => {
      giveData()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: charts,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          selectWines();
        },
        child: const Icon(Icons.show_chart_outlined),
      ),
    );
  }

  List<ChartData> createDataSource(List<double> xAxis, List<double> yAxis){
    List<ChartData> dS = [];
    for(int i = 0; i < xAxis.length; i++){
      dS.add(ChartData(xAxis[i], yAxis[i]));
    }
    return dS;
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

