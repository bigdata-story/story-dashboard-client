import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/request_handler_bloc.dart';

class DynamicStateWrapper extends StatelessWidget {
  final String endPoint;
  final Widget Function(BuildContext, RequestHandlerState) builder;
  final Map<String, dynamic>? queryParameters;


  const DynamicStateWrapper({
    Key? key,
    required this.builder,
    required this.endPoint,
    this.queryParameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestHandlerBloc(
        endPoint: endPoint,
        queryParameters: queryParameters,
      ),
      child: BlocBuilder<RequestHandlerBloc, RequestHandlerState>(
        builder: builder,
      ),
    );
  }
}
