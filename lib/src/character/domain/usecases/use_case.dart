
abstract class UseCase<Type, Params> {
  const UseCase();
  Type call({Params? param});
}
