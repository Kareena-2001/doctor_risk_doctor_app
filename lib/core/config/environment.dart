enum Environment { development, production }

class EnvironmentConfig {
  final Environment environment;
  final String baseUrl;

  const EnvironmentConfig._({required this.environment, required this.baseUrl});

  factory EnvironmentConfig.development() {
    return const EnvironmentConfig._(
      environment: Environment.development,
      baseUrl: 'https://mboxindia.com/kalshr/api/',
    );
  }

  factory EnvironmentConfig.production() {
    return const EnvironmentConfig._(
      environment: Environment.production,
      baseUrl: 'https://kals360sdsAD.com/api/',
    );
  }

  bool get isDevelopment => environment == Environment.development;

  bool get isProduction => environment == Environment.production;
}
