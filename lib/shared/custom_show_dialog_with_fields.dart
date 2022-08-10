import 'package:flutter/material.dart';

Future<String?> customShowDialogWithFields(
    BuildContext context,
    String dialogTitle,
    String dialogLabelText,
    int maxValueLength,
    Future<dynamic> Function(String, String, String) function,
    String arg1,
    String arg2) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  String name = '';
  String? firebaseResponse = '';
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(dialogTitle),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Podaj nazwe.';
                    }
                    if (val.length > maxValueLength) {
                      return 'Nazwa za długa.';
                    }

                    return null;
                  },
                  onChanged: (val) {
                    name = val;
                  },
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: dialogLabelText,
                  )),
              const SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    function(arg1, arg2, name);
                    Navigator.pop(context);
                  } else {
                    Text(firebaseResponse.toString());
                    firebaseResponse = '';
                  }
                },
                child: const Text(
                  'Ok',
                ),
              )),
            ],
          )),
    ),
  );
}

Future<String?> customShowDialogWithFieldsFourArgsFun(
    BuildContext context,
    String dialogTitle,
    String dialogLabelText,
    int maxValueLength,
    Future<dynamic> Function(String, String, String, String) function,
    String arg1,
    String arg2,
    String arg4) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  String name = '';
  String? firebaseResponse = '';
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(dialogTitle),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Podaj nazwe.';
                    }
                    if (val.length > maxValueLength) {
                      return 'Nazwa za długa.';
                    }

                    return null;
                  },
                  onChanged: (val) {
                    name = val;
                  },
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: dialogLabelText,
                  )),
              const SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    function(arg1, arg2, name, arg4);
                    Navigator.pop(context);
                  } else {
                    Text(firebaseResponse.toString());
                    firebaseResponse = '';
                  }
                },
                child: const Text(
                  'Ok',
                ),
              )),
            ],
          )),
    ),
  );
}
