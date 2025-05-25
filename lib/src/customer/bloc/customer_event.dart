part of "customer_bloc.dart";

abstract class CustomerEvent extends Equatable {}

class InitializeCustomer extends CustomerEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCustomerFormValue extends CustomerEvent {
  final Map<String, dynamic> formValue;
  ChangeCustomerFormValue({required this.formValue});
  @override
  List<Object?> get props => [formValue];
}

class AddCustomer extends CustomerEvent {
  @override
  List<Object?> get props => [];
}

class DeleteCustomer extends CustomerEvent {
  final String id;
  DeleteCustomer({required this.id});
  @override
  List<Object?> get props => [id];
}

class UpdateCustomer extends CustomerEvent {
  final String id;
  final CustomerModel customer;
  UpdateCustomer({required this.id, required this.customer});
  @override
  List<Object?> get props => [id, customer];
}
