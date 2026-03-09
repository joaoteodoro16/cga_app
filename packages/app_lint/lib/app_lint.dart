import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _MeuLintPlugin();

class _MeuLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      NoDirectColorUsage(),
    ];
  }
}

class NoDirectColorUsage extends DartLintRule {
  NoDirectColorUsage() : super(code: _code);

  static const _code = LintCode(
    name: 'no_direct_color_usage',
    problemMessage:
        'Não use Color ou Colors diretamente. Use AppColors.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    // 1️⃣ Captura: Color(...)
    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType?.toString();

      if (type == 'Color') {
        reporter.atNode(node, _code);
      }
    });

    // 2️⃣ Captura: Colors.red
    context.registry.addPrefixedIdentifier((node) {
      if (node.prefix.name == 'Colors') {
        reporter.atNode(node, _code);
      }
    });
  }
}