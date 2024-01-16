import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/constants/strings.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class RemoveOwnedTrackDialog extends AlertDialogModel<bool> {
  const RemoveOwnedTrackDialog()
      : super(
          title: Strings.removeOwnedTrack,
          message: Strings.areYouSureThatYouWantToRemoveThisTrack,
          buttons: const {
            Strings.cancelOperation: false,
            Strings.delete: true,
          },
        );
}
