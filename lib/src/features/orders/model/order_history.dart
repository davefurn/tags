class OrderHistory {
  OrderHistory({
    this.count,
    this.limit,
    this.next,
    this.previous,
    this.results,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    var resultList = json['results'] as List<dynamic>? ?? [];
    List<OrderDetails> orders =
        resultList.map((i) => OrderDetails.fromJson(i)).toList();

    return OrderHistory(
      count: json['count'] ?? 0,
      limit: json['limit'] ?? 0,
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      results: orders,
    );
  }

  final int? count;
  final int? limit;
  final String? next;
  final String? previous;
  final List<OrderDetails>? results;

  Map<String, dynamic> toJson() => {
        'count': count ?? 0,
        'limit': limit ?? 0,
        'next': next ?? '',
        'previous': previous ?? '',
        'results': results?.map((order) => order.toJson()).toList() ?? [],
      };
}

class OrderDetails {
  OrderDetails({
    this.orderId,
    this.total,
    this.currency,
    this.createdAt,
    this.status,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orderId: json['order_id'] ?? '',
        total: json['total'] ?? '',
        currency: json['currency'] ?? '',
        createdAt: json['created_at'] ?? '',
        status: json['status'] ?? '',
      );

  final String? orderId;
  final String? total;
  final String? currency;
  final String? createdAt;
  final String? status;

  Map<String, dynamic> toJson() => {
        'order_id': orderId ?? '',
        'total': total ?? 0.0,
        'currency': currency ?? '',
        'created_at': createdAt ?? '',
        'status': status ?? '',
      };
}
