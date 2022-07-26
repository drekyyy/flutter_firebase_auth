import 'package:flutter/material.dart';

Future<String?> customShowDialog(
    BuildContext context,
    dialogTitle,
    Future<dynamic> Function(String, String, String) function,
    arg1,
    arg2,
    arg3) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(dialogTitle,
          style: const TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: TextButton(
            onPressed: () async {
              await function(arg1, arg2, arg3);
              Navigator.pop(context);
            },
            child: const Text('Tak',
                style: TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
          )),
        ],
      ),
    ),
  );
}
