import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/question_modal.dart';
import 'package:moi_interview/presentation/screens/detail/detail_view_model.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Interview interview;

  const DetailScreen({
    super.key,
    required this.interview,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _questionTextController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      final viewModel = context.read<DetailViewModel>();
      viewModel.getQuestionsByInterviewId(widget.interview.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    return Scaffold(
      backgroundColor: ColorStyles.white,
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 22,
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(widget.interview.title, style: TextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        child: QuestionModal(
                          onSelectedItemChanged: (index) {
                            viewModel.setAnswerTime(index + 1);
                          },
                          controller: _questionTextController,
                          onCancelTapped: () {
                            viewModel.setAnswerTime(3);
                            _questionTextController.clear();
                            context.pop();
                          },
                          onConfirmTapped: () {
                            final questions = viewModel.getAllQuestions();
                            int id = questions.isEmpty
                                ? 0
                                : questions.map((e) => e.id).reduce(max);

                            Question question = Question(
                              id: id + 1,
                              interviewId: widget.interview.id,
                              question: _questionTextController.text,
                              answerTime: viewModel.state.answerTime,
                            );

                            viewModel.addQuestion(question);
                            viewModel.setAnswerTime(3);
                            _questionTextController.clear();
                            context.pop();
                          },
                        ),
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.add, color: ColorStyles.black),
            iconSize: 28,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.state.questions.length,
              itemBuilder: (context, index) {
                final question = viewModel.state.questions[index];

                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: Checkbox(
                    activeColor: ColorStyles.primary,
                    value: question.isChecked,
                    onChanged: (bool? value) {
                      viewModel.updateCheckState(question);
                    },
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${question.question}${question.id}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${question.answerTime}분',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          DefaultButton(
            title: '시작하기',
            onPressed: () {
              final questions = viewModel.state.questions
                  .where((e) => e.isChecked == true)
                  .toList();

              if (questions.isEmpty) {
                return;
              } else {
                context.push('/interview', extra: questions);
              }
            },
          ),
        ],
      ),
    );
  }
}
