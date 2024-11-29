import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalproj/dummy_data/practices_dummy.dart';
import 'package:mentalproj/providers/basic_providers.dart';
import 'package:mentalproj/providers/clients_provider.dart';
import 'package:mentalproj/screens/main_screen.dart';
import 'package:mentalproj/screens/practice_screen.dart';
import 'package:mentalproj/widgets/main_drawer.dart';
import 'package:mentalproj/widgets/recording_button.dart';

class DiscussionScreen extends ConsumerStatefulWidget {
  DiscussionScreen(
      {super.key,
      required this.pathToPhoto,
      required this.name,
      required this.backgroundStory});
  String pathToPhoto;
  String name;
  String backgroundStory;

  @override
  ConsumerState<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends ConsumerState<DiscussionScreen> {

  void openDrawer(BuildContext context){
    Scaffold.of(context).openDrawer();
  }



void endConversation(){
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you really want to end a conversation?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                        ElevatedButton(onPressed: (){showModalBottomSheet(context: context, builder: (context){
                          return Container(height: MediaQuery.of(context).size.height*0.1, child: Center(child: Text("Chat with ${widget.name} was ended", textAlign: TextAlign.center,)));
                        });}, child: Text("yes")),
                       
                       SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                   
                        ElevatedButton(onPressed: (){return null;}, child: Text("no"))
                      ],)
                    ],
                  ),
                )),
          );
        });
  }


  void restartSecure(){
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you really want to restart a conversation?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                        ElevatedButton(onPressed: (){showModalBottomSheet(context: context, builder: (context){
                          return Container(height: MediaQuery.of(context).size.height*0.1, child: Center(child: Text("Chat with ${widget.name} was reseted", textAlign: TextAlign.center,)));
                        });}, child: Text("yes")),
                       
                       SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                   
                        ElevatedButton(onPressed: (){return null;}, child: Text("no"))
                      ],)
                    ],
                  ),
                )),
          );
        });
  }

  void showBackground(BuildContext context) {
    print("lesgo");
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Background:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text("${widget.backgroundStory}"),
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isRecording = ref.watch(isRecordingProvider);
    double opacity = isRecording ? 0.8 : 0;

    return Scaffold(
      endDrawer: MainDrawer((x){}),
       drawer: MainDrawer((x){}),
      body: Center(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Color.fromARGB(255, 101, 101, 101)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    '${widget.pathToPhoto}',
                  ),
                  radius: 100,
                ),
                Text(
                  "${widget.name}",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),

                Divider(),
              ],
            ),
          ),
          Opacity(
              opacity: opacity,
              child: Container(color: Color.fromARGB(255, 52, 52, 52))),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return TextButton(
                            onPressed: () {openDrawer(context);},
                            //child: Icon(Icons.settings_overscan_sharp),
                            child: Image.asset('assets/menu.png', scale: 10));
                      }
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {restartSecure();},
                      child: Image.asset(
                        'assets/restart_logo.png',
                        scale: 1.5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.37,
                ),
                TextButton(
                    onPressed: () {
                      showBackground(context);
                    },
                    child: Text("Show backstory",
                        style: Theme.of(context).textTheme.bodyMedium)),
                RecordingButton(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      //foregroundColor: ,
                      foregroundColor: WidgetStatePropertyAll(
                          Theme.of(context).secondaryHeaderColor),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).secondaryHeaderColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor)))),
                  onPressed: () => {endConversation()},
                  child: Text('End conversation',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
