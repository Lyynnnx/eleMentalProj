import 'package:flutter/material.dart';
import 'package:mentalproj/models/patient.dart';

class PatientPreview extends StatelessWidget {
  const PatientPreview({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(child:Column(children: [
      CircleAvatar(
                  backgroundImage: AssetImage(
                    '${patient.imgurl}',
                  ),
                  radius: 100,
                ),
                Text("${patient.name}",  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Text("${patient.backstory}")

    ],));
  }
}