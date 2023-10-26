import 'package:event_bus/event_bus.dart';

class CommonEventBus {
  late EventBus _eventBus;
  factory CommonEventBus() => _getInstance();
  // instance的getter方法 - 通过CommonEventBus.instance获取对象
  static CommonEventBus get instance => _getInstance();
  // 静态变量_instance，存储唯一对象
  static CommonEventBus? _instance;
  // 获取唯一对象
  static CommonEventBus _getInstance() {
    _instance ??= CommonEventBus._internal();
    return _instance!;
  }

  CommonEventBus._internal() {
    _eventBus = EventBus();
  }

  void listen<T>(void Function(T event) callBack) {
    _eventBus.on<T>().listen((event) {
      callBack(event);
    });
  }

  void fire<T>(T t) {
    _eventBus.fire(t);
  }
}
