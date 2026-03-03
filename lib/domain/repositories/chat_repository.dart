import 'package:sigev/domain/models/chats.dart';

abstract class ChatRepository {
  Future<int> generarNuevoChat({required String claveTramite});
  Future<void> finalizarChat({required String pkChatBarraFija});
  Future<List<Mensaje>> obtenerMensajesChat({required String claveTramite});
}
