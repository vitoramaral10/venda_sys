import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';

List<Bloc> blocs = [
  Bloc((i) => LoginBloc()),
  Bloc((i) => ProdutosBloc()),
  Bloc((i) => UnidadesMedidaBloc()),
];