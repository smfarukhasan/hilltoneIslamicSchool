import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import 'bottom_nav_t.dart';

class NoticeT {
  final String? imageUrl;
  final String title;
  final String details;
  final DateTime dateTime;

  NoticeT({
    this.imageUrl,
    required this.title,
    required this.details,
    required this.dateTime,
  });
}

class NoticePageT extends StatefulWidget {
  const NoticePageT({super.key});

  @override
  State<NoticePageT> createState() => _NoticePageTState();
}

class _NoticePageTState extends State<NoticePageT> {
  final List<NoticeT> _notices = [
    NoticeT(
      imageUrl: null,
      title: "গ্রীষ্মকালীন ছুটি ঘোষণা",
      details: "২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে। ২০ মে থেকে ৩০ মে পর্যন্ত গ্রীষ্মকালীন ছুটি ঘোষণা করা হয়েছে। স্কুল বন্ধ থাকবে।",
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NoticeT(
      imageUrl: null,
      title: "ফলাফল প্রকাশ",
      details: "সকল শ্রেণীর বার্ষিক পরীক্ষার ফলাফল প্রকাশিত হয়েছে। শিক্ষার্থীরা অনলাইনে দেখতে পারবে।",
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.notices, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: _notices.map((notice) {
            return GestureDetector(
              onTap: () => _showNoticeDialog(context, notice),
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      _buildNoticeImage(screenW, notice.imageUrl),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notice.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 6),
                            Text(notice.details,
                                maxLines: 2, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 6),
                            Text(
                              "${_formatDate(notice.dateTime)} | ${_formatTime(notice.dateTime)}",
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: const BottomNavT(currentIndex: 1),
    );
  }

  Widget _buildNoticeImage(double width, String? imageUrl) {
    final imgSize = width * 0.25;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl != null
          ? Image.network(
        imageUrl,
        width: imgSize,
        height: imgSize,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/logo.png',
          width: imgSize,
          height: imgSize,
          fit: BoxFit.cover,
        ),
      )
          : Image.asset(
        'assets/logo.png',
        width: imgSize,
        height: imgSize,
        fit: BoxFit.cover,
      ),
    );
  }

  void _showNoticeDialog(BuildContext context, NoticeT notice) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // height wrap
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ইমেজ দেখানো (fallback সহ)
              if (notice.imageUrl != null && notice.imageUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    notice.imageUrl!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logo.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 12),

              // শিরোনাম
              Text(
                notice.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // তারিখ ও সময়
              Text(
                "${_formatDate(notice.dateTime)} | ${_formatTime(notice.dateTime)}",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),

              const Divider(height: 24),

              // বিস্তারিত
              Text(
                notice.details,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 24),

              // বন্ধ করুন বাটন
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    loc.cancel,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  static String _formatDate(DateTime dt) {
    return "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}";
  }

  static String _formatTime(DateTime dt) {
    return DateFormat('h:mm a').format(dt);
  }
}
