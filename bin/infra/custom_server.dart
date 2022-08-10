import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import '../utils/custom_env.dart';

class CustomServer {
  Future<void> initialize({
    required Handler handler,
    required String address,
    required int newport,
  }) async {
    String url = address;
    int port = newport;
    await shelf_io.serve(handler, url, port);

    print("Servidor inicializado-> http://$url:$port");
  }
}
