// ignore_for_file: public_member_api_docs

part of 'list_view_cubit.dart';

sealed class ListViewState extends Equatable {
  const ListViewState();

  @override
  List<Object> get props => [];
}

final class ListViewInitial extends ListViewState {}

final class ListViewLoading extends ListViewState {}

final class ListViewLoaded extends ListViewState {
  const ListViewLoaded({required this.listItems});

  final List<Content> listItems;

  @override
  List<Object> get props => [listItems];
}

final class DataSourceSwitched extends ListViewLoaded {
  const DataSourceSwitched({required super.listItems});
}

final class ListViewFailedToLoad extends ListViewState {}
