import 'package:flutter/material.dart';

class GradeWidget extends StatelessWidget {
  final String text;
  int grade;
   GradeWidget({super.key, required this.text, required this.grade});
  

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10)),
      Spacer(),
      CircleAvatar(
        radius: 12,
        backgroundColor: 1 == grade ? Theme.of(context).primaryColor : Colors.white,

      ), 
      SizedBox(width: 8,),
      CircleAvatar(
        radius: 12,
        backgroundColor: 2 == grade ? Theme.of(context).primaryColor : Colors.white,
        
      ),
      SizedBox(width: 8,),
      CircleAvatar(
        radius: 12,
        backgroundColor: 3 == grade ? Theme.of(context).primaryColor : Colors.white,
        
      ),
      SizedBox(width: 8,),
      CircleAvatar(
        radius: 12,
        backgroundColor: 4 == grade ? Theme.of(context).primaryColor : Colors.white,
        
      ),
      SizedBox(width: 8,),
      CircleAvatar(
        radius: 12,
        backgroundColor: 5 == grade ? Theme.of(context).primaryColor : Colors.white,
        
      )
    ],
    );
  }
}