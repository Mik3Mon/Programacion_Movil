import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CalendarPage extends StatefulWidget {
    const CalendarPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Meeting> meetings = [];

  final start = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  DateTime startDate = DateTime.now();
  DateTime datePicked = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isAllDayBox = false;
  Color colorPicked = Color.fromRGBO(0, 0, 0, 1);
  Color dateColor = Color.fromRGBO(0, 0, 0, 1);

  final textEventController = TextEditingController();
  final textStartTime = TextEditingController();
  final textEndTime = TextEditingController();

  @override
  void initState(){
    super.initState();
    loadMeetings();
    textStartTime.text = "${DateFormat.yMd("es").format(startDate)} ${DateFormat.Hm("es").format(startDate)}";
    textEndTime.text = "${DateFormat.yMd("es").format(endDate)}  ${DateFormat.Hm("es").format(endDate)}";
  }

  Future<void> saveMeetings() async {
    final colRef = db.collection("Meetings");
    QuerySnapshot qS = await colRef.get();
    QueryDocumentSnapshot lastMeeting = qS.docs.last;
    String id = lastMeeting.reference.id;
    int n = int.parse(id.replaceAll("M", ""));
    
    db.collection("Meetings").doc("M${n+1}").set({
      'Evento': textEventController.text,
      'TodoDia': isAllDayBox,
      'Color': dateColor.value.toString(),
      'Inicio': startDate,
      'Fin': endDate
    }).then((value) => print("Evento agregado")).catchError((error)=>print("Error"));
  }

  Future<void> loadMeetings() async {
    meetings = [];
    final colorRef = db.collection("Meetings");
    QuerySnapshot qS = await colorRef.get();
    List allMeetings = qS.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < allMeetings.length; i++) {
      Timestamp start = allMeetings[i]?["Inicio"];
      Timestamp end = allMeetings[i]?["Fin"];
      String newEvent = (allMeetings[i]?["Evento"] ?? "");
      DateTime date = DateTime.fromMillisecondsSinceEpoch(start.seconds * 1000);
      DateTime hour = DateTime.fromMillisecondsSinceEpoch(end.seconds * 1000);
      Color color = Color(int.parse(allMeetings[i]["Color"]));
      bool allDay = allMeetings[i]["TodoDia"];
      setState(() {
        meetings.add(Meeting(newEvent, date, hour, color, allDay));
      });
    }
  }

  void changeColor(Color color) => setState(() => dateColor);

  void addMeeting(context){
    dialogBuilder(context);
  }

  Future<void> dialogBuilder(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                title: Text(
                  "New Event",
                  style: TextStyle(color: dateColor),
                ),
                content: Column(
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: textEventController,
                        decoration: const InputDecoration(labelText: "Add new event"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Start Date",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        textEndTime.text,
                      ),
                    ),
                    TextButton(
                      child: const Text("Choose start date"),
                      onPressed: () {
                        selectStartDate(context).then((value) =>
                          setState(() {
                            selectStartTime(context).then((value) =>
                                setState(() {
                                  endDate = datePicked.add(Duration(hours: startTime.hour, minutes: startTime.minute));
                                  textEndTime.text = "${DateFormat.yMd("es").format(startDate)} ${DateFormat.Hm("es").format(startDate)}";
                                })
                            );
                          })
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "End Date",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        textEndTime.text,
                      ),
                    ),
                    TextButton(
                      child: const Text("Choose end date"),
                      onPressed: () {
                        selectStartDate(context).then((value) =>
                            setState(() {
                              selectStartTime(context).then((value) =>
                                  setState(() {
                                    startDate = datePicked.add(Duration(hours: startTime.hour, minutes: startTime.minute));
                                    textStartTime.text = "${DateFormat.yMd("es").format(endDate)} ${DateFormat.Hm("es").format(endDate)}";
                                  })
                              );
                            })
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Choose a color",
                        style: TextStyle(color: dateColor),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: EdgeInsets.all(0),
                              contentPadding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: MediaQuery.of(context).orientation == Orientation ? const BorderRadius.vertical(top: Radius.circular(500), bottom: Radius.circular(100),)
                                    : const BorderRadius.horizontal(right: Radius.circular(500), left: Radius.circular(0))
                              ),
                              content: SingleChildScrollView(
                                child: HueRingPicker(
                                  pickerColor: dateColor,
                                  onColorChanged: changeColor,
                                  enableAlpha: true,
                                  displayThumbColor: false,
                                ),
                              ),
                              actions: <Widget> [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  child: const Text("Accept"),
                                  onPressed: () {
                                    setState(() {
                                      changeColor(dateColor);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        );
                      },
                    ),
                  ],
                ),
              );
            }
        );
      }
    );
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: start,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101)
    );
    if (picked != null) {
      setState(() {
        datePicked = picked;
      });
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
      initialEntryMode: TimePickerEntryMode.dial
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 1,
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        dataSource: MeetingDataSource(meetings),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //addMeeting(context);
          loadMeetings();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class Meeting {
  Meeting(this.nombreEvento, this.desde, this.hasta, this.fondo, this.todoDia);
  String nombreEvento;
  DateTime desde;
  DateTime hasta;
  Color fondo;
  bool todoDia;
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int i){
    return appointments![i].desde;
  }

  @override
  DateTime getEndTime(int i){
  return appointments![i].hasta;
  }

  @override
  String getSubject(int i){
    return appointments![i].nombreEvento;
  }

  @override
  Color getColor(int i){
    return appointments![i].fondo;
  }

  @override
  bool isAllDay(int i){
    return appointments![i].todoDia;
  }
}