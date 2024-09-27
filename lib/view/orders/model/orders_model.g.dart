// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      id: json['id'] as String?,
      numero: (json['numero'] as num?)?.toInt(),
      dataCriacao: json['dataCriacao'] == null
          ? null
          : DateTime.parse(json['dataCriacao'] as String),
      dataAlteracao: json['dataAlteracao'] == null
          ? null
          : DateTime.parse(json['dataAlteracao'] as String),
      status: json['status'] as String?,
      desconto: (json['desconto'] as num?)?.toDouble(),
      frete: (json['frete'] as num?)?.toDouble(),
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      valorTotal: (json['valorTotal'] as num?)?.toDouble(),
      cliente: json['cliente'] == null
          ? null
          : Cliente.fromJson(json['cliente'] as Map<String, dynamic>),
      enderecoEntrega: json['enderecoEntrega'] == null
          ? null
          : EnderecoEntrega.fromJson(
              json['enderecoEntrega'] as Map<String, dynamic>),
      itens: (json['itens'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagamento: (json['pagamento'] as List<dynamic>?)
          ?.map((e) => Pagamento.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numero': instance.numero,
      'dataCriacao': instance.dataCriacao?.toIso8601String(),
      'dataAlteracao': instance.dataAlteracao?.toIso8601String(),
      'status': instance.status,
      'desconto': instance.desconto,
      'frete': instance.frete,
      'subTotal': instance.subTotal,
      'valorTotal': instance.valorTotal,
      'cliente': instance.cliente,
      'enderecoEntrega': instance.enderecoEntrega,
      'itens': instance.itens,
      'pagamento': instance.pagamento,
    };

Cliente _$ClienteFromJson(Map<String, dynamic> json) => Cliente(
      id: json['id'] as String?,
      cnpj: json['cnpj'] as String?,
      cpf: json['cpf'] as String?,
      nome: json['nome'] as String?,
      razaoSocial: json['razaoSocial'] as String?,
      email: json['email'] as String?,
      dataNascimento: json['dataNascimento'] == null
          ? null
          : DateTime.parse(json['dataNascimento'] as String),
    );

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
      'id': instance.id,
      'cnpj': instance.cnpj,
      'cpf': instance.cpf,
      'nome': instance.nome,
      'razaoSocial': instance.razaoSocial,
      'email': instance.email,
      'dataNascimento': instance.dataNascimento?.toIso8601String(),
    };

EnderecoEntrega _$EnderecoEntregaFromJson(Map<String, dynamic> json) =>
    EnderecoEntrega(
      id: json['id'] as String?,
      endereco: json['endereco'] as String?,
      numero: json['numero'] as String?,
      cep: json['cep'] as String?,
      bairro: json['bairro'] as String?,
      cidade: json['cidade'] as String?,
      estado: json['estado'] as String?,
      complemento: json['complemento'] as String?,
      referencia: json['referencia'] as String?,
    );

Map<String, dynamic> _$EnderecoEntregaToJson(EnderecoEntrega instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endereco': instance.endereco,
      'numero': instance.numero,
      'cep': instance.cep,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'estado': instance.estado,
      'complemento': instance.complemento,
      'referencia': instance.referencia,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String?,
      idProduto: json['idProduto'] as String?,
      nome: json['nome'] as String?,
      quantidade: (json['quantidade'] as num?)?.toInt(),
      valorUnitario: (json['valorUnitario'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'idProduto': instance.idProduto,
      'nome': instance.nome,
      'quantidade': instance.quantidade,
      'valorUnitario': instance.valorUnitario,
    };

Pagamento _$PagamentoFromJson(Map<String, dynamic> json) => Pagamento(
      id: json['id'] as String?,
      parcela: (json['parcela'] as num?)?.toInt(),
      valor: (json['valor'] as num?)?.toDouble(),
      codigo: json['codigo'] as String?,
      nome: json['nome'] as String?,
    );

Map<String, dynamic> _$PagamentoToJson(Pagamento instance) => <String, dynamic>{
      'id': instance.id,
      'parcela': instance.parcela,
      'valor': instance.valor,
      'codigo': instance.codigo,
      'nome': instance.nome,
    };
