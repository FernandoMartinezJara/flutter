import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/producto_bloc.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
// import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: _getProductos(productosBloc),
        floatingActionButton: _addFloatingActionButton(context));
  }

  Widget _getProductos(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) =>
                  crearItem(context, productosBloc, productos[i]));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // return FutureBuilder(
    //     builder: (BuildContext context,
    //         AsyncSnapshot<List<ProductoModel>> snapshot) {
    //       if (snapshot.hasData) {
    //         final productos = snapshot.data;
    //         return ListView.builder(
    //             itemCount: productos.length,
    //             itemBuilder: (context, i) => crearItem(context, productos[i]));
    //       } else {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     },
    //     future: productosProvider.cargarProductos());
  }

  Widget crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          // productosProvider.borrarProducto(producto.id);
          productosBloc.borrarProducto(producto.id);
        },
        child: Card(
          child: Column(
            children: [
              (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.pmg'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      height: 300,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      width: double.infinity,
                    ),
              ListTile(
                  title: Text('${producto.titulo} - ${producto.valor}'),
                  subtitle: Text('${producto.id}'),
                  onTap: () => Navigator.pushNamed(context, 'producto',
                              arguments: producto)
                          .then((value) {
                        setState(() {});
                      }))
            ],
          ),
        ));
  }

  Widget _addFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {
              setState(() {});
            }));
    // onPressed: () => Navigator.pushNamed(context, 'producto'));
  }
}
