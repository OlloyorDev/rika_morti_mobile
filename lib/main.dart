import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rika_morti_mobile/core/util/log_bloc_observer.dart';
import 'package:rika_morti_mobile/features/app/app.dart';
import 'package:rika_morti_mobile/features/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  if (kDebugMode) Bloc.observer = LogBlocObserver();
  runApp(const App());
}
