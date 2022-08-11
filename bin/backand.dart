import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

void main() async {
  final dependencyInjector = DependencyInjector();

  dependencyInjector.register<SecurityService>(() => SecurityServiceImp(),
      isSingleton: true);
  SecurityService securityService = dependencyInjector.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(securityService).getHandler())
      .add(BlogApi(NoticiaService()).getHandler(
        middlewares: [securityService.authorization, securityService.verifyJWT],
      ))
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    newport: await CustomEnv.get<int>(key: 'server_port'),
  );
}
