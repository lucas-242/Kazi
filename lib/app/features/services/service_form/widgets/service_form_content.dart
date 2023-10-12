import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/utils/number_format_utils.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/dropdown_item.dart';

class ServiceFormContent extends StatefulWidget {
  const ServiceFormContent({
    Key? key,
    required this.onConfirm,
    this.isCreating = true,
    this.showOnboarding = false,
  }) : super(key: key);
  final Function() onConfirm;
  final bool isCreating;
  final bool showOnboarding;

  @override
  State<ServiceFormContent> createState() => _ServiceFormContentState();
}

class _ServiceFormContentState extends State<ServiceFormContent> {
  final _formKey = GlobalKey<FormState>();

  late final MoneyMaskedTextController _valueController;
  late final MoneyMaskedTextController _discountController;
  late final MaskedTextController _dateController;

  @override
  void initState() {
    final cubit = context.read<ServiceFormCubit>();
    _dateController = MaskedTextController(
      text: DateFormat.yMd()
          .format(cubit.state.service.scheduledToStartAt)
          .normalizeDate(),
      mask: '00/00/0000',
    );
    _valueController = MoneyMaskedTextController(
      initialValue: cubit.state.service.value,
      leftSymbol: NumberFormatUtils.getCurrencySymbol(),
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
    );
    _discountController = MoneyMaskedTextController(
      initialValue: cubit.state.service.discountPercent,
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
      rightSymbol: '%',
      precision: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceFormCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSizeConstants.smallSpace),
            child: BackAndPill(
                text: widget.isCreating
                    ? AppLocalizations.current.newService
                    : AppLocalizations.current.editService,
                onTapBack: () => context.navigateToAddServices()),
          ),
          AppSizeConstants.largeVerticalSpacer,
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  key: AppOnboarding.stepTwelve,
                  children: [
                    CustomDropdown(
                      label: AppLocalizations.current.serviceType,
                      hint: AppLocalizations.current.selectServiceType,
                      items: cubit.state.dropdownItems,
                      selectedItem: cubit.state.selectedDropdownItem,
                      onChanged: _onChangedDropdownItem,
                      validator: (value) => FormValidator.validateDropdownField(
                        value,
                        AppLocalizations.current.serviceType,
                      ),
                    ),
                    AppSizeConstants.largeVerticalSpacer,
                    CustomTextFormField(
                      controller: _valueController,
                      labelText: AppLocalizations.current.total,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => cubit
                          .onChangeServiceValue(_valueController.numberValue),
                      validator: (value) => FormValidator.validateNumberField(
                        _valueController.numberValue.toString(),
                        AppLocalizations.current.total,
                      ),
                    ),
                    AppSizeConstants.largeVerticalSpacer,
                    CustomTextFormField(
                      controller: _discountController,
                      labelText: AppLocalizations.current.discountPercentage,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => cubit.onChangeServiceDiscount(
                          _discountController.numberValue),
                      validator: (value) => FormValidator.validateNumberField(
                        _discountController.numberValue.toString(),
                        AppLocalizations.current.discountPercentage,
                      ),
                    ),
                  ],
                ),
                AppSizeConstants.largeVerticalSpacer,
                Column(
                  key: AppOnboarding.stepThirteen,
                  children: [
                    CustomDatePicker(
                      label: AppLocalizations.current.date,
                      controller: _dateController,
                      onChange: _onChangeDate,
                      validator: (value) => FormValidator.validateTextField(
                          value, AppLocalizations.current.date),
                    ),
                    if (widget.isCreating)
                      Column(
                        children: [
                          AppSizeConstants.largeVerticalSpacer,
                          CustomTextFormField(
                            labelText: AppLocalizations.current.quantity,
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                cubit.onChangeServicesQuantity(value),
                            validator: (value) =>
                                FormValidator.validateQuantityField(
                                    value, AppLocalizations.current.quantity),
                          ),
                        ],
                      ),
                    AppSizeConstants.largeVerticalSpacer,
                    CustomTextFormField(
                      labelText: AppLocalizations.current.description,
                      initialValue: cubit.state.service.description,
                      maxLength: 255,
                      onChanged: (value) =>
                          cubit.onChangeServiceDescription(value),
                    ),
                  ],
                ),
                AppSizeConstants.bigVerticalSpacer,
                PillButton(
                  onTap: _onConfirm,
                  child: Text(AppLocalizations.current.saveService),
                ),
                AppSizeConstants.bigVerticalSpacer,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedDropdownItem(DropdownItem? data) {
    final cubit = context.read<ServiceFormCubit>();
    if (data != null) {
      cubit.onChangeServiceType(data);
      _valueController.updateValue(cubit.state.service.value);
      _discountController.updateValue(cubit.state.service.discountPercent);
    }
  }

  void _onChangeDate(DateTime date) {
    final cubit = context.read<ServiceFormCubit>();
    cubit.onChangeServiceDate(date);
    _dateController.text = DateFormat.yMd().format(date).normalizeDate();
  }

  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirm();
    }
  }
}
