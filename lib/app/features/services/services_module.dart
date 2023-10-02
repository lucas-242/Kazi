import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/services/services_module.dart';
import 'package:kazi/app/models/service.dart';

import 'service_types/pages/service_types_page.dart';

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
    );
    r.child(AppRouter.add, child: (_) => const ServiceFormPage());
    r.child(
      ':id',
      child: (context) => ServiceDetailsPage(
        service: r.routeParams.service ?? Service.toCreate(employeeId: 123),
      ),
    );
    r.child(
      AppRouter.type,
      child: (_) => const ServiceTypesPage(),
      children: [
        ChildRoute(':id', child: (_) => const ServiceFormPage()),
      ],
    );
  }
}
