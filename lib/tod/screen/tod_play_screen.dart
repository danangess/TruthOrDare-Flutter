import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare/tod/bloc/bloc.dart';
import 'package:truth_or_dare/ui/widget/widget.dart';

class TodPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodBloc, TodState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Truth or Dare'),
            actions: [],
          ),
          body: state is TodLoadInProgress
              ? LoadingWidget()
              : _body(context, state),
        );
      },
    );
  }

  Widget _body(BuildContext context, TodState state) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 45.0),
              _todText(state),
              SizedBox(height: 25.0),
              _doneButton(context),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _todText(TodState todState) {
    String text = 'Failed';
    if (todState is TodTruthLoadSuccess) {
      text = todState.truth.text;
    } else if (todState is TodDareLoadSuccess) {
      text = todState.dare.text;
    }
    return Material(
      elevation: 5.0,
      child: Text(text),
    );
  }

  Widget _doneButton(BuildContext context) {
    return ButtonWidget(
      text: 'Done',
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
