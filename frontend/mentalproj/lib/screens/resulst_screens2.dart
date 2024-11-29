import 'package:flutter/material.dart';
import 'package:mentalproj/widgets/grade.dart';
import 'package:mentalproj/widgets/show_rating_widget.dart';

class LastResult extends StatelessWidget {
   LastResult({super.key, required this.point1, required this.point2,required this.point3,required this.point4, required this.review});
  int point1, point2, point3, point4;
  String review;

  @override
  Widget build(BuildContext context) {
    print('$point1, $point2, $point3, $point4, $review');
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
           // ShowRatingWidget(),
            Row(children: [Spacer(), 
            Text("1", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("2", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("3", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("4", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 16,),
            Text("5", style: Theme.of(context).textTheme.displayMedium,), SizedBox(width: 4,)],),
            GradeWidget(grade: point1,text: "Identification of Negative Thought",),
            SizedBox(height: 8,),
            GradeWidget(grade: point2,text: "Challenge of Thought",),
             SizedBox(height: 8,),
            GradeWidget(grade: point3,text: "Reframing the Thought",),
             SizedBox(height: 8,),
            GradeWidget(grade: point4,text: "Testing the Reframed Thought",),
             SizedBox(height: 8,),
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
             SizedBox(height: 8,),
            Text('$review')
          
          ],
        ),
      ),
    );
  }
}
