import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigev/core/constant/assets_constants.dart';
import 'package:sigev/core/constant/local_storage_keys.dart';
import 'package:sigev/config/globals.dart' as globals;
import 'package:sigev/core/constant/screen_paths.dart';
import 'package:sigev/domain/providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserProvider userProvider = UserProvider();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => asyncInitState());
  }

  void asyncInitState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(milliseconds: 500), () {});
      if (prefs.containsKey(LocalStorageKeys.keyAccesToken)) {
        globals.token = prefs.getString(LocalStorageKeys.keyAccesToken) ?? '';
        await userProvider.getUser();
        await Future.delayed(const Duration(milliseconds: 10));
        if (mounted) {
          context.go(ScreenPaths.menuClientRoute);
        }
      } else {
        if (mounted) {
          context.go(ScreenPaths.loginRoute);
        }
      }
    } catch (mensaje) {
      if (mounted) {
        context.go(ScreenPaths.loginRoute);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(0),
        alignment: Alignment.topCenter,
        child: Center(child: Image.asset(AssetsConstants.sigevLogo)),
      ),
    );
  }
}
