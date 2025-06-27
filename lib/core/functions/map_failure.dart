import '../error/failure.dart';

String mapFailure(Failure failure) {
  switch (failure.runtimeType) {
    case OfflineFailure:
      return 'Ops , you are offline..';
    case ServerFailure:
      ServerFailure serverFailure = failure as ServerFailure;
      {
        if (serverFailure.message.contains('ClientException')) {
          return 'There is a problem, refresh this page or try again later';
        }
        if (serverFailure.message.contains('Invalid login credentials')) {
          return 'Email or password is wrong';
        }
        return serverFailure.message;
      }
    case EmptyCacheFailure:
      return 'There is no cache';
  }
  return 'Error..';
}
