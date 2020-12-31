// base List 类型
import 'EntityFactory.dart';

// base List 类型
class PagerEntity<T> {
  int errorCode;
  String errorMsg;
  BasePagerEntity<T> data;

  PagerEntity({this.errorCode, this.errorMsg, this.data});

  factory PagerEntity.fromJson(json) {
    BasePagerEntity<T> mData = BasePagerEntity();
    if (json['data'] != null) {
      mData = BasePagerEntity.fromJson(json['data']);
    }

    return PagerEntity(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      data: mData,
    );
  }
}

class BasePagerEntity<T> {
  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  List<T> datas;

  BasePagerEntity(
      {this.curPage,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total,
      this.datas});

  factory BasePagerEntity.fromJson(json) {
    List<T> mData = List();
    if (json['datas'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['datas'] as List).forEach((v) {
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    }

    return BasePagerEntity(
      curPage: json["curPage"],
      offset: json["offset"],
      over: json["over"],
      pageCount: json["pageCount"],
      size: json["size"],
      total: json["total"],
      datas: mData,
    );
  }
}
