import 'package:flutter/material.dart';

import '../../../helpers/app_styles.dart';

AppBar customAppBar({required final title, final VoidCallback? onEdit}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(title, style: AppStyles.font18blackTextW700),
    centerTitle: true,
    actions: onEdit != null ? [IconButton(onPressed: onEdit, icon: Icon(Icons.edit))] : null,
  );
}
