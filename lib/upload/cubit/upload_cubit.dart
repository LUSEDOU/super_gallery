import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());
}
