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
      title: Text(dialogTitle,
          style: const TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter some text.';
                    }
                    if (val.length > maxValueLength) {
                      return 'Name too long';
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
              Center(
                  child: TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    function(arg1, arg2, name);
                    Navigator.pop(context);
                  } else {
                    Text(firebaseResponse.toString());
                    firebaseResponse = '';
                  }
                },
                child: const Text('Ok',
                    style:
                        TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
              )),
            ],
          )),
    ),
  );
}



// Future<String?> customShowDialog(BuildContext context, String title,
//     int maxValueLength, AsyncCallback function) {
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController userNameController = TextEditingController();
//   String userName;
//   String? firebaseResponse = '';
//   return showDialog<String>(
//     context: context,
//     builder: (BuildContext context) => AlertDialog(
//       title: Text(title,
//           style: const TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
//       content: Form(
//           key: formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                   validator: (val) {
//                     if (val == null || val.isEmpty) {
//                       return 'Please enter some text.';
//                     }
//                     if (val.length > maxValueLength) {
//                       return 'Name too long';
//                     }

//                     return null;
//                   },
//                   onChanged: (val) {
//                     userName = val;
//                   },
//                   controller: userNameController,
//                   decoration: const InputDecoration(
//                     labelText: "Nowa nazwa",
//                   )),
//               Center(
//                   child: TextButton(
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     firebaseResponse = function.toString();
//                     Navigator.pop(context);
//                   } else {
//                     Text(firebaseResponse.toString());
//                     firebaseResponse = '';
//                   }
//                 },
//                 child: const Text('Ok',
//                     style:
//                         TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
//               )),
//             ],
//           )),
//     ),
//   );
// }