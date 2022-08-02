import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/starting-image.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Flexible(
                    flex: 2,
                    child: Image.asset("assets/logo-white.png",
                        fit: BoxFit.contain, height: 55)),
                Flexible(
                    fit: FlexFit.tight, flex: 11, child: Container(height: 10)),
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
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 45),
                                ),
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
                                    primary: Colors.white),
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
                // Flexible(
                //     flex: 1,
                //     child: Center(
                //         child: Text(
                //             'Twórz listy zakupów wspólnie z rodziną. Już nie zapomnisz o żadnym produkcie.',
                //             style:
                //                 TextStyle(color: Colors.white, fontSize: 30)))),
                // Flexible(
                //     flex: 1,
                //     child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           minimumSize: const Size(300, 45),
                //         ),
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => const SignUpPage()));
                //         },
                //         child: const Text('Utwórz konto'))),
                // const SizedBox(
                //   height: 10,
                // ),
                // Flexible(
                //     flex: 1,
                //     child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             minimumSize: const Size(300, 45),
                //             primary: Colors.white),
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => const SignInPage()));
                //         },
                //         child: const Text('Mam już konto',
                //             style: TextStyle(
                //               color: Colors.black,
                //             )))),
              ],
            )));
  }
}
