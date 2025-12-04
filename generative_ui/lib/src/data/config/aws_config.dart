import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/entities/gen_exception.dart';

/// AWS Bedrock configuration.
///
/// Encapsulates all AWS credentials and configuration needed for
/// communicating with AWS Bedrock Runtime API.
class AWSConfig {
  /// AWS Access Key ID.
  final String accessKeyId;

  /// AWS Secret Access Key.
  final String secretAccessKey;

  /// AWS Region (e.g., 'us-east-1').
  final String region;

  /// Bedrock Model ID (e.g., 'anthropic.claude-3-5-sonnet-20241022-v2:0').
  final String modelId;

  const AWSConfig({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.region,
    required this.modelId,
  });

  /// Load configuration from environment variables.
  ///
  /// Requires the following environment variables to be set:
  /// - AWS_ACCESS_KEY_ID
  /// - AWS_SECRET_ACCESS_KEY
  /// - AWS_REGION
  /// - BEDROCK_MODEL_ID
  ///
  /// Throws [ConfigurationException] if any required variable is missing.
  factory AWSConfig.fromEnvironment() {
    final accessKeyId = dotenv.env['AWS_ACCESS_KEY_ID'];
    final secretAccessKey = dotenv.env['AWS_SECRET_ACCESS_KEY'];
    final region = dotenv.env['AWS_REGION'];
    final modelId = dotenv.env['BEDROCK_MODEL_ID'];

    if (accessKeyId == null || accessKeyId.isEmpty) {
      throw ConfigurationException(
        'AWS_ACCESS_KEY_ID not set',
        missingKey: 'AWS_ACCESS_KEY_ID',
      );
    }
    if (secretAccessKey == null || secretAccessKey.isEmpty) {
      throw ConfigurationException(
        'AWS_SECRET_ACCESS_KEY not set',
        missingKey: 'AWS_SECRET_ACCESS_KEY',
      );
    }
    if (region == null || region.isEmpty) {
      throw ConfigurationException(
        'AWS_REGION not set',
        missingKey: 'AWS_REGION',
      );
    }
    if (modelId == null || modelId.isEmpty) {
      throw ConfigurationException(
        'BEDROCK_MODEL_ID not set',
        missingKey: 'BEDROCK_MODEL_ID',
      );
    }

    return AWSConfig(
      accessKeyId: accessKeyId,
      secretAccessKey: secretAccessKey,
      region: region,
      modelId: modelId,
    );
  }

  /// Get Bedrock Runtime endpoint URL.
  ///
  /// Manually URL-encodes the model ID to ensure ':' becomes '%3A'
  /// as required by AWS SigV4 signing.
  Uri get endpointUri {
    // URL-encode the model ID (': ' -> '%3A')
    final encodedModelId = Uri.encodeComponent(modelId);
    return Uri.parse(
      'https://bedrock-runtime.$region.amazonaws.com/model/$encodedModelId/invoke',
    );
  }

  /// Get the service name for SigV4 signing.
  String get serviceName => 'bedrock';

  @override
  String toString() =>
      'AWSConfig(region: $region, modelId: $modelId, accessKeyId: ${accessKeyId.substring(0, 4)}***)';
}
