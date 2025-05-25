part of 'customer_bloc.dart';

enum CustomerStatus {
  initial,
  loading,
  loaded,
  success,
  error,
  changed,
  updated,
  deleted,
}

class CustomerState extends Equatable {
  final CustomerStatus customerStatus;
  final List<CustomerModel> customerModel;
  final CustomerModel? formValue;

  const CustomerState({
    required this.customerModel,
    required this.customerStatus,
    this.formValue,
  });

  static final initial = CustomerState(
    customerStatus: CustomerStatus.initial,
    customerModel: [],
    formValue: CustomerModel.empty(),
  );

  CustomerState copyWith({
    CustomerStatus? customerStatus,
    List<CustomerModel>? customerModel,
    CustomerModel? formValue,
  }) {
    return CustomerState(
      customerModel: customerModel ?? this.customerModel,
      customerStatus: customerStatus ?? this.customerStatus,
      formValue: formValue ?? this.formValue,
    );
  }

  @override
  List<Object?> get props => [customerStatus, customerModel, formValue];
}
