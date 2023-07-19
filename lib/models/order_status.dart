enum OrderStatus {
  cancelled('Cancelado'),
  pending('Pendiente'),
  preparing('En preparación'),
  delivered('Enviado');

  final String status;
  const OrderStatus(this.status);
}
