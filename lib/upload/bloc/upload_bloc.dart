import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'upload_event.dart';
part 'upload_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(const UploadState()) {
    on<UploadSaveImage>(
      _onUploadSaveImage,
      transformer: debounce(_duration),
    );
  }

  Future<void> _onUploadSaveImage(
    UploadSaveImage event,
    Emitter<UploadState> emit,
  ) async {
    emit(state.copyWith(status: UploadStatus.loading));

    await Future<dynamic>.delayed(const Duration(milliseconds: 500));

    emit(
      state.copyWith(
        image: event.image,
        status: UploadStatus.success,
        urls: state.urls..add(event.image),
      ),
    );

    if (state.urls.length == 5) {
      emit(state.copyWith(status: UploadStatus.full));
    }
  }
}
