import 'package:al_omda/generated/l10n.dart';
import 'package:al_omda/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDialog extends StatelessWidget {
  const CountryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flag, size: 48.0, color: Colors.green),
            SizedBox(height: 16.0),
            Text(
              S.of(context).change_country,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              S.of(context).only_avilble_in_egypt,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel),
            ),
          ],
        ),
      ),
    );
  }
}
