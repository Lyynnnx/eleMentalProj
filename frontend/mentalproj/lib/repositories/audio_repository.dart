import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/util/flutter_sound_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mentalproj/models/result_model.dart';
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
final resulturi = Uri.parse('https://troll-engaged-cougar.ngrok-free.app/api/audio/getEvaluation');
late int duration=1000;
//late AudioPlayer _audioPlayer;



  void sendAudio(WidgetRef ref)async{
    // _audioPlayer=AudioPlayer();
    String filePath = ref.read(audioPathProvider);
    
    final aupl = AudioPlayer();
    print("пошло");
    
  
   
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
    String res = ref.read(audioResponseProvider);
    print('Файл успешно отправлен');
    await getAudio(ref);
    String path= ref.watch(audioResponseProvider);
    // while(path!=''){
    //   print(path);
    // }
    //await _audioPlayer.setFilePath(path);
     //await _audioPlayer.play();
    res=ref.watch(audioResponseProvider);
    print('$duration $res');
    aupl.play(res, ref, duration);

  } else {
    print('Ошибка при отправке файла: ${response.statusCode}');
  }
  }


//     void sendAudio(WidgetRef ref)async{
//     String filePath = ref.read(audioPathProvider);
   
//     if(filePath==""){
//       print("иди нафиг");
//       return;
//     }
    
//     final request = http.MultipartRequest('Post', uri);
//     //String sigma = await convertAACtoWAV(filePath);

//     request.files.add(
//     await http.MultipartFile.fromPath(
//       'audio_file', // Название параметра на сервере
//       filePath,
//     ),
//   );
//  // request.fields['audio_file'] = 'true';
//   print("будем принтить по пути $filePath");
//   final response = await request.send();


//   //final response = await http.get(uriAudio);
//     if (response.statusCode == 200) {
//       // Получение временной директории
//       final directory = await getTemporaryDirectory();
//       final filePath = '${directory.path}/downloaded_file.mp3';

//       // Запись данных в файл
//       final file = File(filePath);
//       await file.writeAsBytes(response.bodyBytes);
//      ref.read(audioResponseProvider.notifier).update((ref)=>filePath);
     

//   // Обработка ответа
//   if (response.statusCode == 200) {
//     print('Файл успешно отправлен');
//   } else {
//     print('Ошибка при отправке файла: ${response.statusCode}');
//   }
//   }




 Future<void> getText(WidgetRef ref) async{
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

  Future<void> getAudio(WidgetRef ref) async{
    print("есть аудио");
    final response = await http.get(uriAudio);
    if (response.statusCode == 200) {
      duration=int.parse(response.headers['audio-duration']!);
      print("$duration");
     
      // Получение временной директории
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/downloaded_file.mp3';

      // Запись данных в файл
      final file = File(filePath);
      print("живем");
      await file.writeAsBytes(response.bodyBytes);
      print("норм");
      ref.read(audioResponseProvider.notifier).update((ref)=>filePath);
      print('Файл успешно сохранён: $filePath');
    } else {
      print('Ошибка при загрузке файла: ${response.statusCode}');
    }
  }



  Future<ResultModel> getResult()async {
    final response = await http.get(resulturi);
    
    if (response.statusCode == 200) {
      // Получение временной директории
      final filtered = jsonDecode(response.body);
      int point1=(filtered['aspect1']);
      int point2=(filtered['aspect2']);
      int point3=(filtered['aspect3']);
      int point4=(filtered['aspect4']);
      String textovik=filtered['text'];
      return ResultModel(point1: point1, point2: point2, point3: point3, point4: point4, textovik: textovik);

      //filtered['text'];
      //print(result['transcription']);
    } else {
      print('Ошибка при загрузке файла: ${response.statusCode}');
      return ResultModel(point1: 0, point2: 0, point3: 0, point4: 0, textovik: 'textovik');
    }

  }

   
}