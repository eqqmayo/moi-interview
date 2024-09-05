import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/model/interview.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_dialog.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _titleTextController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _titleTextController.removeListener(_updateButtonState);
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        toolbarHeight: 40.0,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/setting');
            },
            icon: const Icon(Icons.settings_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
              child: ValueListenableBuilder(
                  valueListenable: Hive.box('user').listenable(),
                  builder: (context, Box box, widget) {
                    final String name = box.get('name');
                    final String word = box.get('word');

                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: name,
                            style: TextStyles.colorHeading,
                          ),
                          const TextSpan(
                            text: '님의 면접\n',
                            style: TextStyles.heading,
                          ),
                          TextSpan(
                            text: word,
                            style: TextStyles.heading,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const Divider(color: ColorStyles.gray5, thickness: 16),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('interviews').listenable(),
                builder: (context, Box box, widget) {
                  final List<String> interviews =
                      box.values.map((e) => e.title as String).toList();

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: interviews.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: ColorStyles.gray5,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          interviews[index],
                          style: TextStyles.body.copyWith(fontSize: 18),
                        ),
                        contentPadding: const EdgeInsets.all(6.0),
                        dense: false,
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: ColorStyles.gray2,
                        ),
                        onTap: () {
                          Interview interview =
                              Hive.box('interviews').getAt(index);
                          context.push('/detail', extra: interview);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            DefaultButton(
              title: '추가하기',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DefaultDialog(
                      title: '제목 입력',
                      placeholder: ' 제목을 입력하세요',
                      controller: _titleTextController,
                      onCancelTapped: () {
                        _titleTextController.clear();
                        context.pop();
                      },
                      onConfirmTapped: _isButtonEnabled
                          ? () {
                              Box box = Hive.box('interviews');
                              int id = box.isEmpty
                                  ? 0
                                  : box.values
                                      .cast<Interview>()
                                      .map((e) => e.id)
                                      .reduce(max);

                              Interview interview = Interview(
                                id: id + 1,
                                title: _titleTextController.text,
                              );

                              Hive.box('interviews').add(interview);

                              _titleTextController.clear();
                              context.pop();
                            }
                          : null,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
