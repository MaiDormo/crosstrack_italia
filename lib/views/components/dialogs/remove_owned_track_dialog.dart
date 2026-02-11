import 'package:flutter/foundation.dart' show immutable;

import '../constants/strings.dart';
import 'alert_dialog_model.dart';

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
