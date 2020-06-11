enum TaskFrequency { DAILY, WEEKLY, MONTHLY, CUSTOM, ONCE, ANNUALLY }
enum ConfirmAction { ACCEPT, CANCEL }
enum MenuState {
  CLOSED,
  OPENING,
  OPEN,
  CLOSING,
}

T stringToEnum<T>(Iterable<T> values, String value) {
  return values?.firstWhere((type) => type?.toString() == value,
      orElse: () => null);
}
