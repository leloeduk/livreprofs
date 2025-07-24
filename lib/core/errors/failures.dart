abstract class Failure implements Exception {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(message: 'Pas de connexion Internet disponible');
}

class CacheFailure extends Failure {
  CacheFailure() : super(message: 'Erreur de cache');
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure() : super(message: 'Entrée invalide');
}
