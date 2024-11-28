import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mentalproj/providers/basic_providers.dart';
import 'package:path_provider/path_provider.dart';
class AudioRepository{
  
final uri=Uri.parse('https://yourserver.com/upload');

  void sendAudio(WidgetRef ref)async{
    String filePath = ref.read(audioPathProvider);
    if(filePath==""){
      print("иди нафиг");
      return;
    }
    
    final request = http.MultipartRequest('Post', uri);
    request.files.add(
    await http.MultipartFile.fromPath(
      'file', // Название параметра на сервере
      filePath,
    ),
  );
  print("будем принтить по пути $filePath");
  final response = await request.send();

  // Обработка ответа
  if (response.statusCode == 200) {
    print('Файл успешно отправлен');
  } else {
    print('Ошибка при отправке файла: ${response.statusCode}');
  }
  }

  void getAudio(WidgetRef ref) async{
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // Получение временной директории
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/downloaded_file';

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