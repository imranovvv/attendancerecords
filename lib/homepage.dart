import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adduser.dart';
import 'attendancedetails.dart';
import 'user.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Read JSON file and convert list of objects to map
  Future<List<User>> readJsonData() async {
    final jsondata = await root_bundle.rootBundle
        .loadString('assets/attendancerecords.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => User.fromJson(e)).toList();
  }

  @override
  void initState() {
    // Initialize the data from the JSON file
    super.initState();
    readJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // Add record button
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => const AddRecord(),
          );
          Navigator.push(context, route);
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        title: const Text('Attendance Records'),
      ),
      body: FutureBuilder(
          // Print the data from JSON file
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasData) {
              List<User> items = data.data!;
              items.sort((a, b) => b.checkIn.compareTo(
                  a.checkIn)); // Sort the items based on date, recent to oldes
              return Column(
                // If JSON file has data, return widget
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 700,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          // Return all records in the form of card
                          margin: const EdgeInsets.all(4),
                          elevation: 8,
                          child: ListTile(
                            // Name
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AttendanceDetails(record: items[index]),
                                ),
                              );
                            },
                            title: Text(
                              items[index].user,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              // Phone number
                              items[index].phone,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            trailing: Text(
                              // Date/Timeago
                              timeago.format(items[index].checkIn),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ToggleButtons(
                    // Toggle button to change current date or time ago format
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < selectedDates.length; i++) {
                          selectedDates[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.blue[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.blue[200],
                    color: Colors.grey[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: selectedDates,
                    children: dateType,
                  ),
                ],
              );
            }

            return const CircularProgressIndicator();
          }),
    );
  }
}

List<bool> selectedDates = <bool>[true, false];
const List<Widget> dateType = <Widget>[Text('Time Ago'), Text('Current Date')];
