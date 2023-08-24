// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/enums/app_page.dart';
import 'package:kazi/app/models/service.dart';

part 'route_params.g.dart';

@JsonSerializable()
class RouteParams {
  const RouteParams({
    required this.lastPage,
    this.service,
  });

  factory RouteParams.fromJson(Map<String, dynamic> json) =>
      _$RouteParamsFromJson(json);

  final AppPage lastPage;
  final Service? service;

  Map<String, dynamic> toJson() => _$RouteParamsToJson(this);
}
