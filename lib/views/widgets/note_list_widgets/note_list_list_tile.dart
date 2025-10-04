import 'package:flutter/material.dart';
import 'package:note_app/helpers/app_styles.dart';
class NoteListListTile extends StatelessWidget {
  const NoteListListTile({super.key, required this.title, required this.subtitle, this.onTap, this.onDelete});
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 16),
      child: ListTile(
        title: Text(title,style: AppStyles.font16blackTextW500,),
        subtitle: Text(subtitle,style: AppStyles.font14lightTextW400,),
        trailing: IconButton(icon: Icon(Icons.delete,size: 24,), onPressed:  onDelete,),
        onTap: onTap,
      ),
    );
  }
}
