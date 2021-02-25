import 'dart:developer';

import 'package:bloc/bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare/app_bloc.dart';
import 'package:truth_or_dare/simple_bloc_observer.dart';
import 'package:truth_or_dare/tod/bloc/bloc.dart';
import 'package:truth_or_dare/tod/screen/screen.dart';
import 'package:truth_or_dare/ui/widget/widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildBlocProvider();
  }

  Widget _build() {
    return FutureBuilder(
      // future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log('Initializing app', error: snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return _buildBlocProvider();
        }

        return LoadingWidget();
      },
    );
  }

  void _setupBloc() {
    Bloc.observer = SimpleBlocObserver();
  }

  Widget _buildBlocProvider() {
    _setupBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodBloc>(
          create: (_) => TodBloc()..add(TodStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Truth or Dare',
        initialRoute: '/tod',
        routes: {
          '/tod': (context) => TodScreen(),
        },
      ),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  MyAppStateful() {
    WidgetsFlutterBinding.ensureInitialized();
    appBloc.dispatch(AppEvent.onStart);
  }

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodBloc>(
          create: (_) => TodBloc()..add(TodStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Truth or Dare',
        initialRoute: '/tod',
        routes: {
          '/tod': (context) => TodScreen(),
        },
      ),
    );
  }

  @override
  void dispose() {
    appBloc.dispatch(AppEvent.onStop);
    super.dispose();
  }
}
