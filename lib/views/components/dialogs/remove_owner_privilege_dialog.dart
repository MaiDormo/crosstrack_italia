import 'alert_dialog_model.dart';
import '../constants/strings.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class RemoveOwnerPrivilegeDialog extends AlertDialogModel<bool> {
  const RemoveOwnerPrivilegeDialog()
      : super(
          title: Strings.removeOwnerPrivilege,
          message: Strings.areYouSureThatYouWantToRemoveOwnerPrivilege,
          buttons: const {
            Strings.cancelOperation: false,
            Strings.giveUp: true,
          },
        );
}
