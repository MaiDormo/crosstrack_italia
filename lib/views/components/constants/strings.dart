import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {

  //private const constructor
  const Strings._();
  //Log out
  static const logOut = 'Esci';
  static const areYouSureThatYouWantToLogOutOfTheApp =
      'Sei sicuro di voler uscire dall\'applicazione?';

  //delete account
  static const areYouSureThatYouWantToDeleteYourAccount =
      'Sei sicuro di voler eliminare il tuo account?';
  static const deleteAccount = 'Elimina account';
  static const delete = 'Elimina';
  static const cancelOperation = 'Annulla operazione';

  //cancel
  static const cancel = 'Cancella';

  //tracks
  static const noTracksAvaiable = 'Nessun tracciato disponibile';

  //remove owned tracks
  static const removeOwnedTrack = 'Rimuovi tracciato possedutio';
  static const areYouSureThatYouWantToRemoveThisTrack =
      'Sei sicuro di voler rimuovere questo tracciato?';

  //remove owner privilege
  static const removeOwnerPrivilege =
      'Rimuovi privilegio di gestore del tracciato';
  static const areYouSureThatYouWantToRemoveOwnerPrivilege =
      'Sei sicuro di voler rimuovere il privilegio di gestore del tracciato?';
  static const giveUp = 'Rinuncia';
}
