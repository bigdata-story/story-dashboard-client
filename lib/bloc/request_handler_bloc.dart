// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:story_dashboard_client/main.dart';
import 'package:story_dashboard_client/utils/api_provider.dart';

part 'request_handler_event.dart';
part 'request_handler_state.dart';

class RequestHandlerBloc
    extends Bloc<RequestHandlerEvent, RequestHandlerState> {
  late Timer _timer;
  final String endPoint;
  final Map<String, dynamic>? queryParameters;
  RequestHandlerBloc({
    required this.endPoint,
    this.queryParameters,
  }) : super(RequestHandlerInitial()) {
    log('Request handler started!');
    add(Request());
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        add(Request());
      },
    );

    on<RequestHandlerEvent>((event, emit) async {
      if (event is Request) {
        try {
          final ans = await sl<ApiProvider>().get(
            endPoint,
            queryParameters: queryParameters,
          );
          emit(RequestHandlerLoaded(ans["count"].toString()));
        } catch (e) {
          emit(RequestHandlerError(message: e.toString()));
        }
      }
    });
  }
  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
