import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
                    final String name =
                        box.get('name', defaultValue: '사용자') as String;
                    final String word =
                        box.get('word', defaultValue: '') as String;

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
                        placeholder: ' 제목을 입력하세요',
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
