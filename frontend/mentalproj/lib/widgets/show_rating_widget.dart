import 'package:flutter/material.dart';

class ShowRatingWidget extends StatefulWidget {
  ShowRatingWidget({super.key});

  @override
  State<ShowRatingWidget> createState() => _ShowRatingWidgetState();
}

class _ShowRatingWidgetState extends State<ShowRatingWidget> {
  @override
  Widget build(BuildContext context) {
    double score = 0.61;
    return Container(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            borderOnForeground: true,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: Text("${score * 100}%"),
              ),
            ),
            margin: EdgeInsets.all(10),
          ),
          Stack(
            children: [
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * score,
                  ),
                 
                    Container(
                      decoration: BoxDecoration(color:Colors.black, shape: BoxShape.circle),
                      width: 19, height: 19,
                      child: Text(""),
                      
                    ),
                  
                ],
              ),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/sad_face.png'),
              Spacer(),
              Image.asset('assets/smile_face.png', scale:10)
            ],
          )
        ],
      ),
    );
  }
}
