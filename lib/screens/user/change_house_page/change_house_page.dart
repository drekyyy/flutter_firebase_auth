import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/database_service.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';

class ChangeHousePage extends StatefulWidget {
  const ChangeHousePage({Key? key}) : super(key: key);

  @override
  State<ChangeHousePage> createState() => _ChangeHousePageState();
}

class _ChangeHousePageState extends State<ChangeHousePage> {
  String houseIdMessage = '';
  final TextEditingController houseIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<SimpleUser?>(context)!.uid;
    return Scaffold(
        appBar: AppBar(title: const Text('Zmień dom')),
        body: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
                //           color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: houseIdController,
                              decoration: const InputDecoration(
                                labelText: "ID domu",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text.';
                                } else if (value.length < 10) {
                                  return 'House ID is too short.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Center(
                                child: Text(houseIdMessage,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center)),
                            const SizedBox(height: 25),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool houseExists = await DatabaseService
                                        .checkIfHouseExists(
                                            houseIdController.text.trim());
                                    if (houseExists == true) {
                                      await DatabaseService.updateUserHouseId(
                                          houseIdController.text.trim(), uid);
                                      Navigator.pop(context);
                                    } else {
                                      houseIdMessage = 'No such house.';
                                    }

                                    setState(() {});
                                  }
                                },
                                child: const Text('Potwierdź')),
                            const SizedBox(height: 15),
                          ],
                        ))),
              ],
            )));
  }
}
