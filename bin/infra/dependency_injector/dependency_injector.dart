typedef InstanceCreator<T> = T Function();

class DependencyInjector {
  DependencyInjector._();
  static final _singleton = DependencyInjector._();

  factory DependencyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  //register intances
  void register<T extends Object>(InstanceCreator<T> instance,
          {bool isSingleton = true}) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);
  //get instances
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();

    if (instance != null && instance is T) return instance;
    throw Exception("[ERROR] -> Instance ${T.toString()} not found");
  }

  call<T extends Object>() => get();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirtsGet = false;

  final InstanceCreator<T> _instanceCreator;
  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirtsGet = isSingleton;

  T? getInstance() {
    if (_isFirtsGet) {
      _instance = _instanceCreator();
      _isFirtsGet = false;
    }

    return _instance ?? _instanceCreator();
  }
}
