import 'package:shelf/shelf.dart';

import 'api/item_api.dart';
import 'api/login_api.dart';

import 'api/user_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  final di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(di<LoginApi>().getHandler())
      .add(di<ItemApi>().getHandler())
      .add(di<UserApi>().getHandler(isSecurity: true))
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MInterception.contentTypeJson)
      .addMiddleware(MInterception.cors)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    newport: await CustomEnv.get<int>(key: 'server_port'),
  );
}
