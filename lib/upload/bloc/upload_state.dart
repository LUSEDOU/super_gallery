part of 'upload_bloc.dart';

enum UploadStatus { initial, loading, success, failure, full }

class UploadState extends Equatable {
  const UploadState({
    this.status = UploadStatus.initial,
    this.urls = const [],
    this.image,
  });

  final UploadStatus status;
  final List<String> urls;
  final String? image;

  UploadState copyWith({
    UploadStatus? status,
    List<String>? urls,
    String? image,
  }) {
    return UploadState(
      status: status ?? this.status,
      urls: urls ?? this.urls,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [image, status, urls];
}
