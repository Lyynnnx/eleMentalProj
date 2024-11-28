import 'package:flutter/material.dart';

class TestVoice extends StatefulWidget {
  const TestVoice({super.key});

  @override
  State<TestVoice> createState() => _TestVoiceState();
}

void recVoice(){
  print("hi");
}

class _TestVoiceState extends State<TestVoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child:Column(children: [
        Text("bebra"),
        ElevatedButton(onPressed: (){recVoice();}, child: Icon(Icons.mic)),
      ],))
    );
  }
}