import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/data/info/BannerInfo.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 轮播图片
class MainBanner extends StatefulWidget {
  final List<BannerInfo> bannerLists ;

  const MainBanner({Key key, this.bannerLists}) : super(key: key);



  @override
  State<StatefulWidget> createState() {
    return MainBannerState(bannerList: bannerLists);
  }
}

/// 控制Banner 状态
class MainBannerState extends State<MainBanner> {
  final List<BannerInfo> bannerList ;

  MainBannerState({this.bannerList});

  @override
  BannerWidget build(BuildContext context) {
    return BannerWidget(bannerList: this.bannerList);
  }


}

class BannerWidget extends StatelessWidget {
  final List<BannerInfo> bannerList;

  const BannerWidget({Key key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 750,
        height: 200,
        child: Swiper(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              bannerList[index].imagePath,
              fit: BoxFit.fill,
            );
          },
          itemCount: bannerList.length,
          autoplay: true,
          loop: false,
        ),
      ),
    );
  }
}
