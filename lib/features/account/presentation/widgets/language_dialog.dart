import 'package:al_omda/features/categories/presentation/controller/cubit/categories_cubit.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:al_omda/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, size: 48.0, color: Colors.green),
            SizedBox(height: 16.0),
            Text(
              S.of(context).change_language,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                context.read<LocaleCubit>().toggleLocale();

                Navigator.pop(context); // Close the dialog
              },
              child: Text(S.of(context).lang),
            ),
          ],
        ),
      ),
    );
  }
}
