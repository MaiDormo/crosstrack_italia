import 'alert_dialog_model.dart';
import '../constants/strings.dart';
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
