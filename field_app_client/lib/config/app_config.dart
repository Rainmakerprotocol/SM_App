class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'SM_API_BASE_URL',
    defaultValue: 'https://stormmaster.local',
  );

  static const bool useMockAuth = bool.fromEnvironment(
    'USE_MOCK_AUTH',
    defaultValue: true,
  );

  static const bool useMockPunchSync = bool.fromEnvironment(
    'USE_MOCK_PUNCH_SYNC',
    defaultValue: true,
  );

  static const bool useMockJobsApi = bool.fromEnvironment(
    'USE_MOCK_JOBS_API',
    defaultValue: true,
  );

  static const bool useMockPunchApi = bool.fromEnvironment(
    'USE_MOCK_PUNCH_API',
    defaultValue: true,
  );

  static const bool useMockProfileApi = bool.fromEnvironment(
    'USE_MOCK_PROFILE_API',
    defaultValue: true,
  );

  static const bool useMockTimesheetApi = bool.fromEnvironment(
    'USE_MOCK_TIMESHEET_API',
    defaultValue: true,
  );
}
