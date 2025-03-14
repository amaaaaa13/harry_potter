abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network Failure'])
      : super('Network Failure: $message');
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server Failure'])
      : super('Server Failure: $message');
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Unknown Failure'])
      : super('Unknown Failure: $message');
}
