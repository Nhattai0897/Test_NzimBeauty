import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:nzim_beauty/resource/core/colors.dart';
import 'package:nzim_beauty/resource/core/text_styles.dart';
import 'package:nzim_beauty/resource/core/urls.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../resource/core/images.dart';
import '../../resource/utils/bloc_builder_status.dart';
import 'home_bloc.dart';
import 'home_state.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeBloc bloc;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.initContext(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreColors.subTitleColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 14.0, right: 14.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppbar(),
              buildBanner(),
              buildBody(),
              buildButtonFrame(
                  title: 'Xem tất cả các dịch vụ',
                  paddingTop: 10,
                  paddingBottom: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderTitle(title: 'Lịch hẹn'),
          buildTitleBooking(paddingTop: 12.0, paddingBottom: 17.0),
          buildscheduleButton(),
          buildButtonFrame(
              title: 'Lịch bạn đã đặt', paddingBottom: 22, paddingTop: 12),
          buildServiceListview(),
          buildHeaderTitle(
              title: 'Kỹ thuật viên và cơ sở', isUseIcon: true, paddingTop: 20),
          buildTechniciansList(),
          buildButtonFrame(title: 'Xem tất cả KTV và cơ sở'),
          buildHeaderTitle(
              title: 'Dịch vụ', paddingTop: 33.0, paddingBottom: 12.0),
          buildTitleBooking(paddingBottom: 8.0),
          buildServiceTabbar()
        ],
      ),
    );
  }

  Widget buildHeaderTitle(
      {required String title,
      bool? isUseIcon,
      double? paddingTop,
      double? paddingBottom}) {
    return Padding(
      padding:
          EdgeInsets.only(top: paddingTop ?? 0, bottom: paddingBottom ?? 0.0),
      child: Row(
        children: [
          Text(title,
              style: CoreTextStyle.boldTextFont(
                  fontSize: 20, color: CoreColors.mainColor)),
          const Spacer(),
          isUseIcon != null && isUseIcon == true
              ? Image.asset(CoreImages.nextIcon, scale: 4, fit: BoxFit.cover)
              : const SizedBox()
        ],
      ),
    );
  }

  Widget buildscheduleButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: CoreColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: CoreTextStyle.boldTextFont(fontSize: 16)),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text('Tạo lịch hẹn mới',
              style: CoreTextStyle.boldTextFont(
                  fontSize: 16, color: CoreColors.subTitleColor)),
        ),
      ),
    );
  }

  Widget buildTitleBooking({double? paddingTop, double? paddingBottom}) {
    return Padding(
      padding:
          EdgeInsets.only(top: paddingTop ?? 0, bottom: paddingBottom ?? 0),
      child: Text('Đặt và huỷ lịch miễn phí bạn nhé',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CoreColors.colorText2)),
    );
  }

  Padding buildButtonFrame(
      {required String title, double? paddingTop, double? paddingBottom}) {
    return Padding(
      padding:
          EdgeInsets.only(top: paddingTop ?? 0, bottom: paddingBottom ?? 22.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: CoreColors.subTitleColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: CoreColors.buttonColor, width: 1.0)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: CoreTextStyle.boldTextFont(fontSize: 16)),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(title,
                style: CoreTextStyle.boldTextFont(
                    fontSize: 16, color: CoreColors.buttonColor)),
          ),
        ),
      ),
    );
  }

  Widget buildServiceTabbar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 54),
          child: DefaultTabController(
              length: 2,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                          decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                        width: 0.5,
                      ),
                    ),
                  ))),
                  TabBar(
                    controller: _tabController,
                    labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CoreColors.selectColor),
                    unselectedLabelColor: CoreColors.unselectColor,
                    unselectedLabelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CoreColors.unselectColor),
                    indicatorWeight: 1.5,
                    indicatorColor: CoreColors.selectColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: bloc.tabs,
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 17.0),
          child: SizedBox(
              child: AutoScaleTabBarView(controller: _tabController, children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bloc.coursesLst.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 5.h,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: CoreColors.titleColor),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: CachedNetworkImage(
                                        color: const Color.fromRGBO(
                                            252, 189, 192, 1),
                                        imageUrl: bloc.coursesLst[index].url!,
                                        placeholder: (context, url) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        CoreImages.loading),
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            CoreColors
                                                                .backgroundColor,
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                        imageBuilder: (context, image) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: image,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            Color.fromRGBO(252,
                                                                189, 192, 1),
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      252, 189, 192, 1)),
                                            )))),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 5.0),
                                child: Text(bloc.coursesLst[index].title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromRGBO(115, 166, 165, 1))),
                              ),
                            ),
                            Image.asset(
                              CoreImages.nextIcon,
                              width: 16.0,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.1), height: 1.0),
                        )
                      ],
                    ),
                  );
                }),
            const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Text('Content of Tab Two'),
            )),
          ])),
        ),
      ],
    );
  }

  Widget buildTechniciansList() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < bloc.techniciansLst.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: CoreColors.selectColor, width: 1.0),
                        color: CoreColors.subTitleColor),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: CoreColors.titleColor),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: CachedNetworkImage(
                                    color: CoreColors.titleColor,
                                    imageUrl: bloc.techniciansLst[i].url!,
                                    placeholder: (context, url) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            CoreColors.backgroundColor,
                                        backgroundImage:
                                            AssetImage(CoreImages.loading),
                                        radius: 28,
                                      ),
                                    ),
                                    imageBuilder: (context, image) =>
                                        CircleAvatar(
                                      backgroundColor: const Color.fromRGBO(
                                          252, 189, 192, 1),
                                      backgroundImage: image,
                                      radius: 30,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                                252, 189, 192, 1),
                                            radius: 30),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(bloc.techniciansLst[i].name ?? '',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(210, 129, 108, 1))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget buildServiceListview() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 5.h,
                        height: 5.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CoreColors.titleColor),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                                color: CoreColors.titleColor,
                                imageUrl:
                                    "https://fastly.picsum.photos/id/785/5000/3333.jpg?hmac=3GuDG51IE9rCkkE47hBZtjMD69oZmf15a4aSv1buifY",
                                placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(CoreImages.loading),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                CoreColors.backgroundColor,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                imageBuilder: (context, image) => Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: image,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                CoreColors.backgroundColor,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => Container(
                                      decoration: BoxDecoration(
                                          color: CoreColors.backgroundColor),
                                    )))),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dịch vụ dưỡng',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: CoreColors.colorText1)),
                            const SizedBox(height: 8.0),
                            Text('Ngày 28/11/2020',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: CoreColors.colorText2))
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          CoreImages.nextIcon,
                          width: 16.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 9.0),
                        const Text('Lúc 16:30',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                color: Color.fromRGBO(170, 170, 170, 1)))
                      ],
                    )
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20.0, bottom: index == 1 ? 20 : 0),
                  child: index == 0
                      ? const Divider(
                          color: Color.fromRGBO(0, 0, 0, 0.1), height: 1.0)
                      : const SizedBox(),
                ),
              ],
            ),
          );
        });
  }

  Widget buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 22.0.h,
        width: double.infinity,
        child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => buildBannerCase(state: state)),
      ),
    );
  }

  Widget buildBannerCase({required HomeState state}) {
    late Widget banner;
    switch (state.status) {
      case BlocBuilderStatusCase.initial:
      case BlocBuilderStatusCase.loading:
        banner = buildLoadingBanner();
        break;
      case BlocBuilderStatusCase.success:
        banner = buildCarouselBanner(state);
        break;
      case BlocBuilderStatusCase.failure:
        banner = const SizedBox();
        break;
      default:
        banner = const SizedBox();
        break;
    }
    return banner;
  }

  CarouselSlider buildCarouselBanner(HomeState state) {   
    return CarouselSlider.builder(
        enableAutoSlider: true,
        unlimitedMode: true,
        slideBuilder: (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(state.bannerLst[index].url!),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12),
                  color: CoreColors.titleColor),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16, bottom: 17, right: 109),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: Text(bloc.state.bannerLst[index].title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CoreTextStyle.boldTextFont(
                              fontSize: 20, color: CoreColors.subTitleColor)),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: CoreColors.subTitleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 6),
                          textStyle: CoreTextStyle.boldTextFont(fontSize: 30)),
                      child: Text('Xem dịch vụ',
                          style: CoreTextStyle.boldTextFont(
                              fontSize: 14, color: CoreColors.mainColor)),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        autoSliderDelay: const Duration(seconds: 5),
        slideTransform: const DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          alignment: Alignment.bottomRight,
          indicatorRadius: 3.2,
          indicatorBackgroundColor: CoreColors.subTitleColor.withOpacity(0.5),
          currentIndicatorColor: CoreColors.subTitleColor,
          itemSpacing: 8.5,
          padding: const EdgeInsets.only(bottom: 14, right: 16.0),
        ),
        itemCount: state.bannerLst.length);
  }

  CarouselSlider buildLoadingBanner() {
    return CarouselSlider.builder(
        enableAutoSlider: false,
        unlimitedMode: true,
        slideBuilder: (index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 238, 235, 235),
                    highlightColor: CoreColors.mainColor,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: CoreColors.titleColor),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 17, right: 109),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: CoreColors.subTitleColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 6),
                                  textStyle:
                                      CoreTextStyle.boldTextFont(fontSize: 30)),
                              child: Text('                  ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: CoreColors.mainColor)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 17, right: 109),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 50.w,
                            height: 1.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CoreColors.subTitleColor),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 20.w,
                            height: 1.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CoreColors.subTitleColor),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: CoreColors.subTitleColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 6),
                                textStyle:
                                    CoreTextStyle.boldTextFont(fontSize: 30)),
                            child: Text('                  ',
                                style: CoreTextStyle.boldTextFont(
                                    fontSize: 14, color: CoreColors.mainColor)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        },
        slideTransform: const DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          alignment: Alignment.bottomRight,
          indicatorRadius: 3.2,
          indicatorBackgroundColor: CoreColors.subTitleColor.withOpacity(0.5),
          currentIndicatorColor: CoreColors.subTitleColor,
          itemSpacing: 8.5,
          padding: const EdgeInsets.only(bottom: 14, right: 16.0),
        ),
        itemCount: 2);
  }

  Widget buildAppbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: [
          Container(
              width: 5.h,
              height: 5.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: CoreColors.titleColor),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    color: CoreColors.titleColor,
                    imageUrl: CoreUrls.urlAvatar,
                    placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(CoreImages.loading),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    CoreColors.backgroundColor,
                                    BlendMode.colorBurn)),
                          ),
                        )),
                    imageBuilder: (context, image) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                CoreColors.backgroundColor,
                                BlendMode.colorBurn)),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: CoreColors.titleColor,
                    ),
                  ))),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Chào ',
                  style: CoreTextStyle.boldTextFont(
                      fontSize: 22, color: CoreColors.colorGreyText)),
              TextSpan(
                  text: 'Thúy',
                  style: CoreTextStyle.boldTextFont(
                      fontSize: 22, color: CoreColors.mainColor))
            ])),
          ),
          const Spacer(),
          Image.asset(CoreImages.notificationIcon, fit: BoxFit.cover, scale: 4),
        ],
      ),
    );
  }
}
