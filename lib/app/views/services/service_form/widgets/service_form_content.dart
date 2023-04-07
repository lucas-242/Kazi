import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/models/dropdown_item.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/fields/fields.dart';
import 'package:my_services/app/views/services/services.dart';

class ServiceFormContent extends StatefulWidget {
  final Function() onConfirm;
  const ServiceFormContent({super.key, required this.onConfirm});

  @override
  State<ServiceFormContent> createState() => _ServiceFormContentState();
}

class _ServiceFormContentState extends State<ServiceFormContent> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey<FormFieldState>();
  final _dateKey = GlobalKey<FormFieldState>();
  final _dropdownKey = GlobalKey<FormFieldState>();
  final _valueKey = GlobalKey<FormFieldState>();
  final _quantityKey = GlobalKey<FormFieldState>();
  final _discountKey = GlobalKey<FormFieldState>();

  late final TextEditingController _quantityController;
  late final MoneyMaskedTextController _valueController;
  late final MoneyMaskedTextController _discountController;
  late final MaskedTextController _dateController;

  @override
  void initState() {
    final cubit = context.read<ServiceFormCubit>();
    _quantityController = TextEditingController(
      text: cubit.state.quantity.toString(),
    );
    _dateController = MaskedTextController(
      text: DateFormat.yMd().format(cubit.state.service.date).normalizeDate(),
      mask: '00/00/0000',
    );
    _valueController = MoneyMaskedTextController(
      initialValue: cubit.state.service.value,
      leftSymbol: NumberFormatHelper.getCurrencySymbol(),
      decimalSeparator: NumberFormatHelper.getDecimalSeparator(),
      thousandSeparator: NumberFormatHelper.getThousandSeparator(),
    );
    _discountController = MoneyMaskedTextController(
      initialValue: cubit.state.service.discountPercent,
      decimalSeparator: NumberFormatHelper.getDecimalSeparator(),
      thousandSeparator: NumberFormatHelper.getThousandSeparator(),
      rightSymbol: '%',
      precision: 1,
    );
    super.initState();
  }

  void onChangedDropdownItem(DropdownItem? data) {
    final cubit = context.read<ServiceFormCubit>();
    if (data != null) {
      cubit.onChangeServiceType(data);
      _valueController.updateValue(cubit.state.service.value);
      _discountController.updateValue(cubit.state.service.discountPercent);
    }
  }

  void onChangeDate(DateTime date) {
    final cubit = context.read<ServiceFormCubit>();
    cubit.onChangeServiceDate(date);
    _dateController.text = DateFormat.yMd().format(date).normalizeDate();
  }

  void onConfirm() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceFormCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSizeConstants.smallSpace),
          child: Text(
            AppLocalizations.current.newService,
            style: context.titleMedium,
          ),
        ),
        AppSizeConstants.largeVerticalSpacer,
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomDropdown(
                key: _dropdownKey,
                label: AppLocalizations.current.serviceType,
                hint: AppLocalizations.current.selectServiceType,
                items: cubit.state.dropdownItems,
                selectedItem: cubit.state.selectedDropdownItem,
                onChanged: onChangedDropdownItem,
                validator: (value) => cubit.validateDropdownField(
                  value,
                  AppLocalizations.current.serviceType,
                ),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomTextFormField(
                textFormKey: _valueKey,
                controller: _valueController,
                labelText: AppLocalizations.current.total,
                keyboardType: TextInputType.number,
                onChanged: (value) => cubit.onChangeServiceValue(value),
                validator: (value) => cubit.validateNumberField(
                  _valueController.numberValue.toString(),
                  AppLocalizations.current.total,
                ),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomTextFormField(
                textFormKey: _discountKey,
                controller: _discountController,
                labelText: AppLocalizations.current.discountPercentage,
                keyboardType: TextInputType.number,
                onChanged: (value) => cubit.onChangeServiceValue(value),
                validator: (value) => cubit.validateNumberField(
                  _discountController.numberValue.toString(),
                  AppLocalizations.current.discountPercentage,
                ),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomDatePicker(
                label: AppLocalizations.current.date,
                fieldKey: _dateKey,
                controller: _dateController,
                onChange: onChangeDate,
                validator: (value) => cubit.validateTextField(
                    value, AppLocalizations.current.date),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomTextFormField(
                textFormKey: _quantityKey,
                controller: _quantityController,
                labelText: AppLocalizations.current.quantity,
                keyboardType: TextInputType.number,
                onChanged: (value) => cubit.onChangeServicesQuantity(value),
                validator: (value) => cubit.validateNumberField(
                    value, AppLocalizations.current.quantity),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomTextFormField(
                textFormKey: _descriptionKey,
                labelText: AppLocalizations.current.description,
                maxLines: 3,
                initialValue: cubit.state.service.description,
                onChanged: (value) => cubit.onChangeServiceDescription(value),
              ),
              AppSizeConstants.bigVerticalSpacer,
              PillButton(
                onTap: onConfirm,
                child: Text(AppLocalizations.current.saveService),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
