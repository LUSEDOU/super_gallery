part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadUrlChange extends UploadEvent {
  const UploadUrlChange({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}

class UploadSaveImage extends UploadEvent {
  const UploadSaveImage({
    required this.image,
  });

  final String image;

  @override
  List<Object> get props => [image];
}

class UploadImageDelete extends UploadEvent {
  const UploadImageDelete({
    required this.image,
  });

  final String image;

  @override
  List<Object> get props => [image];
}
