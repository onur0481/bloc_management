enum FormStatus {
  pure,
  dirty,
  submissionInProgress,
  submissionSuccess,
  submissionFailure;

  bool get isPure => this == FormStatus.pure;
  bool get isDirty => this == FormStatus.dirty;
  bool get isSubmissionInProgress => this == FormStatus.submissionInProgress;
  bool get isSubmissionSuccess => this == FormStatus.submissionSuccess;
  bool get isSubmissionFailure => this == FormStatus.submissionFailure;
}
