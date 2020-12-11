import 'package:bot_toast/bot_toast.dart';

class ToastUtils {
  static void show(String message) {
    BotToast.showText(text: message);
  }
}
