import 'package:flutter/services.dart';

class DpiHelper {
  static const MethodChannel _channel = MethodChannel("dpi_channel");

  /// Native taraftan cihazın xdpi / ydpi değerlerini alır
  static Future<Map<String, double>> getDpi() async {
    final result = await _channel.invokeMethod<Map>("getDpi");
    return {
      // FIX: "as double?" yerine "as num?" kullan.
      // Android Float ve iOS Double her ikisini de yakalar; crash olmaz.
      "xdpi": (result?["xdpi"] as num?)?.toDouble() ?? 0.0,
      "ydpi": (result?["ydpi"] as num?)?.toDouble() ?? 0.0,
    };
  }

  /// 1 mm'nin kaç fiziksel px olduğunu hesaplar
  /// ⚠️ DOKUNMA: Fiziksel boyut matematiğinin temeli
  static double pixelsPerMm(double dpi) {
    return dpi / 25.4; // 1 inch = 25.4 mm
  }

  /// mm → fiziksel px dönüşümü
  /// ⚠️ DOKUNMA: Fiziksel boyut matematiğinin temeli
  static double mmToPx(double mm, double dpi) {
    return mm * pixelsPerMm(dpi);
  }

  /// 🔸 mm → dp (Flutter'ın çizim birimi, logical pixel)
  /// Burada devicePixelRatio ile fiziksel px → dp dönüşümü yapıyoruz
  /// ⚠️ DOKUNMA: Halka boyutunu ekranda doğru göstermek için kritik formül
  static double mmToDp({
    required double mm,
    required double dpi,
    required double dpr,
  }) {
    final physicalPx = mm * (dpi / 25.4);
    return physicalPx / dpr;
  }
}