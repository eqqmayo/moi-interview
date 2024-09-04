import 'package:flutter/material.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_text_field.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';
import 'package:moi_interview/utils/text_styles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
        title: const Text('설정', style: TextStyles.heading2),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getHeight(40)),
                      const DefaultTextField(title: '이름', placeholder: '칼리아'),
                      SizedBox(height: getHeight(20)),
                      const DefaultTextField(
                          title: '한마디', placeholder: '어쩌구저쩌구'),
                      SizedBox(height: getHeight(20)),
                      const Text('함께할 면접관(선택)', style: TextStyles.caption),
                      SizedBox(height: getHeight(10)),
                      Center(
                        child: Image.asset(
                          'assets/images/interviewer.jpg',
                          width: 400,
                          height: 400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const DefaultButton(title: '저장하기')
          ],
        ),
      ),
    );
  }
}
