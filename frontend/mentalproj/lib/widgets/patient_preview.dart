import 'package:flutter/material.dart';
import 'package:mentalproj/models/patient.dart';

class PatientPreview extends StatelessWidget {
  const PatientPreview({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(child:Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      CircleAvatar(
                  backgroundImage: AssetImage(
                    '${patient.imgurl}',
                  ),
                  //radius: 100,
                  radius: MediaQuery.of(context).size.width * 0.25,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text("${patient.name}",  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Text("${patient.occupation}")

    ],));
  }
}