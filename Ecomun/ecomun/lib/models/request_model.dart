enum RequestStatus { 
  pending,    // Solicitud recién creada, esperando procesamiento
  approved,   // Solicitud aprobada, pendiente de recojo
  completed,  // Recojo completado exitosamente
  rejected    // Solicitud rechazada por alguna razón
}

class RequestModel {
  final String id;
  final String userId;
  final String materialId;
  final double quantity;
  final DateTime date;
  final String? observations;
  RequestStatus status;

//Constructor
  RequestModel({
    required this.id,
    required this.userId,
    required this.materialId,
    required this.quantity,
    required this.date,
    this.observations,
    this.status = RequestStatus.pending,
  });

  RequestModel copyWith({
    RequestStatus? status,
  }) =>
      RequestModel(
        id: id,
        userId: userId,
        materialId: materialId,
        quantity: quantity,
        date: date,
        observations: observations,
        status: status ?? this.status,
      );
}