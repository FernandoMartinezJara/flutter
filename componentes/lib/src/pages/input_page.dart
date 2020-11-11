import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _nombre = '';
  String _email = '';
  String _password = '';
  String _fecha = '';
  TextEditingController _dateController = new TextEditingController();
  List<String> poderes = ['Volar', 'Rayos x', 'Velocidad', 'Fuerza' ];
  String poderSelected = 'Volar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical:20.0, 
          horizontal:10.0),
        children: <Widget>[
          _addNombreInput(),
          Divider(),
          _addEmailInput(),
          Divider(),
          _addPasswordInput(),
          Divider(),
          _addDateInput(),
          Divider(),
          _addDropdown(),
          Divider(),
          _addPersonTile()
        ],
      ),
    );
  }

  Widget _addNombreInput() {
    return TextField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(  
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text('Palabras: ${_nombre.length}'),
        hintText: 'Debe escribir nombre.',
        helperText: 'Sólo es el nombre',
        labelText: 'Nombre',
        icon: Icon(Icons.person),
        suffixIcon: Icon(Icons.accessibility),
      ),
      onChanged: (text){
        setState(() {
          _nombre = text;
        });
        
      },
    );
  }

  Widget _addEmailInput() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(  
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Debe escribir email.',
        helperText: 'Sólo es el email',
        labelText: 'Email',
        icon: Icon(Icons.email),
        suffixIcon: Icon(Icons.alternate_email),
      ),
      onChanged: (text){
        setState(() {
          _email = text;
        });
        
      },
    );
  }

  Widget _addPasswordInput() {
    return TextField(
      obscureText: true,      
      decoration: InputDecoration(  
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Debe escribir contraseña.',
        labelText: 'Contraseña',
        icon: Icon(Icons.vpn_key),
        suffixIcon: Icon(Icons.keyboard),
      ),
      onChanged: (text){
        setState(() {
          _password = text;
        });
        
      },
    );
  }

  Widget _addDateInput() {
    return TextField(            
      controller: _dateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(  
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Debe escribir Fecha.',
        labelText: 'Fecha',
        icon: Icon(Icons.calendar_today),
        suffixIcon: Icon(Icons.perm_contact_calendar),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
        
      },
    );
  }

  void _selectDate(BuildContext context) async {

    DateTime datePicked = await showDatePicker(
      context: context, 
      locale: Locale('es', 'ES'),
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(1900), 
      lastDate: new DateTime.now());

    if(datePicked != null){
      setState(() {
        _fecha = datePicked.toString();
        _dateController.text = _fecha;
      });
    }

  }

  List<DropdownMenuItem<String>> getMenutItems()
  {
    List<DropdownMenuItem<String>> _items = new List();

    poderes.forEach((poder) {
     
      _items.add(DropdownMenuItem(
        child: Text(poder),
        value: poder));  
    });

    return _items;
  }

  _addDropdown() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(child:
          DropdownButton(
            value: poderSelected,
            items: getMenutItems(), 
            onChanged: (value){
              setState(() {
                poderSelected = value;
              });
            })
        )
      ],
    );
  
  }

  Widget _addPersonTile() {

    return ListTile(
      title: Text('Nombre: $_nombre'),
      subtitle: Text('Email: $_email'),
      trailing: Text(poderSelected),
    );

  }

}