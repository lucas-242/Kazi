import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/services/service_types/pages/service_type_form_page.dart';
import 'package:kazi/app/features/services/service_types/pages/service_types_page.dart';
import 'package:kazi/app/features/services/services_module.dart';

export 'service_details/service_details.dart';
export 'service_filters/service_filters.dart';
export 'service_form/service_form.dart';
export 'service_landing/service_landing.dart';
export 'widgets/info_card.dart';
export 'widgets/order_by_bottom_sheet.dart';
export 'widgets/service_list.dart';
export 'widgets/service_list_by_date.dart';
export 'widgets/service_list_content.dart';

class ServicesModule extends Module {
  @override
  void routes(r) {
    r.child(
      AppRouter.initial,
      child: (_) => const ServiceLandingPage(),
      children: [
        ChildRoute(
          AppRouter.type,
          child: (_) => const ServiceTypesPage(),
          children: [
            ChildRoute(AppRouter.type,
                child: (_) => const ServiceTypeFormPage())
          ],
        ),
        ChildRoute(':id', child: (_) => const ServiceFormPage()),
      ],
    );
    r.child(AppRouter.addServices, child: (_) => const ServiceFormPage());
  }
}
