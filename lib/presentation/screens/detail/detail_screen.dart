import 'package:flutter/material.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/question_modal.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                    return const QuestionModal();
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: Checkbox(
                    value: true,
                    onChanged: (bool? value) {
                      setState(() {});
                    },
                  ),
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'blah blah',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'blah blah blah',
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
