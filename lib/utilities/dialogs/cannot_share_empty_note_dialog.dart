import 'package:dairl/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showCannotShareEmptyNotesDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'sharing',
    content: 'You cannot share an empty note',
    optionsBuilder: () => {'OK': null},
  );
}
