import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'package:my_services/views/home/home.dart';

import '../../../shared/models/dropdown_item.dart';
import '../../../shared/widgets/custom_dropdown/custom_dropdown_widget.dart';
import '../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/widgets/custom_text_form_field/custom_text_form_field_widget.dart';

class AddServiceProvidedForm extends StatefulWidget {
  final String labelButton;
  final Function() onConfirm;
  const AddServiceProvidedForm(
      {super.key, required this.labelButton, required this.onConfirm});

  @override
  State<AddServiceProvidedForm> createState() => _AddServiceProvidedFormState();
}

class _AddServiceProvidedFormState extends State<AddServiceProvidedForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey<FormFieldState>();
  final _dateKey = GlobalKey<FormFieldState>();
  final _dropdownKey = GlobalKey<FormFieldState>();
  final _valueKey = GlobalKey<FormFieldState>();
  final dateController =
      MaskedTextController(text: 'dd/MM/yyyy', mask: '00/00/0000');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //TODO: Dropdown
            _ServiceTypeField(fieldKey: _dropdownKey),
            const SizedBox(height: 10),
            _ValueField(fieldKey: _valueKey),
            const SizedBox(height: 10),
            //TODO: Date picker
            _DateField(fieldKey: _dateKey, dateController: dateController),
            const SizedBox(height: 10),
            _DescriptionField(fieldKey: _descriptionKey),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onTap: () => widget.onConfirm(),
              text: widget.labelButton,
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _DescriptionField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: 'Nome',
      initialValue: cubit.state.serviceProvided.description,
      onChanged: (value) => cubit.changeServiceDescription(value),
    );
  }
}

class _ValueField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _ValueField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return CustomTextFormField(
      textFormKey: fieldKey,
      labelText: 'Valor padrão',
      keyboardType: TextInputType.number,
      initialValue: cubit.state.serviceProvided.value.toString(),
      onChanged: (value) => cubit.changeServiceValue(value),
    );
  }
}

class _ServiceTypeField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  const _ServiceTypeField({Key? key, required this.fieldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return CustomDropdown(
      key: fieldKey,
      label: 'Tipo de serviço',
      hint: 'Selecione o tipo do serviço',
      items: [],
      selectedItem: null,
      onChanged: (DropdownItem? data) {
        if (data != null) {}
      },
      showSeach: true,
    );
  }
}

class _DateField extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final MaskedTextController dateController;
  const _DateField({
    Key? key,
    required this.fieldKey,
    required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    void onChangeDatePicker(DateTime? date) {
      cubit.changeServiceDate(date);
      if (date != null) {
        final day = date.day < 10 ? '0${date.day}' : date.day.toString();
        final month =
            date.month < 10 ? '0${date.month}' : date.month.toString();
        final formattedDate = '$day$month${date.year}';
        dateController.text = formattedDate;
      }
    }

    return CustomTextFormField(
        labelText: 'Data',
        icon: Icons.calendar_today,
        keyboardType: TextInputType.datetime,
        controller: dateController,
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: dateController.text != ''
                ? cubit.state.serviceProvided.date
                : DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now(),
          ).then((value) => onChangeDatePicker(value));
        });
  }
}
