import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/presentation/screens/interview/interview_view_model.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:provider/provider.dart';

class InterviewScreen extends StatefulWidget {
  final List<Question> questions;

  const InterviewScreen({
    super.key,
    required this.questions,
  });

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<InterviewViewModel>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ColorStyles.white(context),
          image: DecorationImage(
            image: viewModel.state.user?.interviewerImgPath == null
                ? const AssetImage('assets/images/interviewer.jpg')
                : FileImage(File(viewModel.state.user!.interviewerImgPath!))
                    as ImageProvider,
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
              backgroundColor: ColorStyles.primary(context),
              foregroundColor: Colors.white,
              onPressed: viewModel.goToPreviousQuestion,
              heroTag: 'previous',
              child: const Icon(Icons.skip_previous),
            ),
            FloatingActionButton(
              backgroundColor: ColorStyles.primary(context),
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: 'stop',
              child: const Icon(Icons.stop),
            ),
            FloatingActionButton(
              backgroundColor: ColorStyles.primary(context),
              foregroundColor: Colors.white,
              onPressed: viewModel.goToNextQuestion,
              heroTag: 'next',
              child: const Icon(Icons.skip_next),
            ),
          ],
        ),
      ),
    );
  }
}
