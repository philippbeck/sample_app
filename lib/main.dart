import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/utils/bloc_observer.dart';
import 'package:sample_app/core/utils/error_cubit.dart';
import 'package:sample_app/core/widgets/global_bloc_providers.dart';
import 'package:sample_app/features/list_view/presentation/list_view_page.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const MainApp());
}

/// Main entry point of the app.
class MainApp extends StatelessWidget {
  /// Default constructor
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBlocProviders(
      child: MaterialApp(
        home: BlocListener<ErrorCubit, ErrorState>(
          listener: (context, state) {
            if (state is UnknownError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Unknown error occurred. Please try again later.',
                  ),
                ),
              );
            }
          },
          child: const ListViewPage(),
        ),
      ),
    );
  }
}
