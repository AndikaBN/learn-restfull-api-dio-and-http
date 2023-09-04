// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:restfull_api/model/person.dart';
import 'package:restfull_api/service/reqres_service.dart';
import 'package:restfull_api/widget/person_card.dart';

import 'list_person.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Person? person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (person != null)
              SizedBox(width: 200, child: PersonCard(person: person!))
            else
              const Text(
                "no data",
              ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                final result =
                    await ReqresServiceWithHttp().getDataPerson(context, "2");
                setState(() {
                  person = result;
                });
              },
              child: const Text("Get API Http"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const ContinuousRectangleBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                final result = await ReqresServiceWithHttp().postDataPerson(
                  context,
                  "Andika Bintang",
                  "Nursalih",
                  "bintangnursalih275@gmail.com",
                );
                setState(() {
                  person = result;
                });
              },
              child: const Text("Post API Http"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                final result =
                    await ReqresServiceWithdio().getDataPerson(context, "3");
                setState(() {
                  person = result;
                });
              },
              child: const Text("Get API dio"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const ContinuousRectangleBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                final result = await ReqresServiceWithdio().postDataPerson(
                  context,
                  "Indira Putri",
                  "Seruni",
                  "bintangnursalih275@gmail.com",
                );
                setState(() {
                  person = result;
                });
              },
              child: const Text("Post API Dio"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const ContinuousRectangleBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListPersonPage(),
                  ),
                );
              },
              child: const Text("get List data"),
            ),
          ],
        ),
      ),
    );
  }
}
