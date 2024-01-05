import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/constants/strings.dart';
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
