library generative_ui;

// Domain layer exports - Entities
export 'src/domain/entities/gen_exception.dart';
export 'src/domain/entities/content_block.dart';
export 'src/domain/entities/llm_response.dart';
export 'src/domain/entities/gen_tool.dart';
export 'src/domain/entities/chat_message.dart';
export 'src/domain/entities/conversation_state.dart';
export 'src/domain/entities/tool_action_output.dart';

// Domain layer exports - Repositories
export 'src/domain/repositories/i_content_generator.dart';
export 'src/domain/repositories/i_conversation_generator.dart';

// Domain layer exports - Use Cases
export 'src/domain/usecases/orchestrate_ui_flow.dart';

// Data layer exports - Utils
export 'src/data/utils/response_parser.dart';
export 'src/data/utils/schema_generator.dart';

// Data layer exports - Config
export 'src/data/config/aws_config.dart';

// Data layer exports - Datasources
export 'src/data/datasources/mock_content_generator.dart';
export 'src/data/datasources/aws_content_generator.dart';

// Presentation layer exports
export 'src/presentation/state/gen_ui_state.dart';
export 'src/presentation/registry/component_registry.dart';
export 'src/presentation/registry/registry_helpers.dart';
export 'src/presentation/gen_ui_wrapper.dart';
export 'src/presentation/widgets/gen_ui_container.dart';
export 'src/presentation/widgets/dynamic_builder.dart';
export 'src/presentation/widgets/loading_indicator.dart';
export 'src/presentation/widgets/error_display.dart';

// Chat exports (Phase 3)
export 'src/presentation/chat/chat_controller.dart';
export 'src/presentation/chat/chat_input_area.dart';
export 'src/presentation/chat/gen_ui_chat_view.dart';

// Demo components for example usage
export 'src/presentation/widgets/demo_components.dart';
