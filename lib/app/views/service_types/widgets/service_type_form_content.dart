import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/utils/number_format_helper.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:kazi/app/shared/widgets/fields/fields.dart';

import '../service_types.dart';

class ServiceTypeFormContent extends StatefulWidget {
  const ServiceTypeFormContent({
    super.key,
    required this.onConfirm,
  });
  final void Function() onConfirm;

  @override
  State<ServiceTypeFormContent> createState() => _ServiceTypeFormContentState();
}

class _ServiceTypeFormContentState extends State<ServiceTypeFormContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _serviceValueKey = GlobalKey<FormFieldState>();
  final _discountKey = GlobalKey<FormFieldState>();
  late final MoneyMaskedTextController _serviceValueController;
  late final MoneyMaskedTextController _discountController;

  @override
  void initState() {
    final cubit = context.read<ServiceTypesCubit>();
    _serviceValueController = MoneyMaskedTextController(
      initialValue: cubit.state.serviceType.defaultValue ?? 0,
      leftSymbol: NumberFormatHelper.getCurrencySymbol(),
      decimalSeparator: NumberFormatHelper.getDecimalSeparator(),
      thousandSeparator: NumberFormatHelper.getThousandSeparator(),
    );
    _discountController = MoneyMaskedTextController(
      initialValue: cubit.state.serviceType.discountPercent ?? 0,
      decimalSeparator: NumberFormatHelper.getDecimalSeparator(),
      thousandSeparator: NumberFormatHelper.getThousandSeparator(),
      rightSymbol: '%',
      precision: 1,
    );
    super.initState();
  }

  void onConfirm() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypesCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            key: AppOnboarding.stepSeven,
            children: [
              CustomTextFormField(
                textFormKey: _nameKey,
                labelText: AppLocalizations.current.name,
                initialValue: cubit.state.serviceType.name,
                onChanged: (value) => cubit.changeServiceTypeName(value),
                validator: (value) => cubit.validateTextField(
                  value,
                  AppLocalizations.current.name,
                ),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomTextFormField(
                textFormKey: _serviceValueKey,
                labelText: AppLocalizations.current.serviceValue,
                controller: _serviceValueController,
                keyboardType: TextInputType.number,
                onChanged: (value) => cubit.changeServiceTypeDefaultValue(
                    _serviceValueController.numberValue,),
                validator: (value) => cubit.validateNumberField(
                  _serviceValueController.numberValue.toString(),
                  AppLocalizations.current.serviceValue,
                ),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomTextFormField(
                textFormKey: _discountKey,
                controller: _discountController,
                labelText: AppLocalizations.current.discountPercentage,
                keyboardType: TextInputType.number,
                onChanged: (value) => cubit.changeServiceTypeDiscountPercent(
                    _discountController.numberValue,),
                validator: (value) => cubit.validateNumberField(
                  _discountController.numberValue.toString(),
                  AppLocalizations.current.discountPercentage,
                ),
              ),
            ],
          ),
          AppSizeConstants.bigVerticalSpacer,
          PillButton(
            onTap: onConfirm,
            child: Text(AppLocalizations.current.saveType),
          ),
        ],
      ),
    );
  }
}
