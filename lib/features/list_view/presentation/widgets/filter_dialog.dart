import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/gender_cubit.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';

/// A dialog that allows the user to filter the list of items
class FilterDialog extends StatelessWidget {
  /// Default constructor
  const FilterDialog({super.key});

  /// Shows the filter dialog
  static void show({required BuildContext context}) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<GenderCubit>(),
          child: const FilterDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter'),
      content: BlocBuilder<GenderCubit, Gender?>(
        builder: (context, gender) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<Gender>(
                value: Gender.male,
                groupValue: gender,
                onChanged: (value) {
                  if (value != null) {
                    context.read<GenderCubit>().filterGender(value);
                  }
                },
                title: const Text('Male'),
              ),
              RadioListTile<Gender>(
                value: Gender.female,
                groupValue: gender,
                onChanged: (value) {
                  if (value != null) {
                    context.read<GenderCubit>().filterGender(value);
                  }
                },
                title: const Text('Female'),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          child: const Text('Reset'),
          onPressed: () {
            context.read<GenderCubit>().resetFilter();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
