import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/core/export/base_export.dart';
import 'package:pdv_windows/core/extension/context_extension.dart';
import 'package:pdv_windows/core/extension/date_extension.dart';
import 'package:pdv_windows/core/extension/double_extension.dart';
import 'package:pdv_windows/core/init/lang/locale_keys.g.dart';
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
      backgroundColor: context.general.colorScheme.secondary,
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
                            FractionallySizedBox(child: tableOrders(context: context)),
                            SizedBox(width: context.dynamicWidth(0.005)),
                            Expanded(child: FractionallySizedBox(child: detailOrders(context: context)))
                          ],
                        ),
                      ),
                      color: context.general.colorScheme.onSurface,
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
                  tooltip: LocaleKeys.sync_tooltip.tr(),
                  backgroundColor: context.general.colorScheme.secondary,
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
                        label: Text(LocaleKeys.search.tr(), style: context.general.textTheme.bodyMedium,),
                        iconAlignment: IconAlignment.end,
                        icon: Icon(Icons.search, color: context.general.colorScheme.onPrimaryContainer,),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              context.general.colorScheme.secondary),
                        ),
                      ),
                    ),
                  ),
                  hintStyle: context.general.textTheme.bodyMedium,
                  hintText: LocaleKeys.search_hint.tr(),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: context.sized.emptySizedHeightBoxLow3x,
          ),
          Observer(
            builder: (context) {

              if (viewModel.ordersList.isEmpty) {
                return SliverFillRemaining(child: Center(child: Text(LocaleKeys.no_orders_found_view.tr(), style: context.general.textTheme.bodyMedium,)));
              }

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
                          child: Text(LocaleKeys.order_number.tr(), textAlign: TextAlign.center, style: context.general.textTheme.bodyMedium,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(LocaleKeys.order_date.tr(), textAlign: TextAlign.center, style: context.general.textTheme.bodyMedium,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(LocaleKeys.client_name.tr(), textAlign: TextAlign.center, style: context.general.textTheme.bodyMedium,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(LocaleKeys.status.tr(), textAlign: TextAlign.center, style: context.general.textTheme.bodyMedium,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(LocaleKeys.total_value.tr(), textAlign: TextAlign.center, style: context.general.textTheme.bodyMedium,),
                        ),
                      ],
                    ),
                    ...viewModel.ordersList.map((order) {
                      return TableRow(
                        decoration: BoxDecoration(
                          color: viewModel.detailsOrder?.id == order.id!
                              ? context.general.colorScheme.secondary
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

  Widget itemTableRow({required OrdersModel order, required String label, required BuildContext context}) {
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
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: isCancel ? context.general.colorScheme.error : context.general.colorScheme.onPrimaryContainer,
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
                      color: context.general.colorScheme.secondary,
                      child: Center(child: Text(LocaleKeys.order_details.tr(), style: context.general.textTheme.bodyMedium,)),
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
                    return Center(child: Text(LocaleKeys.no_order_selected.tr(), style: context.general.textTheme.bodyMedium,));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.order_information.tr(),
                        style: context.general.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: context.general.colorScheme.primary),
                      ),
                      context.sized.emptySizedHeightBoxLow,
                      Text("${LocaleKeys.order_number.tr()}: ${order?.numero.toString()}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.order_date.tr()}: ${order?.dataCriacao?.toFormatted}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.order_date.tr()}: ${order?.dataAlteracao?.toFormatted}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.status.tr()}: ${order?.status ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.discount.tr()}: ${order?.desconto?.toMoney() ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.shipping.tr()}: ${order?.frete?.toMoney() ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.subtotal.tr()}: ${order?.subTotal?.toMoney() ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.total.tr()}: ${order?.valorTotal?.toMoney() ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      context.sized.emptySizedHeightBoxNormal,
                      Text(LocaleKeys.client_data.tr(), style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 20, color: context.general.colorScheme.primary)),
                      context.sized.emptySizedHeightBoxLow,
                      Text("${LocaleKeys.client.tr()}: ${order?.cliente?.nome ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.document.tr()}: ${order?.cliente?.cpf ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.birth_date.tr()}: ${order?.cliente?.dataNascimento?.toFormatted ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.email.tr()}: ${order?.cliente?.email ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      context.sized.emptySizedHeightBoxNormal,
                      Text(LocaleKeys.delivery_location.tr(), style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 20, color: context.general.colorScheme.primary)),
                      Text("${LocaleKeys.address.tr()}: ${order?.enderecoEntrega?.endereco ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.number.tr()}: ${order?.enderecoEntrega?.numero ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.zip_code.tr()}: ${order?.enderecoEntrega?.cep ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.neighborhood.tr()}: ${order?.enderecoEntrega?.bairro ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.city.tr()}: ${order?.enderecoEntrega?.cidade ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.state.tr()}: ${order?.enderecoEntrega?.estado ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.complement.tr()}: ${order?.enderecoEntrega?.complemento ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text("${LocaleKeys.reference.tr()}: ${order?.enderecoEntrega?.referencia ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
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
