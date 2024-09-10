import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/model/interview.dart';
import 'package:moi_interview/model/question.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/question_modal.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

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
  int _answerTime = 3;

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
                            setState(() {
                              _answerTime = index + 1;
                            });
                          },
                          controller: _questionTextController,
                          onCancelTapped: () {
                            _questionTextController.clear();
                            _answerTime = 2;
                            context.pop();
                          },
                          onConfirmTapped: () {
                            Question question = Question(
                              interviewId: widget.interview.id,
                              question: _questionTextController.text,
                              answerTime: _answerTime,
                            );

                            Hive.box('questions').add(question);

                            _questionTextController.clear();
                            _answerTime = 2;
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
            child: ValueListenableBuilder(
              valueListenable: Hive.box('questions').listenable(),
              builder: (context, Box box, _) {
                final List<Question> questions = Hive.box('questions')
                    .values
                    .cast<Question>()
                    .where((e) => e.interviewId == widget.interview.id)
                    .toList();

                return ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];

                    return ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: Checkbox(
                        activeColor: ColorStyles.primary,
                        value: question.isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            question.isChecked = !question.isChecked;
                          });
                        },
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question,
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
                );
              },
            ),
          ),
          DefaultButton(
            title: '시작하기',
            onPressed: () {
              final List<Question> questions = Hive.box('questions')
                  .values
                  .cast<Question>()
                  .where((e) =>
                      e.interviewId == widget.interview.id &&
                      e.isChecked == true)
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
