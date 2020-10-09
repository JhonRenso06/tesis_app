import 'package:mr_yupi/src/model/api_exception.dart';

abstract class BlocState<T> {
  final T message;
  final APIException exception;
  BlocState(this.message, {this.exception});
}

class InitialState<T> extends BlocState<T> {
  InitialState({T init}) : super(init);
}

class LoadingState<T> extends BlocState<T> {
  LoadingState({T data}) : super(data);
}

class LoadedState<T> extends BlocState<T> {
  LoadedState({T data}) : super(data);
}

class ErrorState<T> extends BlocState<T> {
  ErrorState({T data, APIException exception})
      : super(data, exception: exception);
}
