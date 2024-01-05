import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  //comments
  static const allowCommentsTitle = 'Permetti commenti';
  static const allowCommentsDescription =
      'Permettendo i commenti, gli utenti potranno lasciare dei commenti sul tuo post';
  static const allowCommentsStorageKey = 'allow_comments';

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

  //private const constructor
  const Strings._();
}
