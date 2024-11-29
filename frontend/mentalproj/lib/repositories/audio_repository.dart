import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/util/flutter_sound_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mentalproj/providers/basic_providers.dart';
import 'package:mentalproj/utils/audio_player.dart';
import 'package:path_provider/path_provider.dart';
class AudioRepository{

// final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();

// Future<String> convertAACtoWAV(String inputPath) async {
//   final outputPath = inputPath.replaceAll('.aac', '.wav');
//   final int rc = await _ffmpeg.execute('-i $inputPath $outputPath');
//   if (rc == 0) {
//     print("Конвертация завершена: $outputPath");
//     return outputPath;
//   } else {
//     throw Exception("Ошибка конвертации");
//   }
// }
  
//final uri=Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/audio/transcribe?request%20parameter=audio_file');
final uri=Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/audio/transcribe');
// final uriGet =Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/audio/getTranscriptedTextWithoutTokenNoJSON');
final uriGet =Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/audio/getTranscriptedTextWithoutToken');
final uriAudio = Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/audioReceiver/getLatestAudio');




  void sendAudio(WidgetRef ref)async{
    String filePath = ref.read(audioPathProvider);
   
    if(filePath==""){
      print("иди нафиг");
      return;
    }
    
    final request = http.MultipartRequest('Post', uri);
    //String sigma = await convertAACtoWAV(filePath);

    request.files.add(
    await http.MultipartFile.fromPath(
      'audio_file', // Название параметра на сервере
      filePath,
    ),
  );
 // request.fields['audio_file'] = 'true';
  print("будем принтить по пути $filePath");
  final response = await request.send();

  // Обработка ответа
  if (response.statusCode == 200) {
    print('Файл успешно отправлен');
  } else {
    print('Ошибка при отправке файла: ${response.statusCode}');
  }
  }



 void getText(WidgetRef ref) async{
    final response = await http.get(uriGet);
    if (response.statusCode == 200) {
      // Получение временной директории
      final directory = await getTemporaryDirectory();
      var result= jsonDecode(response.body);
      print(result['transcription']);
    } else {
      print('Ошибка при загрузке файла: ${response.statusCode}');
    }
 }

  void getAudio(WidgetRef ref) async{
    final response = await http.get(uriAudio);
    if (response.statusCode == 200) {
      // Получение временной директории
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/downloaded_file.mp3';

      // Запись данных в файл
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
     ref.read(audioResponseProvider.notifier).update((ref)=>filePath);
      print('Файл успешно сохранён: $filePath');
    } else {
      print('Ошибка при загрузке файла: ${response.statusCode}');
    }
  }
}