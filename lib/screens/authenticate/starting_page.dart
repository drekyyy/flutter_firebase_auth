import 'package:flutter/material.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/starting-image.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Flexible(
                    flex: 2,
                    child: Image.asset("assets/images/app-icon.png",
                        fit: BoxFit.contain, height: 55)),
                Flexible(
                    fit: FlexFit.tight, flex: 10, child: Container(height: 10)),
                Flexible(
                    flex: 9,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Center(
                                child: Text(
                              'Twórz listy zakupów wspólnie z rodziną. Już nie zapomnisz o żadnym produkcie.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Roboto'),
                              textAlign: TextAlign.center,
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            const Size(300, 45)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green.shade900)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: const Text('Utwórz konto')),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 45),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInPage()));
                                },
                                child: const Text('Mam już konto',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))),
                          ],
                        )))
              ],
            )));
  }
}
