import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/utils/dependency_injection.dart';
import 'package:sample_app/core/utils/error_cubit.dart';

/// A widget that provides global blocs/cubits.
class GlobalBlocProviders extends StatefulWidget {
  /// Default constructor
  const GlobalBlocProviders({required this.child, super.key});

  /// The [child] widget to whom the blocs/cubits are provided.
  final Widget child;

  @override
  State<GlobalBlocProviders> createState() => _GlobalBlocProvidersState();
}

class _GlobalBlocProvidersState extends State<GlobalBlocProviders> {
  final _errorCubit = ErrorCubit();
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = setup(_errorCubit);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [BlocProvider.value(value: _errorCubit)],
            child: widget.child,
          );
        }
        // Option to show Splashscreen
        return const SizedBox.shrink();
      },
    );
  }
}
