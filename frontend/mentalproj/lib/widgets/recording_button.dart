import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:mentalproj/providers/basic_providers.dart';
//import 'package:flutter_sound/flutter_sound.dart';`
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordingButton extends ConsumerStatefulWidget {
   RecordingButton({super.key});

  @override
 ConsumerState<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends ConsumerState<RecordingButton> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  void recVoice(WidgetRef ref) async {
    if (!ref.watch(isRecordingProvider)) {
      await Permission.microphone.request();
      await recorder.openRecorder();
      ref.read(isRecordingProvider.notifier).update((ref) => true);
      ref.read(isRecordingProvider.notifier).update((ref) => true);
      final directory = await getTemporaryDirectory();
      filePath = '${directory.path}/audio.aac';
      await recorder.startRecorder(toFile: filePath);
    } else {
      ref.read(isRecordingProvider.notifier).update((ref) => false);
      result = await recorder.stopRecorder();
      ref.read(audioPathProvider.notifier).update((ref)=>result!);
      print(ref.read(audioPathProvider.notifier));
      print("result $result");
      recorder.closeRecorder();
    }
  }
  String? filePath;
  String? result;
  @override
  Widget build(BuildContext context) {
    bool id = ref.watch(isRecordingProvider.notifier).state;
    return TextButton(child: Image.asset(id?'assets/square_logo.png' :'assets/micro_logo.png'),onPressed: (){
      recVoice(ref);
    },);
  }
}