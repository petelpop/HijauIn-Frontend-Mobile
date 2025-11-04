import 'package:fpdart/fpdart.dart';
import 'package:hijauin_frontend_mobile/utils/exception.dart';

typedef FutureEither<T> = Future<Either<ApiException, T>>;
typedef FutureEitherVoid = FutureEither<void>;
