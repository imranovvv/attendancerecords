import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  TextEditingController nameController =
      TextEditingController(); // Save name to send to JSON file
  TextEditingController phoneController =
      TextEditingController(); // Save phoneNo to send to JSON file
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add record'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(hintText: 'Phone No.'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            // Submit button
            onPressed: addData,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> addData() async {
    //Get data from form
    final name = nameController.text;
    final phone = phoneController.text;
    final body = {
      "user": name,
      "phone": phone,
      "check-in": DateTime.now().toIso8601String(),
    };
    //Submit data to the server
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    //Success/fail message
    print(response.body);
    if (response.statusCode == 201) {
      nameController.text = '';
      phoneController.text = '';
      showSuccessMessage();
    }
  }
  //Success/fail message

  void showSuccessMessage() {
    const snackBar = SnackBar(content: Text('Added record successfully'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
