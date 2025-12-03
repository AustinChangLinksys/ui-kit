import '../../domain/repositories/i_content_generator.dart';

/// Placeholder for AWS Bedrock integration (Phase 3)
class AwsPassThroughGenerator implements IContentGenerator {
  @override
  Future<String> generate(String userInput) async {
    throw UnimplementedError(
      'AWS Bedrock integration is deferred to Phase 3. '
      'This placeholder will be replaced with real AWS implementation.'
    );
  }
}
