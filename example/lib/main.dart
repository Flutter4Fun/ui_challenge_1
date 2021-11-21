import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_challenge_1/ui_challenge_1.dart';
import 'utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              Widget uiChallenge1;
              if (kIsWeb && constraints.biggest.width > 500) {
                uiChallenge1 = ConstrainedBox(
                  constraints: BoxConstraints.tight(
                    Size(600, constraints.biggest.height),
                  ),
                  child: UiChallenge1(),
                );
              } else {
                uiChallenge1 = UiChallenge1();
              }

              if (!kIsWeb) {
                return uiChallenge1;
              }

              return Column(
                children: [
                  Expanded(child: uiChallenge1),
                  Container(
                    color: const Color(0xFF20202A),
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Utils.launchURL(
                                'https://flutter4fun.com/ui-challenge-1');
                          },
                          child: const Text('Blog Post in Flutter 4 Fun'),
                        ),
                        const MyDivider(),
                        TextButton(
                          onPressed: () {
                            Utils.launchURL(
                                'https://github.com/Flutter4Fun/UI-Challenge-1');
                          },
                          child: const Text('Source Code'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 1,
      color: const Color(0xFFA7A7A7),
      margin: const EdgeInsets.only(top: 2),
    );
  }
}