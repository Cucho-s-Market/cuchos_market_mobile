enum OrderType {
  // ignore: constant_identifier_names
  pick_up('Pick-Up'),
  delivery('Delivery');

  final String status;
  const OrderType(this.status);
}
