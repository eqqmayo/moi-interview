import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/service/ad/admob_service.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_dialog.dart';
import 'package:moi_interview/presentation/screens/home/home_view_model.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:moi_interview/ui/styles/text_styles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  late final BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = AdmobService.createBannerAd()
      ..load().then((_) {
        setState(() {
          _isAdLoaded = true;
        });
      });
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: ColorStyles.white(context),
      appBar: AppBar(
        backgroundColor: ColorStyles.white(context),
        toolbarHeight: 40.0,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await context.push('/setting');
              if (result == true) {
                viewModel.getUser();
              }
            },
            icon: Icon(
              Icons.settings_sharp,
              color: ColorStyles.black(context),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _isAdLoaded && _bannerAd != null
      //     ? SizedBox(
      //         height: _bannerAd.size.height.toDouble(),
      //         width: _bannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: _bannerAd),
      //       )
      //     : null,
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
                      style: TextStyles.colorHeading(context),
                    ),
                    TextSpan(
                      text: '님의 면접\n',
                      style: TextStyles.heading(context),
                    ),
                    TextSpan(
                      text: viewModel.state.user!.word,
                      style: TextStyles.heading(context),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: ColorStyles.gray5(context), thickness: 16),
            Expanded(
              child: Builder(
                builder: (context) {
                  final List<Interview> interviews = viewModel.state.interviews;
                  final List<String> titles =
                      interviews.map((e) => e.title).toList();

                  return titles.isEmpty
                      ? Center(
                          child: Text(
                          '면접을 추가하고 질문을 등록해보세요',
                          style: TextStyles.body2(context)
                              .copyWith(color: Colors.grey),
                        ))
                      : ListView.separated(
                          itemCount: interviews.length,
                          separatorBuilder: (context, index) => Divider(
                            color: ColorStyles.gray5(context),
                            thickness: 1,
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.2,
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      viewModel.deleteInterview(
                                          interviews[index].id);
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: '삭제',
                                  ),
                                ],
                              ),
                              child: Theme(
                                data: ThemeData(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child: ListTile(
                                  title: Text(
                                    titles[index],
                                    style: TextStyles.body(context)
                                        .copyWith(fontSize: 18),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(25, 15, 25, 15),
                                  dense: false,
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: ColorStyles.gray2,
                                  ),
                                  onTap: () {
                                    final interview =
                                        viewModel.state.interviews[index];
                                    context.push('/detail', extra: interview);
                                  },
                                ),
                              ),
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
                        viewModel.addInterview(_titleTextController.text);
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
