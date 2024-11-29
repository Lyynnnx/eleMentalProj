import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalproj/providers/basic_providers.dart';
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
  @override
  Widget build(BuildContext context) {
    bool isRecording = ref.watch(isRecordingProvider);
    double opacity = isRecording?0.8:0;
    
    return Scaffold(
      body: Center(
        child: Stack(
          children:[ Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Color.fromARGB(255, 101, 101, 101)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Icon(Icons.settings_overscan_sharp),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/restart_logo.png',
                        scale: 1.5,
                      ),
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    '${widget.pathToPhoto}',
                  ),
                  radius: 100,
                ),
                Text(
                  "${widget.name}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                TextButton(clipBehavior: Clip.none,   iconAlignment : IconAlignment.end, onPressed: (){},child: Text("show backstory",   style: TextStyle(fontSize: 10,), )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Divider(),
                ElevatedButton(onPressed: () {}, child: Text("End conversation"))
              ],
            ),
          ),
          Opacity(opacity:opacity, child: Container(color:Color.fromARGB(255, 52, 52, 52))),
          Center(
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.6,),
              RecordingButton()
            ],),
          )
          ]
        ),
      ),
    );
  }
}
