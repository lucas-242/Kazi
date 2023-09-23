import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/profile/profile.dart';

export 'pages/profile_page.dart';

class ProfileModule extends Module {
  @override
  void routes(r) {
    r.child(AppRouter.initial, child: (_) => const ProfilePage());
  }
}
