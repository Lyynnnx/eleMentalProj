import 'package:flutter_riverpod/flutter_riverpod.dart';

final isRecordingProvider = StateProvider<bool>((ref)=>false);
final isPlayingProvider = StateProvider<bool>((ref)=>false);
final audioPathProvider = StateProvider<String>((ref)=>"");
