import 'package:kazi_core/kazi_core.dart';

abstract interface class ServicesService {
  DateTime get now;

  List<Service> orderServices(List<Service> services, OrderBy orderBy);

  ///Group [services] by date ordering by date desc.
  ///
  /// Brings isExpanded property as true if it is grouped by today or yesterday
  List<ServicesGroupByDate> groupServicesByDate(
      List<Service> services, OrderBy orderBy);

  (DateTime start, DateTime end) getRangeDateByFastSearch(
      FastSearch fastSearch);
}
