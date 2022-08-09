part of 'upload_bloc.dart';

enum UploadStatus { empty, full, notEmpty }

enum UploadStatusBody { initial, loading, saving, success, failure }

class UploadState extends Equatable {
  const UploadState({
    this.status = UploadStatus.empty,
    this.statusBody = UploadStatusBody.initial,
    this.urls = const [],
  });

  final UploadStatus status;
  final UploadStatusBody statusBody;
  final List<String> urls;

  UploadState copyWith({
    UploadStatus? status,
    UploadStatusBody? statusBody,
    List<String>? urls,
  }) {
    return UploadState(
      status: status ?? this.status,
      statusBody: statusBody ?? this.statusBody,
      urls: urls ?? this.urls,
    );
  }

  @override
  List<Object> get props => [status, statusBody, urls];
}
