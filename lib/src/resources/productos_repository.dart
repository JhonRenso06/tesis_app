import 'package:mr_yupi/src/api/productos_api.dart';
import 'package:mr_yupi/src/database/database.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/favorito.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';

class ProductosRepository {
  ProductosAPI _productosAPI;
  FlutterDatabase _database;

  ProductosRepository() {
    _productosAPI = ProductosAPI();
  }

  _initDatabase() async {
    if (_database == null) {
      _database =
          await $FloorFlutterDatabase.databaseBuilder('yupi_chela.db').build();
    }
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> initialLoad(
      Establecimiento establecimiento) async {
    var result = await _productosAPI.getProductos(establecimiento);
    await _initDatabase();
    if (result.hasData) {
      for (var element in result.data.items) {
        num id = element.producto.id;
        Favorito favorito = await _database.favoritoDao.findFavoritoById(id);
        if (favorito != null) {
          element.producto.favorito = true;
        } else {
          element.producto.favorito = false;
        }
      }
    }
    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> loadMore(
      Establecimiento establecimiento, num currentPage) async {
    await _initDatabase();
    var result = await _productosAPI.getProductos(establecimiento,
        page: currentPage + 1);
    if (result.hasData) {
      for (var element in result.data.items) {
        num id = element.producto.id;
        Favorito favorito = await _database.favoritoDao.findFavoritoById(id);
        if (favorito != null) {
          element.producto.favorito = true;
        } else {
          element.producto.favorito = false;
        }
      }
    }

    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> initialLoadFavoritos(
      Establecimiento establecimiento) async {
    await _initDatabase();
    var favoritos = await _database.favoritoDao.findFavoritos();
    List<num> ids = [];
    favoritos.forEach((element) {
      ids.add(element.id);
    });
    if (ids.length == 0) {
      return APIResponse<Paginate<ProductoEstablecimiento>>(
        data: Paginate.empty(),
      );
    }
    var result = await _productosAPI.getFavoritos(establecimiento, ids);
    result.data.items.forEach((element) async {
      element.producto.favorito = true;
    });
    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> loadMoreFavoritos(
      Establecimiento establecimiento, num currentPage) async {
    await _initDatabase();
    var favoritos = await _database.favoritoDao.findFavoritos();
    List<num> ids = [];
    favoritos.forEach((element) {
      ids.add(element.id);
    });
    var result = await _productosAPI.getFavoritos(establecimiento, ids,
        page: currentPage + 1);
    result.data.items.forEach((element) async {
      element.producto.favorito = true;
    });
    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> initialLoadCategoria(
      Establecimiento establecimiento, Categoria categoria) async {
    var result = await _productosAPI.getCategory(establecimiento, categoria);
    await _initDatabase();
    if (result.hasData) {
      for (var element in result.data.items) {
        num id = element.producto.id;
        Favorito favorito = await _database.favoritoDao.findFavoritoById(id);
        if (favorito != null) {
          element.producto.favorito = true;
        } else {
          element.producto.favorito = false;
        }
      }
    }
    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> loadMoreCategoria(
      Establecimiento establecimiento,
      Categoria categoria,
      num currentPage) async {
    await _initDatabase();
    var result = await _productosAPI.getCategory(establecimiento, categoria,
        page: currentPage + 1);
    if (result.hasData) {
      for (var element in result.data.items) {
        num id = element.producto.id;
        Favorito favorito = await _database.favoritoDao.findFavoritoById(id);
        if (favorito != null) {
          element.producto.favorito = true;
        } else {
          element.producto.favorito = false;
        }
      }
    }

    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> initialLoadSearch(
      Establecimiento establecimiento, String search) async {
    var result = await _productosAPI.getSearch(establecimiento, search);
    await _initDatabase();
    if (result.hasData) {
      for (var element in result.data.items) {
        num id = element.producto.id;
        Favorito favorito = await _database.favoritoDao.findFavoritoById(id);
        if (favorito != null) {
          element.producto.favorito = true;
        } else {
          element.producto.favorito = false;
        }
      }
    }
    return result;
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> loadMoreSearch(
      Establecimiento establecimiento, String search, num currentPage) async {
    await _initDatabase();
    var result = await _productosAPI.getSearch(establecimiento, search,
        page: currentPage + 1);
    if (result.hasData) {
      for (var element in result.data.items) {
        num id = element.producto.id;
        Favorito favorito = await _database.favoritoDao.findFavoritoById(id);
        if (favorito != null) {
          element.producto.favorito = true;
        } else {
          element.producto.favorito = false;
        }
      }
    }

    return result;
  }

  Future<void> addFavorite(
      ProductoEstablecimiento productoEstablecimiento) async {
    await _initDatabase();
    productoEstablecimiento.producto.favorito = true;
    Favorito favorito = Favorito(productoEstablecimiento.producto.id);
    await this._database.favoritoDao.insertFavorito(favorito);
  }

  Future<void> removeFavorite(
      ProductoEstablecimiento productoEstablecimiento) async {
    await _initDatabase();
    productoEstablecimiento.producto.favorito = false;
    await this
        ._database
        .favoritoDao
        .deleteFavorito(productoEstablecimiento.producto.id);
  }
}
