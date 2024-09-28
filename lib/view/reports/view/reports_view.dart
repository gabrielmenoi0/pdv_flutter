import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/core/extension/context_extension.dart';
import 'package:pdv_windows/core/extension/double_extension.dart';
import 'package:pdv_windows/view/_product/_widgets/loading_widget.dart';
import 'package:pdv_windows/view/reports/model/chart_data_model.dart';
import 'package:pdv_windows/view/reports/model/filter_report_model.dart';
import 'package:pdv_windows/view/reports/model/legend_chart_model.dart';
import 'package:pdv_windows/view/reports/view_model/reports_view_model.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportsView extends StatelessWidget {
  ReportsView({Key? key}) : super(key: key);

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ReportsViewModel>(
      viewModel: getIt<ReportsViewModel>(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: buildScaffoldBody,
    );
  }

  Widget buildScaffoldBody(BuildContext context, ReportsViewModel viewModel) {
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
                return Observer(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: context.general.colorScheme.surface,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  cardReports(
                                      legendList: viewModel.legendProduct,
                                      context: context,
                                      text: "Top Produtos",
                                      subText: "Produtos mais vendidos",
                                      chart: SfCircularChart(
                                      tooltipBehavior: viewModel.tooltip,
                                      series: <CircularSeries>[
                                        PieSeries<ChartDataModel, String>(
                                            dataSource: viewModel.productChart,
                                            pointColorMapper:(ChartDataModel data, _) => data.color,
                                            xValueMapper: (ChartDataModel data, _) => data.x,
                                            yValueMapper: (ChartDataModel data, _) => data.y
                                        )
                                      ]
                                  )),
                                  cardReports(
                                      legendList: viewModel.legendSales,
                                      context: context,
                                      text: "Top Vendas",
                                      subText: "Clientes com maior valor em compras",
                                      chart: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      tooltipBehavior: viewModel.tooltip,
                                      series: <CartesianSeries<ChartDataModel, String>>[
                                        ColumnSeries<ChartDataModel, String>(
                                            dataSource: viewModel.salesChart,
                                            xValueMapper: (ChartDataModel data, _) => data.x,
                                            yValueMapper: (ChartDataModel data, _) => data.y,
                                            pointColorMapper: (ChartDataModel data, _) => viewModel.getColorForCustomer(data.x),
                                        )
                                      ])),
                                  cardReports(
                                      legendList: viewModel.legendStatus,
                                      context: context,
                                      text: "Pedidos",
                                      subText: "Pedidos aprovados e cancelados",
                                      chart: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                                      tooltipBehavior: viewModel.tooltip,
                                      series: <CartesianSeries<ChartDataModel, String>>[
                                        BarSeries<ChartDataModel, String>(
                                            dataSource: viewModel.ordersChartView,
                                            xValueMapper: (ChartDataModel data, _) => data.x,
                                            yValueMapper: (ChartDataModel data, _) => data.y,
                                            pointColorMapper: (ChartDataModel data, _) => viewModel.getColorForStatus(data.x),                                            // color: getColorForStatus((ChartDataModel data, _) => data.x as String),
                                        )])),
                                ],
                              ),
                              context.sized.emptySizedHeightBoxLow,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: context.general.colorScheme.onPrimaryContainer, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: DropdownButton<FilterReportModel>(
                                          value: viewModel.filterOption,
                                          items: viewModel.optionFilter.map((FilterReportModel option) {
                                            return DropdownMenuItem<FilterReportModel>(
                                              value: option,
                                              child: Text(option.label ?? ""),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              viewModel.setFilterTable(value);
                                            }
                                          },
                                          isExpanded: true,
                                          underline: SizedBox(),
                                        ),
                                      )
                                    )

                                  ),
                                  context.sized.emptySizedWidthBoxLow,
                                  Expanded(
                                    child: SizedBox(
                                      height: context.dynamicHeight(0.055),
                                      child: FilledButton.icon(
                                        onPressed: () => viewModel.export(),
                                        label: Text("Exportar"),
                                        icon: Icon(Icons.description),
                                        iconAlignment: IconAlignment.end,
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll(
                                              context.general.colorScheme.secondary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              context.sized.emptySizedHeightBoxLow,
                              Expanded(
                                child: Scrollbar(
                                  controller: scrollController,
                                  trackVisibility: true,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                  child: Observer(
                                    builder: (context) {
                                      if(viewModel.filterOption?.option =="1"){
                                      return tableWidget(
                                        columnWidths: <int, TableColumnWidth>{
                                          0: FlexColumnWidth(),
                                          1: FlexColumnWidth(),
                                          2: FlexColumnWidth(),
                                        },
                                        headerWidgets: [
                                          Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Produto", textAlign: TextAlign.center),
                                        ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Quantidade", textAlign: TextAlign.center),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Valor Médio", textAlign: TextAlign.center),
                                          ),
                                        ],
                                        rowWidgets: viewModel.filterProductList.map((product) {
                                          return [
                                            itemTableRow(context: context, label: product.nome ??""),
                                            itemTableRow(context: context, label: product.quantidade.toString()),
                                            itemTableRow(context: context, label: product.valorUnitario?.toMoney() ?? ""),
                                          ];
                                        }).toList(),
                                      );
                                    }
                                      if(viewModel.filterOption?.option =="2"){
                                        return tableWidget(
                                          columnWidths: <int, TableColumnWidth>{
                                            0: FlexColumnWidth(),
                                            1: FlexColumnWidth(),
                                            2: FlexColumnWidth(),
                                          },
                                          headerWidgets: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Parcela", textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Forma", textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Valor", textAlign: TextAlign.center),
                                            ),
                                          ],
                                          rowWidgets: viewModel.filterPaymentList.map((payment) {
                                            return [
                                              itemTableRow(context: context, label: payment.parcela.toString()),
                                              itemTableRow(context: context, label: payment.nome ??""),
                                              itemTableRow(context: context, label: payment.valor?.toMoney() ?? ""),
                                            ];
                                          }).toList(),
                                        );
                                      }
                                      if(viewModel.filterOption?.option =="3"){
                                        return tableWidget(
                                          columnWidths: <int, TableColumnWidth>{
                                            0: FlexColumnWidth(),
                                            1: FlexColumnWidth(),
                                            2: FlexColumnWidth(),
                                          },
                                          headerWidgets: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Cidade", textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Quantidade", textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Valor", textAlign: TextAlign.center),
                                            ),
                                          ],
                                          rowWidgets: viewModel.filterCityList.map((address) {
                                            return [
                                              itemTableRow(context: context, label: address.cidade ??""),
                                              itemTableRow(context: context, label: address.qtd.toString()),
                                              itemTableRow(context: context, label: address.value.toMoney() ?? ""),
                                            ];
                                          }).toList(),
                                        );
                                      }
                                      if(viewModel.filterOption?.option =="4"){
                                        return tableWidget(
                                          columnWidths: <int, TableColumnWidth>{
                                            0: FlexColumnWidth(),
                                            1: IntrinsicColumnWidth(),
                                            2: IntrinsicColumnWidth(),
                                          },
                                          headerWidgets: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Faixa etária", textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Quantidade", textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Valor", textAlign: TextAlign.center),
                                            ),
                                          ],
                                          rowWidgets: viewModel.filterAgeGroupList.map((address) {
                                            return [
                                              itemTableRow(context: context, label: address.faixaEtaria ??""),
                                              itemTableRow(context: context, label: address.qtd.toString()),
                                              itemTableRow(context: context, label: address.valorTotal.toMoney() ?? ""),
                                            ];
                                          }).toList(),
                                        );
                                      }
                                      return SizedBox();
                                    }
                                  ),
                                ),
                              ),)
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget itemTableRow({required String label,required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: context.general.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  tableWidget({required List<Widget> headerWidgets, required List<List<Widget>> rowWidgets, required  final Map<int, TableColumnWidth> columnWidths}){
    return Table(
      border: TableBorder.all(),
      columnWidths: columnWidths,
      defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
      children: [
        TableRow(
          children: headerWidgets,
        ),
        ...rowWidgets.map((row) {
          return TableRow(
            children: row,
          );
        }).toList(),
      ],
    );
  }

  Widget cardReports({required BuildContext context, required List<LegendChartModel> legendList, required String text, required String subText, required Widget chart}) {
    return Card(
      color: context.general.colorScheme.surface,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,style: context.general.textTheme.titleSmall?.copyWith(fontSize: 18)),
                Text(subText,style: context.general.textTheme.titleSmall?.copyWith(fontSize: 14)),
              ],
          ),),
          Container(
            height: context.dynamicHeight(0.4),
            width: context.dynamicWidth(0.3),
            child: chart
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(0.28),
              child: GridView.builder(
                physics: PageScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 10,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 0,
                ),
                itemCount: legendList.length,
                itemBuilder: (context, index) {
                  var legend = legendList[index];
                  return Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        color: legend.color,
                        margin: const EdgeInsets.only(right: 8),
                      ),
                      Container(
                        width: context.dynamicWidth(0.075),
                        height: 15,
                        child: Text(
                          legend.label,
                          style: context.general.textTheme.bodySmall?.copyWith(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}