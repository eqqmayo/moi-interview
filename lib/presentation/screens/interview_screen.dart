import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:moi_interview/model/question.dart';
import 'package:moi_interview/utils/color_styles.dart';

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
  late FlutterTts _flutterTts;
  int _currentQuestionIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _startInterview();
  }

  Future<void> _startInterview() async {
    while (_currentQuestionIndex < widget.questions.length) {
      await _speakQuestion(widget.questions[_currentQuestionIndex].question);
      await Future.delayed(Duration(
          minutes: widget.questions[_currentQuestionIndex].answerTime));
      await Future.delayed(const Duration(seconds: 3));
      _currentQuestionIndex++;
    }

    if (_currentQuestionIndex >= widget.questions.length) {
      context.pop();
    }
  }

  Future<void> _speakQuestion(String question) async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(question);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: Hive.box('user').get('imagePath') == null
                ? const AssetImage('assets/images/interviewer.jpg')
                : FileImage(File(Hive.box('user').get('imagePath'))),
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
            // FloatingActionButton(
            //   backgroundColor: ColorStyles.primary,
            //   foregroundColor: ColorStyles.white,
            //   onPressed: () {},
            //   heroTag: 'previous',
            //   child: const Icon(Icons.skip_previous),
            // ),
            FloatingActionButton(
              backgroundColor: ColorStyles.primary,
              foregroundColor: ColorStyles.white,
              onPressed: () {
                context.pop();
              },
              heroTag: 'stop',
              child: const Icon(Icons.stop),
            ),
            // FloatingActionButton(
            //   backgroundColor: ColorStyles.primary,
            //   foregroundColor: ColorStyles.white,
            //   onPressed: () {},
            //   heroTag: 'next',
            //   child: const Icon(Icons.skip_next),
            // ),
          ],
        ),
      ),
    );
  }
}
