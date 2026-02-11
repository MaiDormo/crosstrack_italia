import 'package:flutter/foundation.dart' show immutable;

import '../constants/strings.dart';
import 'alert_dialog_model.dart';

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
