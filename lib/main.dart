import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'screens/map_screen.dart';
import 'screens/tracker_screen.dart';
import 'services/notification_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notificaciones fallan -> app arrancar
  try {
    await NotificationService.init();
  } catch (e) {
    debugPrint('Error iniciando notificaciones: $e');
  }

  runApp(const TallerMovilidadApp());
}

class TallerMovilidadApp extends StatelessWidget {
  const TallerMovilidadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Movilidad',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          TrackerScreen(),
          MapScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.directions_walk),
            label: 'Caminata',
          ),
          NavigationDestination(
            icon: Icon(Icons.park),
            label: 'Parques',
          ),
        ],
      ),
    );
  }
}