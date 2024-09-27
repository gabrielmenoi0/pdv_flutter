import 'package:json_annotation/json_annotation.dart';
import 'package:pdv_windows/core/init/model/local_entity.dart';

part 'orders_model.g.dart';

@JsonSerializable()
class OrdersModel implements LocalEntity {
  String? id;
  int? numero;
  DateTime? dataCriacao;
  DateTime? dataAlteracao;
  String? status;
  double? desconto;
  double? frete;
  double? subTotal;
  double? valorTotal;
  Cliente? cliente;
  EnderecoEntrega? enderecoEntrega;
  List<Item>? itens;
  List<Pagamento>? pagamento;

  OrdersModel({
    this.id,
    this.numero,
    this.dataCriacao,
    this.dataAlteracao,
    this.status,
    this.desconto,
    this.frete,
    this.subTotal,
    this.valorTotal,
    this.cliente,
    this.enderecoEntrega,
    this.itens,
    this.pagamento,
  });

  bool get isCancel => status?.toUpperCase() == "CANCELADO";

  factory OrdersModel.fromJson(Map<String, dynamic> json) => _$OrdersModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);

  @override
  String get key => "orders";
}

@JsonSerializable()
class Cliente {
  String? id;
  String? cnpj;
  String? cpf;
  String? nome;
  String? razaoSocial;
  String? email;
  DateTime? dataNascimento;

  Cliente({
    this.id,
    this.cnpj,
    this.cpf,
    this.nome,
    this.razaoSocial,
    this.email,
    this.dataNascimento,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => _$ClienteFromJson(json);
  Map<String, dynamic> toJson() => _$ClienteToJson(this);
}

@JsonSerializable()
class EnderecoEntrega {
  String? id;
  String? endereco;
  String? numero;
  String? cep;
  String? bairro;
  String? cidade;
  String? estado;
  String? complemento;
  String? referencia;

  EnderecoEntrega({
    this.id,
    this.endereco,
    this.numero,
    this.cep,
    this.bairro,
    this.cidade,
    this.estado,
    this.complemento,
    this.referencia,
  });

  factory EnderecoEntrega.fromJson(Map<String, dynamic> json) => _$EnderecoEntregaFromJson(json);
  Map<String, dynamic> toJson() => _$EnderecoEntregaToJson(this);
}

@JsonSerializable()
class Item {
  String? id;
  String? idProduto;
  String? nome;
  int? quantidade;
  double? valorUnitario;

  Item({
    this.id,
    this.idProduto,
    this.nome,
    this.quantidade,
    this.valorUnitario,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Pagamento {
  String? id;
  int? parcela;
  double? valor;
  String? codigo;
  String? nome;

  Pagamento({
    this.id,
    this.parcela,
    this.valor,
    this.codigo,
    this.nome,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) => _$PagamentoFromJson(json);
  Map<String, dynamic> toJson() => _$PagamentoToJson(this);
}
