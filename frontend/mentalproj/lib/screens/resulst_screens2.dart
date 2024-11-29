import 'package:flutter/material.dart';
import 'package:mentalproj/widgets/grade.dart';
import 'package:mentalproj/widgets/show_rating_widget.dart';

class LastResult extends StatelessWidget {
   LastResult({super.key, required this.point1, required this.point2,required this.point3,required this.point4, required this.review});
  int point1, point2, point3, point4;
  String review;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results', style: Theme.of(context).textTheme.displayLarge,), backgroundColor: Colors.white,),
      body: Container(
        padding: EdgeInsets.all(16.0),
            //width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Color.fromARGB(255, 101, 101, 101)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
        child: Column(
          
          children: [
            ShowRatingWidget(),
            Row(children: [Spacer(), 
            Text("1", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("2", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("3", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("4", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("5", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 4,)],),
            GradeWidget(grade: point1,text: "Popa",),
            GradeWidget(grade: point2,text: "Bebra",),
            GradeWidget(grade: point3,text: "Mama",),
            GradeWidget(grade: point4,text: "PoAmogusa",),
          
          ],
        ),
      ),
    );
  }
}
