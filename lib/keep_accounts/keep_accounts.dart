import 'package:live_life/keep_accounts/control/middle_ware.dart';
import 'package:live_life/keep_accounts/db/db.dart';

import 'control/category_manager.dart';

class KeepAccounts {
  KeepAccounts._();

  factory KeepAccounts() {
    return instance;
  }

  static KeepAccounts instance = KeepAccounts._();

  Future<void> init() async {
    await DB.instance.createDB();
    await CategoryManager.instance.init();
    await MiddleWare.instance.init();
  }

  destroy() {
    DB.instance.closeDb();
  }
}
