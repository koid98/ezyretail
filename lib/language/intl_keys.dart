import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'intl/en_US.dart';
import 'intl/ms_MY.dart';
import 'intl/zh_CN.dart';

class IntlKeys extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": EnUs.keys,
        "zh_CN": ZhCn.keys,
        "ms_MY": MsMy.keys,
      };
}
