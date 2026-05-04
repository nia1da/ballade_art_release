import 'package:flutter/material.dart';
import 'responsive_helper.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late bool isTurkish;

  // ✅ Story data structure with placeholders
  late final List<Map<String, dynamic>> storyData;

  static const String appFontFamily = 'Cinzel';

  @override
  void initState() {
    super.initState();

    // ✅ Automatic language detection
    final langCode = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    isTurkish = langCode == 'tr';

    // ✅ 4 sections with image paths
    // ÖNEMLİ: Buradaki metinleri kendi dosyandaki gibi BİREBİR bırak.
    // Ben burada sadece font değişikliği odaklı fix yapıyorum.
    storyData = [
      {
        "images": [
          "assets/images/studio1.jpg",
          "assets/images/studio2.jpg",
          "assets/images/studio3.jpg",
        ],
        "tr": {
          "title": "USTANIN ELİ",
          "text": "Ben Alper Karabak. Lisede ve üniversitede Kuyumculuk ve Takı Tasarımı okudum. Yirmi yedi yıldır hiç durmadan, mesleğimi ilk günkü heyecanımla öğrenmeye ve icra etmeye devam ediyorum."
        },
        "en": {
          "title": "THE MASTER'S HAND",
          "text": "I am Alper Karabak. I studied Jewelry Design in high school and university. For twenty-seven years, I have been practicing my profession with the same excitement as the first day."
        }
      },
      {
        "images": [
          "assets/images/ring1.jpg",
          "assets/images/ring2.jpg",
          "assets/images/ring3.jpg",
        ],
        "tr": {
          "title": "BİRLİKTE YARATIM",
          "text": "BalladeArt'ta insanların hikâyelerini semboller ve görsel vurgularla takılabilir hâle getirmek gibi bir derdimiz var."
        },
        "en": {
          "title": "CO-CREATION",
          "text": "At BalladeArt, our mission is to turn people's stories into wearable art using symbols."
        }
      },
      {
        "images": [
          "assets/images/skull1.jpg",
          "assets/images/skull2.jpg",
          "assets/images/skull3.jpg",
        ],
        "tr": {
          "title": "SAF ZANAAT",
          "text": "Yüzükler, kolyeler, taçlar, kemer tokaları ve minimal heykeller çalışıyoruz."
        },
        "en": {
          "title": "PURE CRAFT",
          "text": "We work on rings, necklaces, crowns, belt buckles, and minimal sculptures."
        }
      },
      {
        "images": [
          "assets/images/ouroboros1.jpg",
          "assets/images/ouroboros2.jpg",
          "assets/images/ouroboros3.jpg",
        ],
        "tr": {
          "title": "BALLADE'IN RUHU",
          "text": "Seri üretim ürünleri çalışmayı tarzımıza ve etiğimize uygun bulmuyoruz."
        },
        "en": {
          "title": "BALLADE'S SOUL",
          "text": "We do not find mass production suitable for our style or ethics."
        }
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    const Color bg = Color(0xFF222831);
    const Color ink = Color(0xFFDFD0B8);

    // Responsive text styles for Android
    final headerStyle = TextStyle(
      fontFamily: appFontFamily,
      color: ink,
      fontSize: ResponsiveHelper.fontSize(context, 22, maxSize: 26),
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    );

    final bodyStyle = TextStyle(
      fontFamily: appFontFamily,
      color: ink.withOpacity(0.9),
      fontSize: ResponsiveHelper.fontSize(context, 15, maxSize: 17),
      height: 1.6,
    );

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: ink),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isTurkish ? "HİKAYEMİZ" : "OUR STORY",
          style: headerStyle.copyWith(
            fontSize: ResponsiveHelper.fontSize(context, 18, maxSize: 20),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: ResponsiveHelper.spacing(context, 20),
        ),
        physics: const ClampingScrollPhysics(), // Better Android scrolling
        itemCount: storyData.length + 1, // +1 for footer
        itemBuilder: (context, index) {
          if (index == storyData.length) {
            // Footer section
            return Column(
              children: [
                SizedBox(height: ResponsiveHelper.spacing(context, 40)),
                Center(
                  child: Text(
                    isTurkish
                        ? "Hikayenizi metale dökmek için..."
                        : "To cast your story in metal...",
                    style: bodyStyle.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: ResponsiveHelper.fontSize(context, 12, maxSize: 14),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveHelper.spacing(context, 20)),
              ],
            );
          }

          final section = storyData[index];
          final content = section[isTurkish ? "tr" : "en"];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Title
              Text(content["title"], style: headerStyle),
              SizedBox(height: ResponsiveHelper.spacing(context, 10)),

              // ✅ Text
              Text(content["text"], style: bodyStyle),
              SizedBox(height: ResponsiveHelper.spacing(context, 15)),

              // ✅ Interactive Image (Android-optimized)
              InteractiveStoryCard(
                images: List<String>.from(section["images"]),
              ),

              // Divider between sections (except after last section)
              if (index < storyData.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveHelper.spacing(context, 30),
                  ),
                  child: Divider(
                    color: ink.withOpacity(0.3),
                    thickness: 0.5,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ✅ Interactive Image Widget with Android-Optimized Touch Handling
class InteractiveStoryCard extends StatefulWidget {
  final List<String> images;

  const InteractiveStoryCard({
    super.key,
    required this.images,
  });

  @override
  State<InteractiveStoryCard> createState() => _InteractiveStoryCardState();
}

class _InteractiveStoryCardState extends State<InteractiveStoryCard> {
  double _dragProgress = 0.0; // 0.0 to 1.0
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    // Calculate which images to show based on drag progress
    int currentIndex = (_dragProgress * (widget.images.length - 1)).floor();
    int nextIndex = (currentIndex + 1).clamp(0, widget.images.length - 1);

    // Calculate opacity for cross-fade
    double segmentProgress =
        (_dragProgress * (widget.images.length - 1)) - currentIndex;

    final isCompact = ResponsiveHelper.isCompactScreen(context);

    return GestureDetector(
      // ✅ Android-specific: Only handle horizontal drag
      onHorizontalDragStart: (_) {
        setState(() {
          _isDragging = true;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Calculate drag progress (0.0 to 1.0)
          final RenderBox box = context.findRenderObject() as RenderBox;
          final localPosition = details.localPosition.dx;
          // Clamp to ensure it stays within bounds
          _dragProgress = (localPosition / box.size.width).clamp(0.0, 1.0);
        });
      },
      onHorizontalDragEnd: (details) {
        // ✅ Snap back to first image with animation
        setState(() {
          _isDragging = false;
          _dragProgress = 0.0;
        });
      },
      onHorizontalDragCancel: () {
        setState(() {
          _isDragging = false;
          _dragProgress = 0.0;
        });
      },
      child: Container(
        height: isCompact ? 200 : 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF222831).withOpacity(0.5),
          border: Border.all(
            color: const Color(0xFFDFD0B8).withOpacity(0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Current image
              Image.asset(
                widget.images[currentIndex],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder(widget.images[currentIndex]);
                },
              ),
              // Next image (cross-fade)
              if (currentIndex != nextIndex && _isDragging)
                Opacity(
                  opacity: segmentProgress,
                  child: Image.asset(
                    widget.images[nextIndex],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholder(widget.images[nextIndex]);
                    },
                  ),
                ),
              // Drag indicator overlay
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.swipe_right,
                          color: Color(0xFFDFD0B8),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${currentIndex + 1}/${widget.images.length}",
                          style: const TextStyle(
                            color: Color(0xFFDFD0B8),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String imagePath) {
    return Container(
      color: const Color(0xFF222831).withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image,
              color: Color(0xFFDFD0B8),
              size: 40,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                imagePath.split('/').last,
                style: const TextStyle(
                  color: Color(0xFFDFD0B8),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}