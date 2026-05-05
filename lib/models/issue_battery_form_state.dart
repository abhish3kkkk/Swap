import 'battery_model.dart';

class IssueBatteryFormState {
  final String driverId;
  final BatteryModel? battery;
  final bool isSubmitting;
  final String? errorMessage;

  const IssueBatteryFormState({
    this.driverId = '',
    this.battery,
    this.isSubmitting = false,
    this.errorMessage,
  });

  bool get isValid => driverId.trim().isNotEmpty && battery != null;

  IssueBatteryFormState copyWith({
    String? driverId,
    BatteryModel? battery,
    bool? isSubmitting,
    String? errorMessage,
    bool clearBattery = false,
    bool clearError = false,
  }) {
    return IssueBatteryFormState(
      driverId: driverId ?? this.driverId,
      battery: clearBattery ? null : (battery ?? this.battery),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}