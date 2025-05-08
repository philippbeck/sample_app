// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/constants/api_path.dart';
import 'package:sample_app/core/utils/dependency_injection.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/models/content.dart';
import 'package:sample_app/features/list_view/data/repositories/list_view_repository.dart';

part 'list_view_state.dart';

class ListViewCubit extends Cubit<ListViewState> {
  ListViewCubit() : super(ListViewInitial()) {
    getListContent();
  }

  String _currentDataSource = ApiPath.listData1;
  Gender? activeFilter;

  Future<void> getListContent({
    String? url,
    bool switchDataSource = false,
  }) async {
    if (url != null) {
      _currentDataSource = url;
    }
    if (!switchDataSource) {
      emit(ListViewLoading());
    }
    try {
      final listItems = await getIt<ListViewRepository>().getListContent(
        _currentDataSource,
      );
      if (switchDataSource) {
        emit(DataSourceSwitched(listItems: listItems));
      } else {
        emit(ListViewLoaded(listItems: listItems));
      }
    } catch (error) {
      emit(ListViewFailedToLoad());
    }
  }

  void switchDataSource() {
    if (_currentDataSource == ApiPath.listData1) {
      _currentDataSource = ApiPath.listData2;
    } else {
      _currentDataSource = ApiPath.listData1;
    }
    getListContent(switchDataSource: true);
  }
}
