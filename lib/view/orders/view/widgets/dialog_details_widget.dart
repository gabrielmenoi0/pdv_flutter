import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/export/base_export.dart';
import 'package:pdv_windows/core/extension/context_extension.dart';
import 'package:pdv_windows/core/extension/double_extension.dart';
import 'package:pdv_windows/core/init/lang/locale_keys.g.dart';
import 'package:pdv_windows/view/orders/view_model/orders_view_model.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';

class DialogDetailsWidget {
  static showTwoTablesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var viewModel = getIt<OrdersViewModel>();
        var order = viewModel.detailsOrder;

        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: Text(LocaleKeys.order_details.tr()), // Usando chave de localização
                content: Container(
                  width: context.dynamicWidth(0.9),
                  height: context.dynamicHeight(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Observer(
                              builder: (context) {
                                if (order!.itens!.isEmpty) {
                                  return Center(child: Text(LocaleKeys.no_products_found.tr(), style: context.general.textTheme.bodyMedium,));
                                }
                                return Table(
                                  border: TableBorder.all(),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: IntrinsicColumnWidth(),
                                    1: FlexColumnWidth(),
                                    2: FlexColumnWidth(),
                                  },
                                  defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
                                  children: [
                                    TableRow(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(LocaleKeys.product.tr(), textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(LocaleKeys.quantity.tr(), textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(LocaleKeys.unit_price.tr(), textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                    ...order.itens!.map((product) {
                                      return TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              product.nome ?? "",
                                              textAlign: TextAlign.center,
                                              style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              product.quantidade.toString() ?? "",
                                              textAlign: TextAlign.center,
                                              style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              product.valorUnitario?.toMoney() ?? "",
                                              textAlign: TextAlign.center,
                                              style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                );
                              }
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Observer(
                              builder: (context) {
                                if (order!.pagamento!.isEmpty) {
                                  return Center(child: Text(LocaleKeys.no_payments_found.tr(), style: context.general.textTheme.bodyMedium,));
                                }

                                return Table(
                                  border: TableBorder.all(),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: IntrinsicColumnWidth(),
                                    1: FlexColumnWidth(),
                                    2: FlexColumnWidth(),
                                  },
                                  defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
                                  children: [
                                    TableRow(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(LocaleKeys.payment.tr(), textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(LocaleKeys.installment.tr(), textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(LocaleKeys.value.tr(), textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                    ...order.pagamento!.map((payment) {
                                      return TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: <Widget>[
                                          itemTable(label: payment.nome ?? "", context: context),
                                          itemTable(label: payment.parcela.toString() ?? "", context: context),
                                          itemTable(label: payment.valor?.toMoney() ?? "", context: context),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text(LocaleKeys.close.tr())) // Usando chave de localização
                ],
              );
            }
        );
      },
    );
  }
}

Widget itemTable({required String label, required BuildContext context}) {
  bool mouseEnter = false;

  void _onEnter(PointerEvent details) {
    mouseEnter = true;
  }

  void _onExit(PointerEvent details) {
    mouseEnter = false;
  }

  return MouseRegion(
    onEnter: _onEnter,
    onExit: _onExit,
    cursor: MouseCursor.defer,
    child: Container(
      color: mouseEnter ? context.general.colorScheme.secondary : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          label ?? "",
          textAlign: TextAlign.center,
          style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    ),
  );
}
