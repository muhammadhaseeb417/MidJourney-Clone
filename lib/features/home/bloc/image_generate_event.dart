part of 'image_generate_bloc.dart';

abstract class ImageGenerateEvent {}

class ImageGeneraterIntialEvent extends ImageGenerateEvent {}

class ImageGeneraterButtonClickEvent extends ImageGenerateEvent {
  final String prompt;

  ImageGeneraterButtonClickEvent({required this.prompt});
}
