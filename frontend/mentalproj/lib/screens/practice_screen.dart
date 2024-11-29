 import 'package:flutter/material.dart';
import 'package:mentalproj/screens/main_screen.dart';

// class PracticeScreen extends StatefulWidget {
//   const PracticeScreen({super.key});

//   @override
//   State<PracticeScreen> createState() => _PracticeScreenState();
// }
// //TODO: Add everything, what is in tasks
// class _PracticeScreenState extends State<PracticeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(height: 200, width:200,

//         decoration: BoxDecoration( gradient: LinearGradient(colors: [Colors.white, Color.fromARGB(255, 101, 101, 101)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//       //padding: EdgeInsets.all(16.0),
//       padding:EdgeInsets.fromLTRB(16, 48, 16, 16),
      
//       child: Column(
//         children: [
//           Text("Practices", style:Theme.of(context).textTheme.displayLarge),
//           InkWell(
//             onTap: ()=>{},
//             child: Icon(Icons.arrow_right_outlined)
//           )
//         //  // ElevatedButton(onPressed: ()=>{}, child: Icon(Icons.arrow_right))
//         ],
//       )
      
//       );

//     }
// }

class PracticeScreen extends StatelessWidget {
  
  final List<String> practices; //= ['Practice A', 'Practice B', 'Practice C', 'Practice D'];
  PracticeScreen({required List<String> this.practices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice',style: Theme.of(context).textTheme.displayLarge ,)),
      body: ListView.builder(
        itemCount: practices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(practices[index], style:Theme.of(context).textTheme.displayMedium),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}