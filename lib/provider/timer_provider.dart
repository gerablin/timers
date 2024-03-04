
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//
final currentTimeProvider = StateProvider<double>((ref) {
  return 1.0;
});