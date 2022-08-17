import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/item_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class ItemApi extends Api {
  final GenericService<ItemModel> _service;

  ItemApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true}) {
    final router = Router();

    ///Pega um item pelo id, recebendo o id pelo body
    router.post('/item', (Request req) async {
      String body = await req.readAsString();
      var result =
          await _service.findOne(ItemModel.fromRequest(jsonDecode(body)).id!);
      if (result == null) return Response(400);
      return Response.ok(jsonEncode(result.toJson()));
    });

    ///Pega todos os itens registrados na tabela
    router.get('/itens-all', (Request req) async {
      List<ItemModel> itens = await _service.findAll();
      List<Map> itensMap = itens.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(itensMap));
    });

    ///Novo item na tabela
    router.post('/item-add', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(ItemModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    ///Atualizar um item na tabela
    router.put('/item-att', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(ItemModel.fromRequest(jsonDecode(body)));

      return result ? Response(200) : Response.internalServerError();
    });

    ///Deletar um item na tabela
    router.delete('/item-delete', (Request req) async {
     String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: false,
    );
  }
}
