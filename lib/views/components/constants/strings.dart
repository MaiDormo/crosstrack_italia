import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  //likes
  static const allowLikesTitle = 'Permetti mi piace';
  static const allowLikesDescription =
      'Permettendo mi piace, gli utenti potranno premere il tasto mi piace sul tuo post';
  static const allowLikesStorageKey = 'allow_likes';

  //comments
  static const allowCommentsTitle = 'Permetti commenti';
  static const allowCommentsDescription =
      'Permettendo i commenti, gli utenti potranno lasciare dei commenti sul tuo post';
  static const allowCommentsStorageKey = 'allow_comments';

  //utilities
  static const comment = 'commento';
  static const loading = 'Loading...';
  static const person = 'persona';
  static const people = 'persone';
  static const likedThisSingular = 'ha messo mi piace';
  static const likedThisPlural = 'hanno messo mi piace';

  //delete
  static const delete = 'Elimina';
  static const areYouSureThatYouWantToDeleteThis = 'Sicuro di voler eliminare';

  //Log out
  static const logOut = 'Esci';
  static const areYouSureThatYouWantToLogOutOfTheApp =
      'Sei sicuro di voler uscire dall\'applicazione';

  //cancel
  static const cancel = 'Cancella';

  //tracks
  static const noTracksAvaiable = 'Nessun tracciato disponibile';

  //private const constructor
  const Strings._();
}
