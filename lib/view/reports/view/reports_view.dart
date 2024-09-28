import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/core/extension/double_extension.dart';
import 'package:pdv_windows/view/_product/_widgets/loading_widget.dart';
import 'package:pdv_windows/view/reports/model/chart_data_model.dart';
import 'package:pdv_windows/view/reports/model/filter_report_model.dart';
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
                return Observer(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: context.colorScheme.surface,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  cardReports(context: context,chart: SfCircularChart(
                                      series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<ChartDataModel, String>(
                                            dataSource: viewModel.chartData,
                                            pointColorMapper:(ChartDataModel data, _) => data.color,
                                            xValueMapper: (ChartDataModel data, _) => data.x,
                                            yValueMapper: (ChartDataModel data, _) => data.y
                                        )
                                      ]
                                  )),
                                  cardReports(context: context,chart: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                                      tooltipBehavior: viewModel.tooltip,
                                      series: <CartesianSeries<ChartDataModel, String>>[
                                        ColumnSeries<ChartDataModel, String>(
                                            dataSource: viewModel.data,
                                            xValueMapper: (ChartDataModel data, _) => data.x,
                                            yValueMapper: (ChartDataModel data, _) => data.y,
                                            name: 'Gold',
                                            color: Color.fromRGBO(8, 142, 255, 1))
                                      ])),
                                  cardReports(context: context,chart: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                                      tooltipBehavior: viewModel.tooltip,
                                      series: <CartesianSeries<ChartDataModel, String>>[
                                        BarSeries<ChartDataModel, String>(
                                            dataSource: viewModel.data,
                                            xValueMapper: (ChartDataModel data, _) => data.x,
                                            yValueMapper: (ChartDataModel data, _) => data.y,
                                            name: 'Gold',
                                            color: Color.fromRGBO(8, 142, 255, 1))
                                      ])),
                                ],
                              ),
                              context.emptySizedHeightBoxLow,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: context.colorScheme.onPrimaryContainer, width: 1.0),
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
                                  context.emptySizedWidthBoxLow,
                                  Expanded(
                                    child: SizedBox(
                                      height: context.dynamicHeight(0.070),
                                      child: FilledButton.icon(
                                        onPressed: () => viewModel.export(),
                                        label: Text("Exportar"),
                                        icon: Icon(Icons.description),
                                        iconAlignment: IconAlignment.end,
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll(
                                              context.colorScheme.secondary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              context.emptySizedHeightBoxLow,
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
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
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

  Widget cardReports({required BuildContext context,required Widget chart}) {
    return Card(
      color: context.colorScheme.surface,
      elevation: 5,
      child: Container(
        height: context.dynamicHeight(0.4),
        width: context.dynamicWidth(0.3),
        child: chart
      ),
    );
  }
}