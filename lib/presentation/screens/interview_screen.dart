import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_interview/model/question.dart';
import 'package:moi_interview/utils/color_styles.dart';

class InterviewScreen extends StatelessWidget {
  final List<Question> questions;

  const InterviewScreen({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/interviewer.jpg'),
            fit: BoxFit.contain,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              backgroundColor: ColorStyles.primary,
              foregroundColor: ColorStyles.white,
              onPressed: () {},
              heroTag: 'previous',
              child: const Icon(Icons.skip_previous),
            ),
            FloatingActionButton(
              backgroundColor: ColorStyles.primary,
              foregroundColor: ColorStyles.white,
              onPressed: () {
                context.pop();
              },
              heroTag: 'stop',
              child: const Icon(Icons.stop),
            ),
            FloatingActionButton(
              backgroundColor: ColorStyles.primary,
              foregroundColor: ColorStyles.white,
              onPressed: () {},
              heroTag: 'next',
              child: const Icon(Icons.skip_next),
            ),
          ],
        ),
      ),
    );
  }
}
