class ApiPaths {
  // Base URL
  static const String baseUrl = "http://localhost:8000";

  // Endpoints
  static const String signup = "$baseUrl/users/signup";
  static const String login = "$baseUrl/users/login";


  static const String userReports = "$baseUrl/reports/userReports";
  static const String addReport = "$baseUrl/reports/addReport";

  static const String getUserInfo = "$baseUrl/users/userData";
  static const String updateUserInfo = "$baseUrl/users/update"; 

  static const String getAllHistory = "$baseUrl/v1/get_history"; // /v1/validate
  static const String validateFact = "$baseUrl/v1/validate";

}
