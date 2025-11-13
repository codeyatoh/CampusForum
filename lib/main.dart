import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'contexts/dark_mode_context.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Suppress DevTools-related warnings in web mode
  if (kIsWeb) {
    // Override debugPrint to filter DevTools messages
    final originalDebugPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) {
        final msg = message.toLowerCase();
        if (msg.contains('ext.flutter.connectedvmserviceuri') ||
            msg.contains('ext.flutter.activedevtoolsserveraddress') ||
            msg.contains('failed to set vm service uri') ||
            msg.contains('failed to set devtools server address') ||
            msg.contains('deep links to devtools') ||
            msg.contains('dwds error') ||
            msg.contains('unknown method') ||
            msg.contains('(-32601)')) {
          return; // Suppress these messages
        }
      }
      // Use original debugPrint for other messages
      originalDebugPrint(message, wrapWidth: wrapWidth);
    };
    
    // Suppress DevTools-related Flutter errors
    FlutterError.onError = (FlutterErrorDetails details) {
      final errorString = details.toString().toLowerCase();
      if (errorString.contains('ext.flutter.connectedvmserviceuri') ||
          errorString.contains('ext.flutter.activedevtoolsserveraddress') ||
          errorString.contains('failed to set vm service uri') ||
          errorString.contains('failed to set devtools server address') ||
          errorString.contains('deep links to devtools') ||
          errorString.contains('dwds error') ||
          errorString.contains('unknown method') ||
          errorString.contains('(-32601)')) {
        return; // Suppress these warnings
      }
      FlutterError.presentError(details);
    };
  }
  
  final darkModeProvider = DarkModeProvider();
  await darkModeProvider.initialize();
  
  runApp(
    ChangeNotifierProvider.value(
      value: darkModeProvider,
      child: const App(),
    ),
  );
}

