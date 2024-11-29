import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalproj/dummy_data/patients_dummy.dart';
import 'package:mentalproj/dummy_data/practices_dummy.dart';
import 'package:mentalproj/providers/clients_provider.dart';
import 'package:mentalproj/screens/discussion_screen.dart';
import 'package:mentalproj/widgets/patient_preview.dart';

class ChooseScreen extends ConsumerStatefulWidget {
  const ChooseScreen({super.key});

  @override
  ConsumerState<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends ConsumerState<ChooseScreen> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patients',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Color.fromARGB(255, 101, 101, 101)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Column(
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ Icon(Icons.arrow_left, size: 80,),
                    GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            // Свайп вправо
                            setState(() {
                              id = (id - 1) % patietnsDummy.length;
                            });
                            print("Swiped Right");
                          } else {
                            // Свайп влево
                            setState(() {
                              id = (id + 1) % patietnsDummy.length;
                            });
                          }
                        },
                        child: PatientPreview(patient: patietnsDummy[id])),
                        Icon(Icons.arrow_right, size: 80,),
                  ],
                ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                    ElevatedButton(
                  style: ButtonStyle(
                      //foregroundColor: ,
                      foregroundColor: WidgetStatePropertyAll(
                          Theme.of(context).primaryColor),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor)))),
                  onPressed: (){
                      ref.read(patientProvider.notifier).addPatient(patietnsDummy[id]);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DiscussionScreen(pathToPhoto: patietnsDummy[id].imgurl, name: patietnsDummy[id].name, backgroundStory: patietnsDummy[id].backstory);
                      }));
                    },
                  child: Text('Choose',
                      style: Theme.of(context).textTheme.labelMedium),
                ),








                    // ElevatedButton(onPressed: (){
                    //   ref.read(patientProvider.notifier).addPatient(patietnsDummy[id]);
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    //     return DiscussionScreen(pathToPhoto: patietnsDummy[id].imgurl, name: patietnsDummy[id].name, backgroundStory: patietnsDummy[id].backstory);
                    //   }));
                    // }, child: Text("Choose"))
              ],
            )),
      ),
    );
  }
}
