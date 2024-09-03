import 'package:flutter/material.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_dialog.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        actions: [
          IconButton(
            onPressed: () {},
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
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '칼리아', style: TextStyles.colorHeading),
                    const TextSpan(text: '님의 면접\n', style: TextStyles.heading),
                    const TextSpan(
                        text: '하나만 붙으면 된다..', style: TextStyles.heading),
                  ],
                ),
              ),
            ),
            const Divider(color: ColorStyles.gray5, thickness: 12),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: 10,
                separatorBuilder: (context, index) => const Divider(
                  color: ColorStyles.gray5,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  return const ListTile();
                },
              ),
            ),
            DefaultButton(
              title: '추가하기',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const DefaultDialog(
                        title: '제목 입력',
                        placeHolder: ' 제목을 입력하세요',
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
