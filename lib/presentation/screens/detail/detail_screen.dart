import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/model/question.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/question_modal.dart';
import 'package:moi_interview/presentation/screens/detail/detail_view_model.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:moi_interview/ui/styles/text_styles.dart';
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
      viewModel.getQuestions(widget.interview.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    return Scaffold(
      backgroundColor: ColorStyles.white(context),
      appBar: AppBar(
        backgroundColor: ColorStyles.white(context),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorStyles.black(context),
          ),
          iconSize: 22,
          onPressed: () {
            context.pop();
          },
        ),
        title:
            Text(widget.interview.title, style: TextStyles.heading2(context)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showQuestionModal(context, viewModel),
            icon: Icon(Icons.add, color: ColorStyles.black(context)),
            iconSize: 28,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.state.questions.isEmpty
                ? Center(
                    child: Text(
                    '질문을 추가하고 연습을 시작해보세요',
                    style:
                        TextStyles.body2(context).copyWith(color: Colors.grey),
                  ))
                : ListView.builder(
                    itemCount: viewModel.state.questions.length,
                    itemBuilder: (context, index) {
                      final question = viewModel.state.questions[index];

                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.2,
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                viewModel.deleteQuestion(
                                    question.interviewId, question.id);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: '삭제',
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: Checkbox(
                            activeColor: ColorStyles.primary(context),
                            checkColor: Colors.white,
                            value: question.isChecked,
                            onChanged: (bool? value) {
                              viewModel.updateCheckState(question);
                            },
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.question,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${question.answerTime}분',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () {
                            _questionTextController.text = question.question;
                            viewModel.setAnswerTime(question.answerTime);
                            _showQuestionModal(context, viewModel,
                                questionToEdit: question);
                          },
                        ),
                      );
                    },
                  ),
          ),
          DefaultButton(
            title: '시작하기',
            onPressed: viewModel.state.questions
                    .where((e) => e.isChecked == true)
                    .isEmpty
                ? null
                : () {
                    final questions = viewModel.state.questions
                        .where((e) => e.isChecked == true)
                        .toList();
                    context.push('/interview', extra: questions);
                  },
          ),
        ],
      ),
    );
  }

  void _showQuestionModal(BuildContext context, DetailViewModel viewModel,
      {Question? questionToEdit}) {
    int initialAnswerTime = questionToEdit?.answerTime ?? 3;

    viewModel.setAnswerTime(initialAnswerTime);

    if (questionToEdit != null) {
      _questionTextController.text = questionToEdit.question;
    } else {
      _questionTextController.clear();
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: QuestionModal(
              initialAnswerTime: initialAnswerTime,
              onSelectedItemChanged: (index) {
                viewModel.setAnswerTime(index + 1);
              },
              controller: _questionTextController,
              onCancelTapped: () {
                context.pop();
                _questionTextController.clear();
              },
              onConfirmTapped: () {
                if (questionToEdit != null) {
                  viewModel.updateQuestion(
                    questionToEdit.copyWith(
                      question: _questionTextController.text,
                      answerTime: viewModel.currentAnswerTime,
                    ),
                  );
                } else {
                  viewModel.addQuestion(
                    widget.interview.id,
                    _questionTextController.text,
                    viewModel.currentAnswerTime,
                  );
                }
                context.pop();
                _questionTextController.clear();
              },
            ),
          ),
        );
      },
    );
  }
}
