import 'dart:async';

import 'package:formvalidation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Validators{

  final _emailController = BehaviorSubject<String>();
  final _passController  = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform( validarEmail );
  Stream<String> get passStream => _passController.stream.transform( validarPassword );

  // Merge de los stream emailStream & passStream

  Stream<bool> get validFormStream => 
    Rx.combineLatest2(emailStream, passStream, (e, p) => true);

  //Insertar valores al stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;


  //Getter

  String get email => _emailController.value;

  String get password => _passController.value;


  dispose(){
    _emailController?.close();
    _passController?.close();
  }

}