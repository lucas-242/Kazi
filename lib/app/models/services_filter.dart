import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/enums/fast_search.dart';

import 'enums/order_by.dart';

part 'services_filter.g.dart';

@JsonSerializable()
class ServicesFilter extends Equatable {
  const ServicesFilter({
    this.scheduledToStartAt,
    this.scheduledToEndAt,
    this.orderBy = OrderBy.dateDesc,
    this.isActive = true,
    this.pageSize = 10,
    this.pageNumber = 0,
  });

  final DateTime? scheduledToStartAt;
  final DateTime? scheduledToEndAt;
  final OrderBy? orderBy;
  final bool? isActive;
  final int pageSize;
  final int pageNumber;

  @override
  List<Object?> get props => [
        scheduledToStartAt,
        scheduledToEndAt,
        orderBy,
        isActive,
        pageSize,
        pageNumber,
      ];

  Map<String, dynamic> toJson() => _$ServicesFilterToJson(this);
}
