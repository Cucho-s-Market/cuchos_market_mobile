import 'package:cuchos_market_mobile/models/order.dart';

class Issue {
  final int? id;
  final String title;
  final String description;
  final String userEmail;
  final DateTime creationDate;
  final Order order;

  Issue({
    this.id,
    required this.title,
    required this.description,
    required this.userEmail,
    required this.creationDate,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'creationDate': creationDate.toString().split(' ').first,
      'user': userEmail,
      'orderId': order.id,
    };
  }
}
