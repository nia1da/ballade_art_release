import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dpi_helper.dart';
import 'package:video_player/video_player.dart';
import 'story_page.dart';
import 'responsive_helper.dart';

// 🔹 Yüzük ölçü tablosu (EU formatında; eski 'us' değerleri aynen 'eu' alanına taşındı)
final List<Map<String, dynamic>> sizeChart = [
  {"eu": 1, "diameter": 13.0, "circumference": 40.84},
  {"eu": 1.5, "diameter": 13.16, "circumference": 41.35},
  {"eu": 2, "diameter": 13.32, "circumference": 41.85},
  {"eu": 2.5, "diameter": 13.48, "circumference": 42.36},
  {"eu": 3, "diameter": 13.65, "circumference": 42.87},
  {"eu": 3.5, "diameter": 13.81, "circumference": 43.38},
  {"eu": 4, "diameter": 13.97, "circumference": 43.88},
  {"eu": 4.5, "diameter": 14.13, "circumference": 44.39},
  {"eu": 5, "diameter": 14.29, "circumference": 44.90},
  {"eu": 5.5, "diameter": 14.45, "circumference": 45.40},
  {"eu": 6, "diameter": 14.61, "circumference": 45.91},
  {"eu": 6.5, "diameter": 14.78, "circumference": 46.42},
  {"eu": 7, "diameter": 14.94, "circumference": 46.93},
  {"eu": 7.5, "diameter": 15.10, "circumference": 47.43},
  {"eu": 8, "diameter": 15.26, "circumference": 47.94},
  {"eu": 8.5, "diameter": 15.42, "circumference": 48.45},
  {"eu": 9, "diameter": 15.58, "circumference": 48.95},
  {"eu": 9.5, "diameter": 15.74, "circumference": 49.46},
  {"eu": 10, "diameter": 15.91, "circumference": 49.97},
  {"eu": 10.5, "diameter": 16.07, "circumference": 50.48},
  {"eu": 11, "diameter": 16.23, "circumference": 50.98},
  {"eu": 11.5, "diameter": 16.39, "circumference": 51.49},
  {"eu": 12, "diameter": 16.55, "circumference": 52.00},
  {"eu": 12.5, "diameter": 16.71, "circumference": 52.50},
  {"eu": 13, "diameter": 16.87, "circumference": 53.01},
  {"eu": 13.5, "diameter": 17.04, "circumference": 53.52},
  {"eu": 14, "diameter": 17.20, "circumference": 54.03},
  {"eu": 14.5, "diameter": 17.36, "circumference": 54.53},
  {"eu": 15, "diameter": 17.52, "circumference": 55.04},
  {"eu": 15.5, "diameter": 17.68, "circumference": 55.55},
  {"eu": 16, "diameter": 17.84, "circumference": 56.05},
  {"eu": 16.5, "diameter": 18.00, "circumference": 56.56},
  {"eu": 17, "diameter": 18.17, "circumference": 57.07},
  {"eu": 17.5, "diameter": 18.33, "circumference": 57.58},
  {"eu": 18, "diameter": 18.49, "circumference": 58.08},
  {"eu": 18.5, "diameter": 18.65, "circumference": 58.59},
  {"eu": 19, "diameter": 18.81, "circumference": 59.10},
  {"eu": 19.5, "diameter": 18.97, "circumference": 59.60},
  {"eu": 20, "diameter": 19.13, "circumference": 60.11},
  {"eu": 20.5, "diameter": 19.30, "circumference": 60.62},
  {"eu": 21, "diameter": 19.46, "circumference": 61.13},
  {"eu": 21.5, "diameter": 19.62, "circumference": 61.63},
  {"eu": 22, "diameter": 19.78, "circumference": 62.14},
  {"eu": 22.5, "diameter": 19.94, "circumference": 62.65},
  {"eu": 23, "diameter": 20.10, "circumference": 63.15},
  {"eu": 23.5, "diameter": 20.26, "circumference": 63.66},
  {"eu": 24, "diameter": 20.43, "circumference": 64.17},
  {"eu": 24.5, "diameter": 20.59, "circumference": 64.68},
  {"eu": 25, "diameter": 20.75, "circumference": 65.18},
  {"eu": 25.5, "diameter": 20.91, "circumference": 65.69},
  {"eu": 26, "diameter": 21.07, "circumference": 66.20},
  {"eu": 26.5, "diameter": 21.23, "circumference": 66.70},
  {"eu": 27, "diameter": 21.39, "circumference": 67.21},
  {"eu": 27.5, "diameter": 21.56, "circumference": 67.72},
  {"eu": 28, "diameter": 21.72, "circumference": 68.23},
  {"eu": 28.5, "diameter": 21.88, "circumference": 68.73},
  {"eu": 29, "diameter": 22.04, "circumference": 69.24},
  {"eu": 29.5, "diameter": 22.20, "circumference": 69.75},
  {"eu": 30, "diameter": 22.36, "circumference": 70.25},
  {"eu": 30.5, "diameter": 22.52, "circumference": 70.76},
  {"eu": 31, "diameter": 22.69, "circumference": 71.27},
  {"eu": 31.5, "diameter": 22.85, "circumference": 71.78},
  {"eu": 32, "diameter": 23.01, "circumference": 72.28},
  {"eu": 32.5, "diameter": 23.17, "circumference": 72.79},
  {"eu": 33, "diameter": 23.33, "circumference": 73.30},
  {"eu": 33.5, "diameter": 23.49, "circumference": 73.80},
  {"eu": 34, "diameter": 23.65, "circumference": 74.31},
  {"eu": 34.5, "diameter": 23.82, "circumference": 74.82},
  {"eu": 35, "diameter": 23.98, "circumference": 75.33},
  {"eu": 35.5, "diameter": 24.14, "circumference": 75.83},
  {"eu": 36, "diameter": 24.30, "circumference": 76.34},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Timer? _scrollDebounce;

  double diameterMm = 13.0;
  final double minDiameter = 13.0;
  final double maxDiameter = 24.3;

  Map<String, double> dpi = {"xdpi": 0.0, "ydpi": 0.0};
  late bool isTurkish;

  // ✅ her zaman bir selected index tut (UI + scroll aynı kaynaktan beslensin)
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final langCode = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    isTurkish = langCode == 'tr';
    _selectedIndex = _closestIndexFor(diameterMm);
    _loadDpi();
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadDpi() async {
    final result = await DpiHelper.getDpi();
    if (!mounted) return;
    setState(() => dpi = result);
  }

  int _closestIndexFor(double mm) {
    return sizeChart.indexed
        .reduce((a, b) =>
    (a.$2['diameter'] - mm).abs() < (b.$2['diameter'] - mm).abs()
        ? a
        : b)
        .$1;
  }

  void _scrollToIndex({
    required int index,
    required double itemExtent,
    bool animated = true,
  }) {
    if (!_scrollController.hasClients) return;

    final target = (index * itemExtent)
        .clamp(0.0, _scrollController.position.maxScrollExtent);

    if (!animated) {
      _scrollController.jumpTo(target);
      return;
    }

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  void _debouncedScrollToSelected({
    required double itemExtent,
    bool animated = true,
  }) {
    _scrollDebounce?.cancel();
    _scrollDebounce = Timer(const Duration(milliseconds: 70), () {
      if (!mounted) return;
      _scrollToIndex(index: _selectedIndex, itemExtent: itemExtent, animated: animated);
    });
  }

  void _stepBackward({required double itemExtent}) {
    setState(() {
      diameterMm = (diameterMm - 0.16).clamp(minDiameter, maxDiameter);
      _selectedIndex = _closestIndexFor(diameterMm);
    });
    _scrollToIndex(index: _selectedIndex, itemExtent: itemExtent, animated: true);
  }

  void _stepForward({required double itemExtent}) {
    setState(() {
      diameterMm = (diameterMm + 0.16).clamp(minDiameter, maxDiameter);
      _selectedIndex = _closestIndexFor(diameterMm);
    });
    _scrollToIndex(index: _selectedIndex, itemExtent: itemExtent, animated: true);
  }

  Future<void> _showHelpVideo() async {
    final controller = VideoPlayerController.asset('assets/videos/help.mp4');

    await controller.initialize();
    if (!mounted) return;

    controller
      ..setLooping(true)
      ..play();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF222831),
        title: Text(
          isTurkish ? "Nasıl Kullanılır" : "How to Use",
          style: const TextStyle(color: Color(0xFFDFD0B8)),
        ),
        content: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isTurkish ? "Kapat" : "Close",
              style: const TextStyle(color: Color(0xFFDFD0B8)),
            ),
          ),
        ],
      ),
    );

    controller.dispose();
  }

  Future<void> _shareOnWhatsApp(String message) async {
    final url = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dpi["xdpi"] == 0.0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isCompact = ResponsiveHelper.isCompactScreen(context);
    final safe = ResponsiveHelper.getSafePadding(context);

    // Küçük ekranda daha sıkı boşluklar (listeye alan açmak için)
    final topGap = isCompact ? 8.0 : 16.0;
    final afterTitleGap = isCompact ? 12.0 : 24.0;
    final afterRingGap = isCompact ? 10.0 : 16.0;
    final afterSliderGap = isCompact ? 6.0 : 8.0;
    final afterSectionTitleGap = isCompact ? 6.0 : 8.0;
    final footerTopGap = isCompact ? 12.0 : 24.0;
    final footerBottomGap = (isCompact ? 10.0 : 16.0) + safe.bottom;

    final titleFontSize = isCompact ? 24.0 : 28.0;
    final sideIconSize = isCompact ? 40.0 : 45.0;

    // ✅ Liste satır yüksekliği: itemExtent veriyoruz -> scroll deterministik
    final itemExtent = isCompact ? 56.0 : 68.0;

    final xdpi = dpi["xdpi"]!;
    final dpr = MediaQuery.of(context).devicePixelRatio;

    // halka ölçüleri (dp) - DOKUNMUYORUZ
    final maxDiameterDp =
        DpiHelper.mmToDp(mm: maxDiameter, dpi: xdpi, dpr: dpr) + 40;
    final currentDiameterDp =
    DpiHelper.mmToDp(mm: diameterMm, dpi: xdpi, dpr: dpr);

    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, topGap, 8, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StoryPage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isCompact ? 4 : 8,
                    horizontal: 8,
                  ),
                  child: Text(
                    "BALLADEART",
                    style: GoogleFonts.cinzel(
                      fontSize: titleFontSize,
                      letterSpacing: 4,
                      color: const Color(0xFFDFD0B8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: afterTitleGap),

              // 🔹 kutu + halka + ikonlar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _showHelpVideo,
                    icon: SvgPicture.asset(
                      "assets/icons/help.svg",
                      width: sideIconSize,
                      height: sideIconSize,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFDFD0B8),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: isCompact ? 8 : 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/grid_box.svg",
                        width: maxDiameterDp,
                        height: maxDiameterDp,
                        fit: BoxFit.contain,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8),
                          BlendMode.srcIn,
                        ),
                      ),
                      Container(
                        width: currentDiameterDp,
                        height: currentDiameterDp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFDFD0B8),
                            width: 1.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: isCompact ? 8 : 12),
                  IconButton(
                    onPressed: () {
                      final item = sizeChart[_selectedIndex];
                      final message = isTurkish
                          ? "Yüzük ölçüm sonucu:\nÖlçü: ${item['eu']}\nÇap: ${item['diameter']} mm\nÇevre: ${item['circumference']} mm"
                          : "Ring size result:\nSize: ${item['eu']}\nDiameter: ${item['diameter']} mm\nCircumference: ${item['circumference']} mm";
                      _shareOnWhatsApp(message);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/forward.svg",
                      width: sideIconSize,
                      height: sideIconSize,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFDFD0B8),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: afterRingGap),

              // 🔹 slider + oklar
              Row(
                children: [
                  IconButton(
                    onPressed: () => _stepBackward(itemExtent: itemExtent),
                    icon: const Icon(Icons.chevron_left,
                        color: Color(0xFFDFD0B8)),
                  ),
                  Expanded(
                    child: Slider(
                      activeColor: const Color(0xFFDFD0B8),
                      inactiveColor:
                      const Color(0xFFDFD0B8).withValues(alpha: 0.6),
                      value: diameterMm,
                      min: minDiameter,
                      max: maxDiameter,
                      onChanged: (value) {
                        setState(() {
                          diameterMm = value;
                          _selectedIndex = _closestIndexFor(diameterMm);
                        });

                        // ✅ hızlı sürükleme + çubuğa uzak tıklama -> stabil scroll
                        _debouncedScrollToSelected(itemExtent: itemExtent);
                      },
                      onChangeEnd: (_) {
                        // ✅ final konumda kesin scroll (debounce beklemeden)
                        _scrollDebounce?.cancel();
                        _scrollToIndex(index: _selectedIndex, itemExtent: itemExtent, animated: true);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => _stepForward(itemExtent: itemExtent),
                    icon: const Icon(Icons.chevron_right,
                        color: Color(0xFFDFD0B8)),
                  ),
                ],
              ),

              SizedBox(height: afterSliderGap),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isTurkish ? "Ölçü Tablosu" : "Size Chart",
                    style: TextStyle(
                      color: const Color(0xFFDFD0B8),
                      fontSize: isCompact ? 16 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: afterSectionTitleGap),

              // --- sütun başlıkları (liste üstü) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: isCompact ? 8 : 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xFFDFD0B8).withValues(alpha: 0.75),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          isTurkish ? "Ölçü" : "Size",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFDFD0B8),
                            fontWeight: FontWeight.w600,
                            fontSize: isCompact ? 9 : 10,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            isTurkish ? "Çap" : "Diameter",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFFDFD0B8),
                              fontWeight: FontWeight.w600,
                              fontSize: isCompact ? 9 : 10,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            isTurkish ? "Çevre" : "Circumference",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFFDFD0B8),
                              fontWeight: FontWeight.w600,
                              fontSize: isCompact ? 9 : 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔹 liste (scrollable kısım burası kalsın)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: sizeChart.length,
                  itemExtent: itemExtent, // ✅ kritik: scroll hesapları kesin
                  itemBuilder: (context, index) {
                    final item = sizeChart[index];
                    final isSelected = index == _selectedIndex;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          diameterMm = item['diameter'];
                          _selectedIndex = index;
                        });
                        _scrollToIndex(index: _selectedIndex, itemExtent: itemExtent, animated: true);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: isCompact ? 4 : 6,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: isCompact ? 10 : 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFDFD0B8)),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? const Color(0xFFDFD0B8).withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${item['eu']}",
                                style: TextStyle(
                                  color: const Color(0xFFDFD0B8),
                                  fontSize: isCompact ? 16 : 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "${item['diameter']}",
                                  style: TextStyle(
                                    color: const Color(0xFFDFD0B8),
                                    fontSize: isCompact ? 16 : 18,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${item['circumference']}",
                                  style: TextStyle(
                                    color: const Color(0xFFDFD0B8),
                                    fontSize: isCompact ? 16 : 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 🔹 alt ikonlar
              Padding(
                padding: EdgeInsets.only(
                  top: footerTopGap,
                  bottom: footerBottomGap,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse(
                            "https://www.instagram.com/balladeart?igsh=Z3B6bHV5OWd4MXFw");
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          debugPrint("❌ Instagram linki açılamadı: $url");
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/insta.svg",
                        width: isCompact ? 28 : 32,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse("https://www.balladeart.com/");
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          debugPrint("❌ Website linki açılamadı: $url");
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/website.svg",
                        width: isCompact ? 28 : 32,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final url =
                        Uri.parse("https://maps.app.goo.gl/3FNax1PRdAbcfiPN7");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/location.svg",
                        width: isCompact ? 26 : 30,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}