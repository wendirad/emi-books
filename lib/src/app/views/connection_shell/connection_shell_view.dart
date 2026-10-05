import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/errors/errors.dart';
import '../../blocs/connection_shell/connection_shell_bloc.dart';

class ConnectionShellView extends StatelessWidget {
  const ConnectionShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) =>
          ConnectionShellBloc()..add(ConnectionStatusSubscriptionRequested()),
      child: BlocBuilder<ConnectionShellBloc, ConnectionShellState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == ConnectionStatus.off) {
            return const ErrorView(errorType: ErrorTypes.noConnection);
          }

          if (state.status == ConnectionStatus.idle) {
            return const Center(child: CircularProgressIndicator());
          }

          return const RouterOutlet();
        },
      ),
    );
  }
}
