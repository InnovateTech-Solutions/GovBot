import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/sizes/sizes.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/login/model/login_form_model.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({
    required this.formModel,
    this.ontap,
    super.key,
  });

  final FormModel formModel;
  final VoidCallback? ontap;

  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: SizedBox(
        height: context.screenHeight * .5,
        child: TextFormField(
          maxLines: 15,
          cursorColor: AppTheme.lightAppColors.primary,
          style: TextStyle(
            color: AppTheme.lightAppColors.primary,
          ),
          readOnly: widget.formModel.enableText,
          inputFormatters: widget.formModel.inputFormat,
          keyboardType: widget.formModel.type,
          validator: widget.formModel.validator,
          controller: widget.formModel.controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: widget.ontap,
              icon: Icon(widget.formModel.icon),
            ),
            filled: true,
            fillColor: AppTheme.lightAppColors.containercolor.withOpacity(.05),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.lightAppColors.primary.withOpacity(.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.lightAppColors.primary.withOpacity(.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            hintText: widget.formModel.hintText.tr,
            hintStyle: TextStyle(
              fontFamily: "Tajawal",
              color: AppTheme.lightAppColors.primary.withOpacity(.5),
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
