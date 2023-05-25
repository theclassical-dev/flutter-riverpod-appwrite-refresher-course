//type definition

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_twitter_course/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
