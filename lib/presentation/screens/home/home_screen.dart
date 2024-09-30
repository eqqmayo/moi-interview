import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_dialog.dart';
import 'package:moi_interview/presentation/screens/home/home_view_model.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTextController = TextEditingController();

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: ColorStyles.white,
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        toolbarHeight: 40.0,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await context.push('/setting');
              if (result == true) {
                viewModel.getUser();
              }
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: viewModel.state.user!.name,
                      style: TextStyles.colorHeading,
                    ),
                    const TextSpan(
                      text: '님의 면접\n',
                      style: TextStyles.heading,
                    ),
                    TextSpan(
                      text: viewModel.state.user!.word,
                      style: TextStyles.heading,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: ColorStyles.gray5, thickness: 16),
            const SizedBox(height: 8.0),
            Expanded(
              child: Builder(
                builder: (context) {
                  final List<String> interviews =
                      viewModel.state.interviews.map((e) => e.title).toList();

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
                          final interview = viewModel.state.interviews[index];
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
                      title: '면접 등록',
                      placeholder: ' 제목을 입력하세요',
                      controller: _titleTextController,
                      onCancelTapped: () {
                        _titleTextController.clear();
                        context.pop();
                      },
                      onConfirmTapped: () {
                        final interviews = viewModel.state.interviews;
                        int id = interviews.isEmpty
                            ? 0
                            : interviews.map((e) => e.id).reduce(max);

                        Interview interview = Interview(
                          id: id + 1,
                          title: _titleTextController.text,
                        );
                        viewModel.addInterview(interview);

                        _titleTextController.clear();
                        context.pop();
                      },
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
