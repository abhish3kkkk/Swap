import 'battery_model.dart';

class ReturnBatteryFormState {
  final String driverId;
  final BatteryModel? battery;
  final String? condition;         // 'good' | 'damaged' | 'needs_service'
  final bool isSubmitting;
  final String? errorMessage;

  const ReturnBatteryFormState({
    this.driverId = '',
    this.battery,
    this.condition,
    this.isSubmitting = false,
    this.errorMessage,
  });

  bool get isValid =>
      driverId.trim().isNotEmpty &&
          battery != null &&
          condition != null;

  ReturnBatteryFormState copyWith({
    String? driverId,
    BatteryModel? battery,
    String? condition,
    bool? isSubmitting,
    String? errorMessage,
    bool clearBattery = false,
    bool clearError = false,
    bool clearCondition = false,
  }) {
    return ReturnBatteryFormState(
      driverId: driverId ?? this.driverId,
      battery: clearBattery ? null : (battery ?? this.battery),
      condition: clearCondition ? null : (condition ?? this.condition),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}