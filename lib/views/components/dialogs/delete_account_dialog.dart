import 'package:flutter/foundation.dart' show immutable;

import '../constants/strings.dart';
import 'alert_dialog_model.dart';

@immutable
class DeleteAccountDialog extends AlertDialogModel<bool> {
  const DeleteAccountDialog()
      : super(
          title: Strings.deleteAccount,
          message: Strings.areYouSureThatYouWantToDeleteYourAccount,
          buttons: const {
            Strings.cancelOperation: false,
            Strings.delete: true,
          },
        );
}
