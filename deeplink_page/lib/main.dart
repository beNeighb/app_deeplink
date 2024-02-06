import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beneighb',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff023F6C)),
        useMaterial3: true,
      ),
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const _RedirectionPage(),
        );
      },
    );
  }
}

class _RedirectionPage extends StatelessWidget {
  const _RedirectionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Beneighb redirection page ↪️'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _Explanation(),
              SizedBox(
                height: 100,
                width: 300,
                child: Center(
                  child: Divider(),
                ),
              ),
              _Buttons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Explanation extends StatelessWidget {
  const _Explanation();

  @override
  Widget build(BuildContext context) {
    return Text(
      'To be redirected to the correct place in app\n'
      'please open this page on your mobile device.',
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    final text = Text(
      'Still do not have the app? 😱\n' 'Download it NOW!',
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.center,
    );

    final googlePlay = _buildButton(
      assetPath: 'assets/button-google-play.png',
      urlToOpen:
          'https://play.google.com/store/apps/details?id=com.beneighb.beneighb',
    );
    final appStore = _buildButton(
      assetPath: 'assets/button-app-store.png',
      urlToOpen: 'https://apps.apple.com/us/app/beneighb/id6450276125',
    );

    final row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        googlePlay,
        const SizedBox(width: 24),
        appStore,
      ],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        text,
        const SizedBox(height: 24),
        row,
      ],
    );
  }

  Widget _buildButton({
    required String assetPath,
    required String urlToOpen,
  }) {
    const height = 150.0;
    const width = 200.0;
    return InkWell(
      onTap: () {
        launch(url: urlToOpen, isNewTab: true);
      },
      child: Ink.image(
        image: AssetImage(assetPath),
        width: width,
        height: height,
      ),
    );
  }

  Future<void> launch({
    required String url,
    bool isNewTab = true,
  }) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
}
