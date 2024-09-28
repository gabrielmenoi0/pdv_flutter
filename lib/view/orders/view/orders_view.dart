import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/core/extension/date_extension.dart';
import 'package:pdv_windows/core/extension/double_extension.dart';
import 'package:pdv_windows/view/_product/_widgets/loading_widget.dart';
import 'package:pdv_windows/view/orders/model/orders_model.dart';
import 'package:pdv_windows/view/orders/view_model/orders_view_model.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OrdersViewModel>(
      viewModel: getIt<OrdersViewModel>(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: buildScaffoldBody,
    );
  }

  Widget buildScaffoldBody(BuildContext context, OrdersViewModel viewModel) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Observer(builder: (context) {
                if (viewModel.isLoading) {
                  return Center(
                    child: LoadingWidget(),
                  );
                }
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            FractionallySizedBox(
                                child: tableOrders(context: context)),
                            SizedBox(width: context.dynamicWidth(0.005)),
                            Expanded(
                                child: FractionallySizedBox(child: detailOrders(context: context)))
                          ],
                        ),
                      ),
                      color: context.colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ));
              }),
            )
          ],
        ),
      ),
      floatingActionButton: Observer(
        builder: (context) {
          return Visibility(
            visible: !viewModel.isLoading,
            child: FloatingActionButton(
                onPressed: () => viewModel.fetchOrdersAPI(),
                tooltip: "Sincronizar",
                backgroundColor: context.colorScheme.secondary,
                child: Icon(Icons.refresh_outlined)),
          );
        }
      ),
    );
  }

  Widget tableOrders({required BuildContext context}) {
    var viewModel = getIt<OrdersViewModel>();

    return SizedBox(
      width: context.dynamicWidth(0.7),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: TextFormField(
                controller: viewModel.controller,
                onFieldSubmitted: (v) => viewModel.searchOrders(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffixIcon: SizedBox(
                    width: context.dynamicWidth(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: FilledButton.icon(
                        onPressed: () => viewModel.searchOrders(),
                        label: Text("Pesquisar"),
                        iconAlignment: IconAlignment.end,
                        icon: Icon(Icons.search),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              context.colorScheme.secondary),
                        ),
                      ),
                    ),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: context.textTheme.bodyMedium,
                  hintText: 'Busque pelo nome do Cliente',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: context.emptySizedHeightBoxLow3x,
          ),
          Observer(
            builder: (context) {
              return SliverToBoxAdapter(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: IntrinsicColumnWidth(),
                    4: IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
                  children: [
                    TableRow(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Número", textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Data", textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Cliente", textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Status", textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Valor Total", textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    ...viewModel.ordersList.map((order) {
                      return TableRow(
                        decoration: BoxDecoration(
                          color: viewModel.detailsOrder?.id == order.id!
                              ? context.colorScheme.secondary
                              : Colors.white,
                        ),
                        children: <Widget>[
                          itemTableRow(context: context, label: order.numero.toString(), order: order),
                          itemTableRow(context: context, label: order.dataCriacao?.toFormattedTable ?? "", order: order),
                          itemTableRow(context: context, label: order.cliente?.nome ?? "", order: order),
                          itemTableRow(context: context, label: order.status ?? "", order: order),
                          itemTableRow(context: context, label: order.valorTotal?.toMoney() ?? "", order: order),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemTableRow({required OrdersModel order, required String label,required BuildContext context}) {
    var viewModel = getIt<OrdersViewModel>();
    bool isCancel = order.isCancel;

    return GestureDetector(
      onTap: () => viewModel.setDetailsOrder(order),
      onDoubleTap: () => viewModel.openDetails(order),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isCancel ? context.colorScheme.error : context.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  Widget detailOrders({required BuildContext context}) {
    var viewModel = getIt<OrdersViewModel>();
    var order = viewModel.detailsOrder;
    return Container(
      width: context.dynamicWidth(0.2),
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: context.dynamicWidth(0.2),
                decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                child: Column(
                  children: [
                    Container(
                      height: context.dynamicHeight(0.06),
                      width: context.dynamicWidth(0.5),
                      color: context.colorScheme.secondary,
                      child: Center(child: Text("Detalhes do pedido")),
                    ),
                    Divider(height: 1),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Observer(
                builder: (context) {
                  if (viewModel.detailsOrder == null) {
                    return Center(child: Text("Nenhum pedido selecionado"));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informações do Pedido",
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: context.colorScheme.primary),
                      ),
                      context.emptySizedHeightBoxLow,
                      Text("Número: ${order?.numero.toString()}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Data Criação: ${order?.dataCriacao?.toFormatted}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Data Alterção: ${order?.dataAlteracao?.toFormatted}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Status: ${order?.status ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Descontos: ${order?.desconto?.toMoney() ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Frete: ${order?.frete?.toMoney() ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("SubTotal: ${order?.subTotal?.toMoney() ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Total: ${order?.valorTotal?.toMoney() ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      context.emptySizedHeightBoxNormal,
                      Text("Dados do Cliente", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 20, color: context.colorScheme.primary)),
                      context.emptySizedHeightBoxLow,
                      Text("Cliente: ${order?.cliente?.nome ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Documento: ${order?.cliente?.cpf ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Data Nascimento: ${order?.cliente?.dataNascimento?.toFormatted ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Email: ${order?.cliente?.email ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      context.emptySizedHeightBoxNormal,
                      Text("Local da entrega", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 20, color: context.colorScheme.primary)),
                      Text("Endereço: ${order?.enderecoEntrega?.endereco ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Número: ${order?.enderecoEntrega?.numero ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("CEP: ${order?.enderecoEntrega?.cep ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Bairro: ${order?.enderecoEntrega?.bairro ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Cidade: ${order?.enderecoEntrega?.cidade ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Estado: ${order?.enderecoEntrega?.estado ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Complemento: ${order?.enderecoEntrega?.complemento ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("Referência: ${order?.enderecoEntrega?.referencia ?? ""}", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

