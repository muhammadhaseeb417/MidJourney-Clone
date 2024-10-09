import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_generator/features/home/repos/image_generate_repo.dart';

part 'image_generate_event.dart';
part 'image_generate_state.dart';

class ImageGenerateBloc extends Bloc<ImageGenerateEvent, ImageGenerateState> {
  ImageGenerateBloc() : super(ImageGenerateInitial()) {
    on<ImageGeneraterIntialEvent>(imageGeneraterIntialEvent);
    on<ImageGeneraterButtonClickEvent>(imageGeneraterButtonClickEvent);
  }

  FutureOr<void> imageGeneraterIntialEvent(
      ImageGeneraterIntialEvent event, Emitter<ImageGenerateState> emit) async {
    try {
      ByteData byteData = await rootBundle.load('assets/file.jpg');
      Uint8List bytes = byteData.buffer.asUint8List();
      emit(ImageGeneraterSuccessState(bytes));
    } catch (e, stackTrace) {
      // Log the error
      print('Error in imageGeneraterIntialEvent: $e');
      print(stackTrace);
      emit(ImageGeneraterErrorState());
    }
  }

  FutureOr<void> imageGeneraterButtonClickEvent(
      ImageGeneraterButtonClickEvent event,
      Emitter<ImageGenerateState> emit) async {
    try {
      emit(ImageGeneraterLoadingState());
      Uint8List? bytes = await ImageGenerateRepo.imageGeneration(event.prompt);
      if (bytes != null) {
        emit(ImageGeneraterSuccessState(bytes));
      } else {
        emit(ImageGeneraterErrorState());
      }
    } catch (e, stackTrace) {
      // Log the error
      print('Error in imageGeneraterButtonClickEvent: $e');
      print(stackTrace);
      emit(ImageGeneraterErrorState());
    }
  }
}
