// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/constants/api_path.dart';
import 'package:sample_app/core/utils/dependency_injection.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/enums/item_type.dart';
import 'package:sample_app/features/list_view/data/models/content.dart';
import 'package:sample_app/features/list_view/data/models/item_attributes.dart';
import 'package:sample_app/features/list_view/data/repositories/list_view_repository.dart';

part 'list_view_state.dart';

class ListViewCubit extends Cubit<ListViewState> {
  ListViewCubit() : super(ListViewInitial()) {
    getListContent();
  }

  String _currentDataSource = ApiPath.listData1;
  List<Content> _allItems = [];
  Gender? activeFilter;

  Future<void> getListContent({String? url}) async {
    if (url != null) {
      _currentDataSource = url;
    }
    emit(ListViewLoading());
    try {
      final listItems = await getIt<ListViewRepository>().getListContent(
        _currentDataSource,
      );
      _allItems = listItems;
      emit(ListViewLoaded(listItems: listItems));
    } catch (error) {
      emit(ListViewFailedToLoad());
    }
  }

  void setFilter(Gender? gender) {
    if (gender == activeFilter) {
      return;
    }
    activeFilter = gender;

    List<Content> filteredList = [];
    if (gender == null) {
      filteredList = List.from(_allItems);
    } else {
      for (final item in _allItems) {
        final attributes = item.attributes;
        if (item.type == ContentType.slider &&
            (attributes as ItemAttributes).items.any(
              (element) => element.gender == gender,
            )) {
          filteredList.add(
            Content(id: item.id, type: item.type)
              ..attributes = ItemAttributes(
                items:
                    attributes.items
                        .where((element) => element.gender == gender)
                        .toList(),
              ),
          );
        } else if (item.gender == gender || item.gender == null) {
          filteredList.add(item);
        }
      }
    }
    emit(ListViewLoaded(listItems: filteredList));
  }

  void switchDataSource() {
    if (_currentDataSource == ApiPath.listData1) {
      _currentDataSource = ApiPath.listData2;
    } else {
      _currentDataSource = ApiPath.listData1;
    }
    getListContent();
  }
}
