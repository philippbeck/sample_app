import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/utils/url_launcher_helper.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/gender_cubit.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/list_view_cubit.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/enums/item_type.dart';
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
                listener: (context, state) {
                  context.read<ListViewCubit>().setFilter(state);
                },
                builder: (context, gender) {
                  return BlocBuilder<ListViewCubit, ListViewState>(
                    builder: (context, state) {
                      switch (state) {
                        case ListViewInitial():
                          return const SizedBox.shrink();
                        case ListViewLoading():
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        case ListViewLoaded():
                          return ListView(
                            key: _listKey,
                            children:
                                state.listItems.map((item) {
                                  switch (item.type) {
                                    case ContentType.teaser:
                                      final attributes =
                                          item.attributes as ImageAttributes;
                                      return ListTile(
                                        onTap: () {
                                          UrlLauncherHelper.openUrl(
                                            url: attributes.url,
                                          );
                                        },
                                        title: Text(attributes.headline),
                                        leading: Image.network(
                                          attributes.imageUrl,
                                        ),
                                      );
                                    case ContentType.slider:
                                      final attributes =
                                          item.attributes as ItemAttributes;
                                      return ItemSlider(
                                        key: Key('item_slider_${item.id}'),
                                        items: attributes.items,
                                      );
                                    case ContentType.brandSlider:
                                      return BrandSlider(
                                        key: Key('brand_slider_${item.id}'),
                                        item: item,
                                      );
                                  }
                                }).toList(),
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
