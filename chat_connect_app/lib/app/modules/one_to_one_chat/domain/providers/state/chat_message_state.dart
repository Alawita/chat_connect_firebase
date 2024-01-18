class ChateMessageState {
  ChateMessageState({
    this.isLoading = false,
    this.error,
    this.message = "",
  });

  final bool isLoading;
  final Object? error;
  final String message;

  ChateMessageState copyWith({
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return ChateMessageState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}
