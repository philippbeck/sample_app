import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/brand_items_cubit.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/gender_cubit.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/models/content.dart';
import 'package:sample_app/features/list_view/data/models/url_attributes.dart';
import 'package:sample_app/features/list_view/presentation/widgets/item_slider.dart';

/// A widget that displays a remote set of items that has to be fetched first.
class BrandSlider extends StatelessWidget {
  /// Default constructor
  const BrandSlider({required this.item, super.key});

  /// The item to display
  final Content item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              BrandItemsCubit(url: (item.attributes as UrlAttributes).itemsUrl),
      child: BlocListener<GenderCubit, Gender?>(
        listener: (context, state) {
          context.read<BrandItemsCubit>().setFilter(state);
        },
        child: BlocBuilder<BrandItemsCubit, BrandItemsState>(
          builder: (context, state) {
            switch (state) {
              case BrandItemsInitial():
                return const SizedBox.shrink();
              case BrandItemsLoading():
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case BrandItemsLoaded():
                return ItemSlider(items: state.items);
              case BrandItemsFailedToLoad():
                return const Center(child: Text('Failed to load data.'));
            }
          },
        ),
      ),
    );
  }
}
