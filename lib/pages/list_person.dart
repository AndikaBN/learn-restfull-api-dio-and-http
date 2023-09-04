// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:restfull_api/service/reqres_service.dart';
import 'package:restfull_api/widget/person_card.dart';

import '../model/person.dart';

class ListPersonPage extends StatefulWidget {
  const ListPersonPage({Key? key}) : super(key: key);

  @override
  State<ListPersonPage> createState() => _ListPersonPageState();
}

class _ListPersonPageState extends State<ListPersonPage> {
  List<Person>? person;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getListUser());
  }

  getListUser() async {
    final result = await ReqresServiceWithdio().getListPerson(context);
    person = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Person"),
        actions: const [],
      ),
      body: person == null
          ? const Center(
              child: Text("no data"),
            )
          : ListView.builder(
              itemCount: person!.length,
              itemBuilder: (context, index) {
                final persons = person![index];
                return PersonCard(person: persons);
              },
            ),
    );
  }
}
