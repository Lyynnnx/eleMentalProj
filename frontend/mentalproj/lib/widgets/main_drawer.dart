import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalproj/dummy_data/practices_dummy.dart';
import 'package:mentalproj/providers/clients_provider.dart';
import 'package:mentalproj/screens/discussion_screen.dart';
import 'package:mentalproj/screens/practice_screen.dart';

class MainDrawer extends ConsumerStatefulWidget {
  MainDrawer(this.changeInex, {super.key});
  void Function(int) changeInex;

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      //direction: Axis.vertical,
      runSpacing: 10,
      children: [
        ListTile(
          onTap: () {
            widget.changeInex(0);
          },
          title: Text(
            'My Profile',
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Color.fromARGB(205, 223, 4, 176),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          onTap: () {
            widget.changeInex(0);
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return PracticeScreen(practices: dummyPractices);
            }));
          },
          title: Text(
            '+ New patient',
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Color.fromARGB(205, 223, 4, 176),
        ),
        Divider(
          color: Colors.white,
        ),
        Text("My patients:", style: TextStyle(color: Colors.white)),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: ref.watch(patientProvider).length == 0
                ? 1
                : ref.watch(patientProvider).length,
            itemBuilder: (context, index) {
              return ref.watch(patientProvider).length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("You have no patients yet",
                          style: TextStyle(color: Colors.white)),
                    )
                  : ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DiscussionScreen(
                                  pathToPhoto:
                                      ref.watch(patientProvider)[index].imgurl,
                                  name: ref.watch(patientProvider)[index].name,
                                  backgroundStory: ref
                                      .watch(patientProvider)[index]
                                      .backstory);
                            },
                          ),
                        );
                      },
                      title: Text(
                        '${ref.watch(patientProvider)[index].name}',
                        style: TextStyle(color: Colors.white),
                      ),
                      tileColor: Color.fromARGB(255, 4, 193, 73),
                    );
            },
          ),
        )
      ],
    );
  }
}
