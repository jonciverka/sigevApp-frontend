import 'package:sigev/domain/models/bot.dart';

abstract class BotRepository {
  Future<List<CategoriaBot>> obtenerCategorias();
  Future<List<CategoriaBot>> obtenerSubCategorias({
    required String pkCategoria,
  });
  Future<List<PreguntaBot>> obtenerPreguntas({required String pkCategoria});
  Future<List<RespuestaBot>> obtenerRespuestas({required String pkPregunta});
}
