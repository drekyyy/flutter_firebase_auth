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
      title: Text(dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: ElevatedButton(
            onPressed: () async {
              await function(arg1, arg2, arg3);

              Navigator.pop(context);
            },
            child: const Text('Tak'),
          )),
        ],
      ),
    ),
  );
}
