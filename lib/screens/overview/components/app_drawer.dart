import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/strings.dart' as Strings;

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  final List<Widget> aboutBoxChildren = <Widget>[
    const SizedBox(height: 24),
    RichText(
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(
              style: TextStyle(color: AppColors.darkBackground),
              text:
                  "Empower your workouts with this intuitive timer app, "
                      "designed to keep you on track and motivated. "
                      "Whether you're aiming for HIIT intervals or structured rest periods, this app is your best companion."),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.lightBackgroundColor,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Options',
              style: TextStyle(color: AppColors.textColor, fontSize: 20.0),
            ),
          ),
          AboutListTile(
            icon: const Icon(
              Icons.info_outline,
              color: AppColors.textColor,
            ),
            applicationVersion: _packageInfo.version,
            applicationName: Strings.appName,
            applicationLegalese: '\u{a9} 2024 Gera Blinkin',
            aboutBoxChildren: aboutBoxChildren,
            child: const Text(
              "About",
              style: TextStyle(color: AppColors.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
