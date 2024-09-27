/// ENDPOINTS
enum NetworkRoutes {
  orders
}

extension NetwrokRoutesString on NetworkRoutes {
  String get rawValue {
    switch (this) {
      case NetworkRoutes.orders:
        return 'pedido';
    }
  }
}
