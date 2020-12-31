
import 'package:flutter_module/data/info/BannerInfo.dart';
import 'package:flutter_module/data/info/MainItemInfo.dart';
import 'package:flutter_module/data/info/ProjectList.dart';

/// todo
/// 优化
class EntityFactory {
  static T generateOBJ<T>(json) {
    if (json == null) {
      return null;
    }

    if (T.toString() == "BannerInfo") {
      return BannerInfo.fromJson(json) as T;
    } else if (T.toString() == "MainItemInfo") {
      return MainItemInfo.fromJson(json) as T;
    } else if (T.toString() == "ProjectList") {
      return ProjectList.fromJson(json) as T;
    }
    return json as T;
  }
}
