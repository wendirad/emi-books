import 'package:equatable/equatable.dart';

class AppRoute {
  static final AppRouteNode root = AppRouteNode('/');
  static final AppRouteNode app = AppRouteNode('/app');
  static final AppRouteNode splash = AppRouteNode('/splash');
  static final AppRouteNode notFound = AppRouteNode('/not-found');

  static final AppRouteNode auth = app.child('/auth');
  static final AppRouteNode signUp = auth.child('/sign-up');
  static final AppRouteNode signIn = auth.child('/sign-in');
  static final AppRouteNode resetPassword = auth.child('/reset-password');
  static final AppRouteNode confirmPasswordReset = auth.child(
    '/confirm-reset-password',
  );

  static final AppRouteNode appShell = app.child('/shell');
  static final AppRouteNode appShellInitial = appShell.child('/initial');

  static final AppRouteNode home = appShell.child('/home');

  static final AppRouteNode settings = appShell.child('/settings');
  static final AppRouteNode about = settings.child('/about');

  static final AppRouteNode profile = appShell.child('/profile');
  static final AppRouteNode updateProfile = profile.child('/edit');

  static AppRouteNode fromPath(String currentPath) {
    String normalize(String s) {
      final cleaned = s.split('?').first.split('#').first;
      return cleaned.length > 1
          ? cleaned.replaceAll(RegExp(r'/$'), '')
          : cleaned;
    }

    final String target = normalize(currentPath);

    AppRouteNode? search(AppRouteNode r) {
      if (normalize(r.str) == target) return r;
      for (final c in r.children) {
        final found = search(c);
        if (found != null) return found;
      }
      return null;
    }

    // start from top-level roots
    final roots = [root, app, splash, notFound];
    for (final r in roots) {
      final match = search(r);
      if (match != null) return match;
    }

    return AppRouteNode(target);
  }
}

class AppRouteNode extends Equatable {
  final String _path;
  final String _parent;

  final List<AppRouteNode> _children = [];

  AppRouteNode(String path, {String parent = ''})
    : _parent = parent,
      _path = path;

  AppRouteNode child(String path) {
    _children.add(AppRouteNode(path, parent: str));
    return _children.last;
  }

  bool isOrIsChildOf(AppRouteNode route) {
    if (route == this) return true;
    return isChildOf(route);
  }

  bool isChildOf(AppRouteNode route) {
    if (route.children.any((r) => r == this)) return true;
    for (final child in route.children) {
      if (isChildOf(child)) return true;
    }
    return false;
  }

  String get base => _path;
  String get str => _parent + _path;
  List<AppRouteNode> get children => _children;

  @override
  String toString() =>
      'AppRouteNode<base: $_path, str: $str, children: ${_children.length}>';

  @override
  List<Object?> get props => [str.replaceAll(RegExp(r'/$'), '')];
}
