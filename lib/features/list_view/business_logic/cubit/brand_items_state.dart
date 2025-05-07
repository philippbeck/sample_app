// ignore_for_file: public_member_api_docs

part of 'brand_items_cubit.dart';

sealed class BrandItemsState extends Equatable {
  const BrandItemsState();

  @override
  List<Object> get props => [];
}

final class BrandItemsInitial extends BrandItemsState {}

final class BrandItemsLoading extends BrandItemsState {}

final class BrandItemsLoaded extends BrandItemsState {
  const BrandItemsLoaded({required this.items});

  final List<Item> items;

  @override
  List<Object> get props => [items];
}

final class BrandItemsFailedToLoad extends BrandItemsState {}
