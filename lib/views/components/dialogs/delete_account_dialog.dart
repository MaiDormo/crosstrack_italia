import 'alert_dialog_model.dart';
import '../constants/strings.dart';
import 'package:flutter/foundation.dart' show immutable;

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
