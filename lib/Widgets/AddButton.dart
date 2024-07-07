// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqfliteoperation/UI/Contacts.dart';

import '../DataBase/SQLoperation.dart';

class AddButton extends StatefulWidget {
   final Function onCreateContact;

  AddButton(this.onCreateContact);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    // showSheet(null, context);
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.amberAccent, borderRadius: BorderRadius.circular(50)),
      child: IconButton(
          onPressed: () => showSheet(null,),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  void showSheet(int? id,) async{
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom +120 ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 25, bottom: 15),
                  child: CircleAvatar(
                    radius: 100,
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  )),
              // name
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  controller: nameController,
                ),
              ),

              // number
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  controller: numberController,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await createContact();
                    } if (id != null) {
                    // await updateContact();
                    }
                  },
                  child: Text(id == null ? "Create" : "Update"))
            ],
          ),
        );
      },
    );

    
  }
  // to add a new data to the sqflite DB
 Future<void> createContact() async{
  await SQLoperation.create_contact(nameController.text, numberController.text);
  widget.onCreateContact(); // Call the callback function to refresh the UI
 }

}