import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mentalproj/providers/basic_providers.dart';
class AudioRepository{

  void sendAudio(WidgetRef ref)async{
    String filePath = ref.read(audioPathProvider);
    if(filePath==""){
      return;
    }
    final uri=Uri.parse('http:sultan.com');
    final request = http.MultipartRequest('Post', uri);
  }
}