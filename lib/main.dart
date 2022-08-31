import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_liff/global/app_toast.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';

import 'global/exceptions/widgets/error_dialog.dart';

Future<void> main() async {
  // final dotEnv = DotEnv();
  // await dotEnv.load(fileName: '.env.development');
  // print(dotEnv.env['LIFF_ID']!);
  await FlutterLineLiff().init(
    config: Config(liffId: '1657380402-e0VdZQ5g'),
    successCallback: () => print(
      'liff init success!!',
    ),
    errorCallback: (error) => print(
      'liff init failed: $error',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter LIFF Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _displayName = '';
  String _userId = '';
  String _imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/2/2f/No-photo-m.png';
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 36,
          horizontal: 36,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(_imageUrl),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 16),
            const Text(
              'My profile is...',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 4),
                Text(
                  'userId:  $_userId',
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'displayName:  $_displayName',
                ),
                const SizedBox(height: 4),
                Text(
                  'status:  $_status',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTap,
        tooltip: 'login',
        child: const Icon(Icons.login),
      ),
    );
  }

  Future<void> _onTap() async {
    try {
      Profile profile = await FlutterLineLiff().profile;
      setState(() {
        _userId = profile.userId;
        _displayName = profile.displayName;
        _imageUrl = profile.pictureUrl!;
        _status = profile.statusMessage ?? 'No Status';
      });
      AppToast.showToast('ユーザー情報を取得しました');
      // FlutterLineLiff().login();
    } catch (e) {
      ErrorDialog.show(context, e);
    }
  }
}
