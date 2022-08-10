import 'package:flutter/widgets.dart';
import 'package:super_gallery/app/cubit/app_cubit.dart';
import 'package:super_gallery/login/login.dart';
import 'package:super_gallery/upload/upload.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [UploadPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
