import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserApi extends Api {
  final UserService userService;

  UserApi(this.userService);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/user', (Request req) async {
      //Lê o body enviado pelo usuário como uma string
      String body = await req.readAsString();

      //checa se a string n é vazia, ou seja, se o body enviado pelo ususario é valido
      if (body.isEmpty) return Response(400);

      //converte o body recebido em um UserModel
      UserModel user = UserModel.fromRequest(jsonDecode(body));

      //salva no banco de dados o usuario inserido
      bool result = await userService.save(user);

      //checa se a açao de salvar o usuario deu certo, casso nao ERRO -> 500
      return result ? Response(201) : Response(500);
    });
    return createHandler(router: router);
  }
}
