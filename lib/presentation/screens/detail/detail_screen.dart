import 'package:flutter/material.dart';
import 'package:moi_interview/presentation/components/question_modal.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyles.white,
        appBar: AppBar(
          backgroundColor: ColorStyles.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 22,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Google 면접', style: TextStyles.heading2),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return QuestionModal();
                    });
              },
              icon: const Icon(Icons.add, color: ColorStyles.black),
              iconSize: 28,
            )
          ],
        ),
        body: ListView());
  }
}
