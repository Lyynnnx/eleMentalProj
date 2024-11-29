import 'package:flutter/material.dart';
import 'package:mentalproj/dummy_data/practices_dummy.dart';
import 'package:mentalproj/screens/practice_screen.dart';

class MainDrawer extends StatelessWidget {
   MainDrawer(this.changeInex, {super.key});
  void Function(int) changeInex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //direction: Axis.vertical,
      runSpacing: 10,
      children: [
        ListTile(
          onTap: (){
            changeInex(0);
          },
          title: Text('My Profile',style:TextStyle(color:Colors.white),),
          tileColor: Color.fromARGB(205, 223, 4, 176),
        ),
        Divider(color: Colors.white,),
        ListTile(
          onTap: (){
            changeInex(0);
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return PracticeScreen(practices: dummyPractices);
            }));
          },
          title: Text('+ New patient',style:TextStyle(color:Colors.white),),
          tileColor: Color.fromARGB(205, 223, 4, 176),
        ),
        Divider(color: Colors.white,),
        Text("My patients:",style:TextStyle(color:Colors.white)),
        ListTile(
          onTap: (){
            changeInex(1);
          },
          title: Text('Bob',style:TextStyle(color:Colors.white),),
          tileColor: Color.fromARGB(255, 4, 193, 73),),
           ListTile(
          onTap: (){
            changeInex(1);
          },
          title: Text('Tommy',style:TextStyle(color:Colors.white),),
          tileColor: Color.fromARGB(255, 4, 193, 73),)

        
      ],
    );
  }
}
