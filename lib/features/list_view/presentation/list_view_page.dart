import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/utils/url_launcher_helper.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/gender_cubit.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/list_view_cubit.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/enums/item_type.dart';
import 'package:sample_app/features/list_view/data/models/content.dart';
import 'package:sample_app/features/list_view/data/models/image_attributes.dart';
import 'package:sample_app/features/list_view/data/models/item_attributes.dart';
import 'package:sample_app/features/list_view/presentation/widgets/brand_slider.dart';
import 'package:sample_app/features/list_view/presentation/widgets/filter_dialog.dart';
import 'package:sample_app/features/list_view/presentation/widgets/item_slider.dart';

/// Displays a list of different items in a list view.
class ListViewPage extends StatefulWidget {
  /// Default constructor
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Content> _items = [];

  void _updateItems({required List<Content> items, Gender? gender}) {
    final newList =
        items
            .where(
              (element) =>
                  element.gender == null ||
                  element.gender == gender ||
                  gender == null,
            )
            .toList();

    // Find items to remove
    final itemsToRemove =
        _items
            .where(
              (oldItem) => !newList.any((newItem) => newItem.id == oldItem.id),
            )
            .toList();

    // Find items to add
    final itemsToAdd =
        newList
            .where(
              (newItem) => !_items.any((oldItem) => newItem.id == oldItem.id),
            )
            .toList();

    // Remove items
    for (final itemToRemove in itemsToRemove) {
      final index = _items.indexWhere((item) => item.id == itemToRemove.id);
      if (index != -1) {
        _listKey.currentState?.removeItem(
          index,
          (context, animation) => _slideTransition(context, index, animation),
          duration: const Duration(milliseconds: 300),
        );
        Future.delayed(const Duration(milliseconds: 300), () {
          _items.removeAt(index);
        });
      }
    }

    // Insert new items
    for (final itemToAdd in itemsToAdd) {
      final index = newList.indexWhere((item) => item.id == itemToAdd.id);
      _items.insert(index, itemToAdd);
      _listKey.currentState?.insertItem(
        index,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ListViewCubit()),
        BlocProvider(create: (context) => GenderCubit()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: RefreshIndicator(
              onRefresh: context.read<ListViewCubit>().getListContent,
              child: BlocConsumer<GenderCubit, Gender?>(
                listener: (context, gender) {
                  final state = context.read<ListViewCubit>().state;
                  if (state is ListViewLoaded) {
                    _updateItems(items: state.listItems, gender: gender);
                  }
                },
                builder: (context, gender) {
                  return BlocConsumer<ListViewCubit, ListViewState>(
                    listener: (context, state) {
                      if (state is DataSourceSwitched) {
                        _updateItems(items: state.listItems, gender: gender);
                      } else if (state is ListViewLoaded) {
                        _items =
                            state.listItems
                                .where(
                                  (element) =>
                                      element.gender == gender ||
                                      gender == null ||
                                      element.gender == null,
                                )
                                .toList();
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            !(previous is ListViewLoaded &&
                                    current is DataSourceSwitched ||
                                previous is DataSourceSwitched &&
                                    current is DataSourceSwitched),
                    builder: (context, state) {
                      switch (state) {
                        case ListViewInitial():
                          return const SizedBox.shrink();
                        case ListViewLoading():
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        case ListViewLoaded():
                          return AnimatedList(
                            key: _listKey,
                            initialItemCount: _items.length,
                            itemBuilder: _slideTransition,
                          );
                        case ListViewFailedToLoad():
                          return Stack(
                            children: [
                              const Center(child: Text('Failed to load data.')),
                              ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                              ),
                            ],
                          );
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _slideTransition(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    final item = _items[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: switch (item.type) {
        ContentType.teaser => ListTile(
          key: Key('teaser_${item.id}'),
          onTap: () {
            UrlLauncherHelper.openUrl(
              url: (item.attributes as ImageAttributes).url,
            );
          },
          title: Text((item.attributes as ImageAttributes).headline),
          leading: Image.network((item.attributes as ImageAttributes).imageUrl),
        ),
        ContentType.slider => ItemSlider(
          key: Key('item_slider_${item.id}'),
          items: (item.attributes as ItemAttributes).items,
        ),
        ContentType.brandSlider => BrandSlider(
          key: Key('brand_slider_${item.id}'),
          item: item,
        ),
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Sample App'),
      actions: [
        IconButton(
          icon: const Icon(Icons.switch_right_outlined),
          tooltip: 'Switch data source',
          onPressed: context.read<ListViewCubit>().switchDataSource,
        ),
        IconButton(
          icon: const Icon(Icons.filter_alt_rounded),
          tooltip: 'Filter',
          onPressed: () {
            FilterDialog.show(context: context);
          },
        ),
      ],
    );
  }
}
