import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
//import 'package:flutter_sound/flutter_sound.dart';
import 'package:mentalproj/providers/basic_providers.dart';
import 'package:mentalproj/repositories/audio_repository.dart';
import 'package:mentalproj/repositories/auth_repository.dart';
import 'package:mentalproj/utils/audio_player.dart';
import 'package:mentalproj/widgets/recording_button.dart';
import 'package:mentalproj/widgets/show_rating_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TestVoice extends ConsumerStatefulWidget {
  const TestVoice({super.key});

  @override
  ConsumerState<TestVoice> createState() => _TestVoiceState();
}

class _TestVoiceState extends ConsumerState<TestVoice> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final player = AudioPlayer();

  void playsound(WidgetRef ref) async {
    print("mama");
    String res = ref.read(audioPathProvider);
    if (ref != "") {
      print("papa");
      await player.play(res, ref);
    }
  }

  // void recVoice(WidgetRef ref) async {
  //   if (!ref.watch(isRecordingProvider)) {
  //     print("погнали1");
  //     await Permission.microphone.request();
  //     print("погнали2");
  //     await recorder.openRecorder();
  //     ref.read(isRecordingProvider.notifier).update((ref) => true);
  //     print("погнали3");
  //     ref.read(isRecordingProvider.notifier).update((ref) => true);
  //     print("погнали4");
  //     final directory = await getTemporaryDirectory();
  //     filePath = '${directory.path}/audio.aac';
  //     await recorder.startRecorder(toFile: filePath);
  //   } else {
  //     ref.read(isRecordingProvider.notifier).update((ref) => false);
  //     result = await recorder.stopRecorder();
  //     print("всё");
  //     print("result $result");
  //     recorder.closeRecorder();
  //   }
  // }

  // String? filePath;
  // String? result;

  @override
  Widget build(BuildContext context) {
    bool id = ref.watch(isRecordingProvider.notifier).state;
    bool audioId = ref.watch(isPlayingProvider);
    final audioRepository = AudioRepository();
    final authrep=AuthRepository();

    return Scaffold(
      body: Center(
        child: Padding( padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("bebra"),
              // ElevatedButton(
              //   onPressed: () {
              //     recVoice(ref);
              //   },
              //   child: id ? Icon(Icons.square) : Icon(Icons.mic),
              // ),
              ElevatedButton(
                  onPressed: () {
                    playsound(ref);
                  },
                  child: audioId ? Icon(Icons.square) : Icon(Icons.volume_down)),
              RecordingButton(),
              ElevatedButton(
                  onPressed: () {
                    audioRepository.sendAudio(ref);
                  },
                  child: Text("post")),
              ElevatedButton(
                  onPressed: () {
                    audioRepository.getText(ref);
                  },
                  child: Text("get")),
              ShowRatingWidget(),
              TextButton(onPressed: (){
                  authrep.login1('sultan', '123');
              }, child: Text('register'))
            ],
          ),
        ),
      ),
    );
  }
}
