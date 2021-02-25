import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare/tod/bloc/bloc.dart';
import 'package:truth_or_dare/tod/model/model.dart';
import 'package:truth_or_dare/tod/screen/screen.dart';
import 'package:truth_or_dare/ui/widget/widget.dart';

class TodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truth or Dare'),
        actions: [
          _buildExtraAction(),
        ],
      ),
      body: _body(context),
    );
  }

  Widget _buildExtraAction() {
    return BlocBuilder<TodBloc, TodState>(builder: (context, state) {
      return PopupMenuButton<ExtraAction>(
        key: Key('tod_extraActions'),
        onSelected: (action) {
          switch (action) {
            case ExtraAction.syncData:
              BlocProvider.of<TodBloc>(context).add(TodSyncData());
              break;
            default:
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem<ExtraAction>(
              key: Key('sync_data'),
              value: ExtraAction.syncData,
              child: Text('Sync Data'),
            ),
          ];
        },
      );
    });
  }

  Widget _body(BuildContext context) {
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
              _truthButton(context),
              SizedBox(height: 25.0),
              _dareButton(context),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _truthButton(BuildContext context) {
    return ButtonWidget(
      text: 'Truth',
      onPressed: () {
        BlocProvider.of<TodBloc>(context).add(TodTruthChoosed());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return TodPlayScreen();
        }));
      },
    );
  }

  Widget _dareButton(BuildContext context) {
    return ButtonWidget(
      text: 'Dare',
      onPressed: () {
        BlocProvider.of<TodBloc>(context).add(TodDareChoosed());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return TodPlayScreen();
        }));
      },
    );
  }
}
