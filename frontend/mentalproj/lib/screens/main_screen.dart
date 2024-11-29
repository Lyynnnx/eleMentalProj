import 'package:flutter/material.dart';
import 'package:mentalproj/repositories/auth_repository.dart';
import 'package:mentalproj/screens/test_voice_send.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

//TODO: Add everything, what is in tasks
class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();
    return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Color.fromARGB(255, 101, 101, 101)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bebra Popa Mama',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 24,
            ),
            Material(
              borderRadius: BorderRadius.circular(10.0),

              //borderRadius: BorderRadius.all(Radius.elliptical(10,10)),
              child: TextFormField(
                scribbleEnabled: false,
                decoration: InputDecoration(
                    //border: UnderlineInputBorder(),
                    //labelText: 'Email',
                    label: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text("Email")
                  ],
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Material(
              borderRadius: BorderRadius.circular(10.0),

              //borderRadius: BorderRadius.all(Radius.elliptical(10,10)),

              child: TextFormField(
                decoration: InputDecoration(
                  label: Row(children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text("Password")
                  ]),
                  //border:
                  //labelText: 'Password',
                  //labelStyle: Theme.of(context).textTheme.bodyMedium
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)))),
              onPressed: () {
                authRepository.login("sultan", "123");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TestVoice();
                    },
                  ),
                );
              },
              child:
                  Text('Log In', style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ));
  }
}
