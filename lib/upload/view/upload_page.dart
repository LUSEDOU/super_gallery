import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_gallery/upload/upload.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadBloc(),
      child: _UploadView(),
    );
  }
}

class _UploadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: IconButton(
                      onPressed: () => context
                          .read<UploadBloc>()
                          .add(UploadSaveImage(image: _controller.text)),
                      icon: const Icon(Icons.cancel_rounded),
                    ),
                  ),
                ),
                _UploadBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case UploadStatus.initial:
            break;
          case UploadStatus.loading:
            return const CircularProgressIndicator();
          case UploadStatus.success:
            return Image.asset(state.image ?? '');
          case UploadStatus.full:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('5 is the maximum of uploads'),
                ),
              );
            break;
          case UploadStatus.failure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('URL wrong'),
                ),
              );
            break;
        }
        return const SizedBox();
      },
    );
  }
}
