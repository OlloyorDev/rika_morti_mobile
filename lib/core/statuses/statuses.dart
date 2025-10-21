enum GetStatus { initial, loading, success, failure, empty }

enum PutStatus { initial, loading, success, failure }

enum PostStatus { initial, loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

extension GetStatusX on GetStatus {
  bool get initial => this == GetStatus.initial;

  bool get loading => this == GetStatus.loading;

  bool get success => this == GetStatus.success;

  bool get failure => this == GetStatus.failure;
}

extension PutStatusX on PutStatus {
  bool get initial => this == PutStatus.initial;

  bool get loading => this == PutStatus.loading;

  bool get success => this == PutStatus.success;

  bool get failure => this == PutStatus.failure;
}

extension PostStatusX on PostStatus {
  bool get initial => this == PostStatus.initial;

  bool get loading => this == PostStatus.loading;

  bool get success => this == PostStatus.success;

  bool get failure => this == PostStatus.failure;
}

extension DeleteStatusX on DeleteStatus {
  bool get initial => this == DeleteStatus.initial;

  bool get loading => this == DeleteStatus.loading;

  bool get success => this == DeleteStatus.success;

  bool get failure => this == DeleteStatus.failure;
}
