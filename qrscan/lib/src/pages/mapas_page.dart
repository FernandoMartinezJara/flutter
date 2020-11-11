import 'package:flutter/material.dart';
import 'package:qrscan/src/bloc/scans_bloc.dart';
import 'package:qrscan/src/models/scan_model.dart';
import 'package:qrscan/src/utils/utils.dart';

class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getAllScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){

        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if(scans.length == 0){
          return Center(child: Text('No hay información'));
        }
        else{

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete_forever, color: Colors.white,),
              ),
              onDismissed: (direction) => scansBloc.deleteScan(scans[i].id) , 
              child: ListTile(
                leading: Icon(Icons.map, color: Theme.of(context).primaryColor,), 
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                onTap: () => openScan(context, scans[i])
                )
              )
            );
        }

      },
    );
  }
}