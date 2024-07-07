// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqfliteoperation/DataBase/SQLoperation.dart';
import 'package:sqfliteoperation/Widgets/AddButton.dart';
import '../DataBase/DB List.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
 
}

class _ContactsState extends State<Contacts> {
  @override
  void initState() {
  loadUi();
    super.initState();
  }
  var isLoading = true;
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
          actions: [
            AddButton()
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(),
                  );
                },
              ));
  }
  
  void loadUi() async{
    final data = await SQLoperation.readContacts();
    setState(() {
      contacts = data;
      isLoading = false;
    });
  }
}


