import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocTransformers {
  static EventTransformer<T> droppable<T>() => (events, mapper) => events.flatMap(mapper).take(1);
  static EventTransformer<T> restartable<T>() => (events, mapper) => events.flatMap(mapper).take(1);
  static EventTransformer<T> sequential<T>() => (events, mapper) => events.flatMap(mapper);
  static EventTransformer<T> concurrent<T>() => (events, mapper) => events.flatMap(mapper);
}
