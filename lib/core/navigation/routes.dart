import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sigev/core/constant/screen_paths.dart';
import 'package:sigev/presentation/pages/client/menu/screens/menu_page.dart';
import 'package:sigev/presentation/pages/client/tramites/screens/documentos_page.dart';
import 'package:sigev/presentation/pages/login/screens/seguimiento_tramite_page.dart';
import 'package:sigev/presentation/pages/partner/menu/screens/menu_page.dart'
    as partner_menu_page;
import 'package:sigev/presentation/pages/login/screens/login_page.dart';
import 'package:sigev/presentation/splash_page.dart';
import 'package:sigev/presentation/test_page.dart';
//git add .

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routerNeglect: true,
  initialLocation: ScreenPaths.splashRoute,
  routes: [
    GoRoute(
      path: ScreenPaths.splashRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: ScreenPaths.testRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: TestPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: ScreenPaths.loginRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: ScreenPaths.menuClientRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: MenuPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: ScreenPaths.menuPartnerRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: partner_menu_page.MenuPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: ScreenPaths.documentosClienteRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: DocumentosPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: ScreenPaths.loginSeguimientoTramite,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SeguimientoTramitePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
  ],
);
