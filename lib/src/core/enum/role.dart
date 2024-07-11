enum Role {
  promoter('Seller'),
  supervisor('Buyer');

  const Role(this.value);
  final String value;

  static Role? fromString(String? value) {
    switch (value) {
      case 'Seller':
        return Role.promoter;
      case 'Buyer':
        return Role.supervisor;
      default:
        return null;
    }
  }
}
