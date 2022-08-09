import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(const UploadState()) {
    on<UploadEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
