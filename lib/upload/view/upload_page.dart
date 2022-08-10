import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_repository/images_repository.dart';
import 'package:super_gallery/upload/upload.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({
    required this.imagesRepository,
    super.key,
  });

  final ImagesRepository imagesRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadBloc(imagesRepository: imagesRepository),
      child: _UploadView(),
    );
  }
}

class _UploadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        if (state.status == UploadStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something wrong happened'),
              ),
            );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _UploadForm(),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  _BigImage(),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  _UploadImages()
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.browse_gallery_rounded),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _BigImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == UploadStatus.initial
            ? Container()
            : Image(
                image: NetworkImage(
                  state.image,
                ),
                errorBuilder: (context, error, stackTrace) {
                  context.read<UploadBloc>().add(
                        UploadFailureLoad(
                          errorMessage: error.toString(),
                        ),
                      );
                  return const SizedBox();
                },
              );
      },
    );
  }
}

@immutable
class _SmallImage extends StatelessWidget {
  const _SmallImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return image.isEmpty
        ? Container(
            color: Colors.red,
            width: 9,
            height: 9,
          )
        : GestureDetector(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(image),
            ),
            onTap: () => context
                .read<UploadBloc>()
                .add(UploadImageChanged(image: image)),
            onLongPress: () =>
                context.read<UploadBloc>().add(UploadImageDelete(image: image)),
          );
  }
}

class _UploadForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return TextField(
      controller: _controller,
      onChanged: (url) =>
          context.read<UploadBloc>().add(UploadUrlChange(url: url)),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () =>
              context.read<UploadBloc>().add(const UploadImageSaveRequest()),
          icon: const Icon(Icons.save_alt_rounded),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _UploadImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) {
        List<Widget> _smallImage(int length) => List.generate(
              length,
              (index) => _SmallImage(
                image: state.urls[index],
              ),
            );

        final urlLength = state.urls.length;

        return state.urls.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _smallImage(
                    urlLength <= 5 ? urlLength : 5,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
