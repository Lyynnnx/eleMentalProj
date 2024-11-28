import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:mentalproj/providers/basic_providers.dart';

class AudioPlayer {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  Future<void> initPlayer() async {
    await _player.openPlayer();
  }

  Future<void> play(String filePath, WidgetRef ref) async {
     print("слушаю по $filePath");
   if(ref.read(isPlayingProvider.notifier).state){
    await stop();
 //   await dispose();
    ref.read(isPlayingProvider.notifier).state=false;
   }
   else{
    
    if(ref.read(audioPathProvider)!=""){
      ref.read(isPlayingProvider.notifier).state=true;
    await initPlayer();
    await _player.startPlayer(fromURI: filePath);
    }
    else{
      print("yaghdya");
    }
    
   }
    
  }

  Future<void> stop() async {
    await _player.stopPlayer();
  }

  Future<void> dispose() async {
    await _player.closePlayer();
  }
}
