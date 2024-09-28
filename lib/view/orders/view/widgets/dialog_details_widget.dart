import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/extension/context_extension.dart';
import 'package:pdv_windows/core/extension/double_extension.dart';
import 'package:pdv_windows/view/orders/view_model/orders_view_model.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';

class DialogDetailsWidget{
  static showTwoTablesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var viewModel = getIt<OrdersViewModel>();
        var order = viewModel.detailsOrder;

        return StatefulBuilder(
          builder: (context,setState) {

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            title: Text("Detalhes do pedido"),
              content: Container(
                width: context.dynamicWidth(0.9),
                height: context.dynamicHeight(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
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
                                  child: Text("Produto", textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("QNTD", textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Valor Unit", textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            ...order!.itens!.map((product) {
                              return TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      product.nome ??"",
                                      textAlign: TextAlign.center,
                                      style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      product.quantidade.toString() ??"",
                                      textAlign: TextAlign.center,
                                      style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      product.valorUnitario?.toMoney() ??"",
                                      textAlign: TextAlign.center,
                                      style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
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
                                  child: Text("Pagamento", textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Parcela", textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Valor", textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            ...order.pagamento!.map((product) {
                              return TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                children: <Widget>[
                                  itemTable(label: product.nome ??"",context: context),
                                  itemTable(label: product.parcela.toString() ??"",context: context),
                                  itemTable(label: product.valor?.toMoney() ??"",context: context),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: ()=> Navigator.pop(context), child: Text("Fechar"))
              ],
            );
          }
        );
      },
    );
  }
}

Widget itemTable({required String label, required BuildContext context}){
  bool mouseEnter = false;

  void _onEnter(PointerEvent details) {
      mouseEnter = true;
  }

  void _onExit(PointerEvent details) {
      mouseEnter = false;;
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
          label ??"",
          textAlign: TextAlign.center,
          style: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    ),
  );
}



