// ignore_for_file: public_member_api_docs

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';

class GenderCubit extends Cubit<Gender?> {
  GenderCubit() : super(null);

  void filterGender(Gender gender) {
    emit(gender);
  }

  void resetFilter() {
    emit(null);
  }
}
