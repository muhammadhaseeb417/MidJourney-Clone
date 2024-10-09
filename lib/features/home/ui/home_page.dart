import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator/features/home/bloc/image_generate_bloc.dart';
import 'package:image_generator/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ImageGenerateBloc>().add(ImageGeneraterIntialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Image Generater💥'),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ImageGenerateBloc, ImageGenerateState>(
            builder: (context, state) {
              if (state is ImageGeneraterLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ImageGeneraterSuccessState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(state.uint8list),
                    ),
                  ),
                );
              } else if (state is ImageGeneraterErrorState) {
                return const Center(child: Text('Error'));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        Container(
          // height: MediaQuery.sizeOf(context).height * 0.25,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.03),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Your Prompt',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<ImageGenerateBloc>().add(
                          ImageGeneraterButtonClickEvent(
                              prompt: controller.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.generating_tokens),
                      Text(
                        'Generate',
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
