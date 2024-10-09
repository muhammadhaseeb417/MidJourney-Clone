part of 'image_generate_bloc.dart';

abstract class ImageGenerateState {}

final class ImageGenerateInitial extends ImageGenerateState {}

class ImageGeneraterLoadingState extends ImageGenerateState {}

class ImageGeneraterSuccessState extends ImageGenerateState {
  final Uint8List uint8list;

  ImageGeneraterSuccessState(this.uint8list);
}

class ImageGeneraterErrorState extends ImageGenerateState {}
