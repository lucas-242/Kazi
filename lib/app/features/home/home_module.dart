import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/core/routes/app_router.dart';

import 'home_module.dart';

export './cubit/home_cubit.dart';
export './pages/home_page.dart';
export './widgets/home_content.dart';

class HomeModule extends Module {
  @override
  void routes(r) {
    r.child(AppRouter.initial, child: (_) => const HomePage());
  }
}
