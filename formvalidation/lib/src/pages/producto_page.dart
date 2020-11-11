import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/producto_bloc.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
// import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  // ProductosProvider productosProvider = new ProductosProvider();
  bool _isSaving = false;
  File foto;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodArg = ModalRoute.of(context).settings.arguments;

    if (prodArg != null) {
      producto = prodArg;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _tomarFoto)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _addNombre(),
                  _addPrecio(),
                  _addDisponible(),
                  _addButton()
                ],
              )),
        ),
      ),
    );
  }

  Widget _addNombre() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Producto'),
      initialValue: producto.titulo,
      onSaved: (newValue) => producto.titulo = newValue,
      validator: (value) {
        if (value.length < 3) {
          return 'Debes ingresar nombre producto';
        }
        return null;
      },
    );
  }

  Widget _addPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (newValue) => producto.valor = double.parse(newValue),
      validator: (value) {
        if (!utils.isNumeric(value)) {
          return 'debes ingresar precio válido';
        }

        return null;
      },
    );
  }

  Widget _addDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      activeColor: Colors.deepPurple,
      title: Text('Disponible'),
      onChanged: (value) {
        setState(() {
          producto.disponible = value;
        });
      },
    );
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gig'),
          height: 300,
          fit: BoxFit.contain,
          image: NetworkImage(producto.fotoUrl));
    } else {
      if (foto != null) {
        return Image.file(
          File(foto.path),
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  Future _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        producto.fotoUrl = null;
        foto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _addButton() {
    return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        onPressed: (_isSaving) ? null : _submit);
  }

  _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _isSaving = true;
    });

    if (foto != null) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }

    if (producto.id == null) {
      productosBloc.cargarProducto(producto);
    } else {
      productosBloc.editarProducto(producto);
    }

    showSnackBar('Registro guardado');

    Navigator.pop(context);
  }

  void showSnackBar(String mensaje) {
    final snackBar = SnackBar(
        content: Text(mensaje), duration: Duration(milliseconds: 1500));

    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
