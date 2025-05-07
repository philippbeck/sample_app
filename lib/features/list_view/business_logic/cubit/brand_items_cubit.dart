// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/utils/dependency_injection.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/models/item.dart';
import 'package:sample_app/features/list_view/data/repositories/list_view_repository.dart';

part 'brand_items_state.dart';

class BrandItemsCubit extends Cubit<BrandItemsState> {
  BrandItemsCubit({required String url}) : super(BrandItemsInitial()) {
    getBrandContent(url);
  }

  List<Item> _allItems = [];
  Gender? activeFilter;

  Future<void> getBrandContent(String url) async {
    emit(BrandItemsLoading());
    try {
      final brandItems = await getIt<ListViewRepository>().getBrandItems(url);
      _allItems = brandItems;
      emit(BrandItemsLoaded(items: brandItems));
    } catch (error) {
      emit(BrandItemsFailedToLoad());
    }
  }

  void setFilter(Gender? gender) {
    if (gender == activeFilter) {
      return;
    }
    activeFilter = gender;

    List<Item> filteredItems;
    if (gender == null) {
      filteredItems = List.from(_allItems);
    } else {
      filteredItems = _allItems.where((item) => item.gender == gender).toList();
    }
    emit(BrandItemsLoaded(items: filteredItems));
  }
}
