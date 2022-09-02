part of 'request_handler_bloc.dart';

@immutable
abstract class RequestHandlerState {}

class RequestHandlerInitial extends RequestHandlerState {}

class RequestHandlerLoaded extends RequestHandlerState {
  final dynamic ans;

  RequestHandlerLoaded(this.ans);
}

class RequestHandlerError extends RequestHandlerState {
  final String message;

  RequestHandlerError({required this.message});
}
