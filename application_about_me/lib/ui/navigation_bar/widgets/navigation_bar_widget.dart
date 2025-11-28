import 'package:flutter/material.dart';
import 'package:application_about_me/ui/home/widgets/home_screen.dart';
import 'package:application_about_me/ui/github_info/widgets/github_info_screen.dart';
import 'package:application_about_me/ui/settings/widgets/settings_screen.dart';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainNavigationWidget extends StatefulWidget {
  const MainNavigationWidget({super.key});

  @override
  State<MainNavigationWidget> createState() => _MainNavigationWidgetState();
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const GitHubScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  final String _bannerAndroidAdUnitId =
      dotenv.env['ANDROID_BANNER_AD_UNIT_ID']!;
  final String _bannerIosAdUnitId = dotenv.env['IOS_BANNER_AD_UNIT_ID']!;

  String get _bannerAdUnitId =>
      Platform.isAndroid ? _bannerAndroidAdUnitId : _bannerIosAdUnitId;

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        _loadBannerAd();
      }
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _screens),
          ),
          if (_isBannerAdLoaded && _bannerAd != null)
            Container(
              color:
                  Theme.of(context).bottomAppBarTheme.color ??
                  Colors.transparent,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Резюме"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "GitHub"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Налаштування",
          ),
        ],
      ),
    );
  }
}
