import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/bloc/measure.bloc.dart';
import 'package:tailor_book/config/amount_formater.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/pages/measures/link_coutier.page.dart';
import 'package:tailor_book/widgets/measure/custom_menu_item.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/measure_item_infos.widget.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class DetailMeasurePage extends StatefulWidget {
  final Measurement measurement;
  const DetailMeasurePage({
    super.key,
    required this.measurement,
  });

  @override
  State<DetailMeasurePage> createState() => _DetailMeasurePageState();
}

class _DetailMeasurePageState extends State<DetailMeasurePage> {
  late String? selectedMenu = '';
  @override
  Widget build(BuildContext context) {
    double measureHeight =
        100 * double.parse("${widget.measurement.measures!.length}");
    return Scaffold(
      backgroundColor: kGris,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Détail d'une mesure",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: PopupMenuButton<String>(
              initialValue: selectedMenu,
              iconSize: 30,
              position: PopupMenuPosition.under,
              onSelected: (String item) {
                if (item == 'Commencer') {
                  _startWork("PROGRESS");
                } else if (item == 'Clôturer') {
                  _startWork("CLOSED");
                } else if (item == 'Supprimer') {
                  deteleMeasure();
                } else if (item == 'Affecter') {
                  onNavigateToLink();
                }
                // setState(() {
                //   selectedMenu = item;
                // });
              },
              itemBuilder: (BuildContext context) => getMenuItems(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        // height: 75,
        child: BlocBuilder<MeasureBloc, MeasureStates>(
          builder: (builderContext, state) {
            log("$state");
            if (state is MeasureLoadingState) {
              return const LoadingSpinner();
            } else if (state is MeasureErrorState) {
              showToast(builderContext, state.errorMessage, "error");
            } else if (state is MeasureSuccessState) {
              showToast(builderContext, state.successMessage, "success");
              onGoBack(context, true);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MeasureItemInfos(
              title: "Situation du travail",
              content: getStatusLibelle(),
              contentColor: getStatusBgColor(),
            ),
            MeasureItemInfos(
              title: "Client",
              content: "${widget.measurement.customerName}",
            ),
            MeasureItemInfos(
              title: "Prix total",
              content: AmountFormater.format(widget.measurement.totalPrice!),
            ),
            MeasureItemInfos(
              title: "Montant de l'avance",
              content: AmountFormater.format(widget.measurement.advancedPrice!),
            ),
            MeasureItemInfos(
              title: "Date de remise",
              content: DateFormat("dd/MM/yyyy à HH:mm:ss")
                  .format(widget.measurement.createdDate!),
            ),
            MeasureItemInfos(
              title: "Date du rendez vous",
              content: DateFormat("dd/MM/yyyy")
                  .format(widget.measurement.removedDate!),
            ),
            MeasureItemInfos(
              title: "Couturier",
              content: widget.measurement.couturierId == null
                  ? "Pas encore affecté !"
                  : "${widget.measurement.couturierName}",
            ),
            Accordion(
              headerBorderRadius: 0,
              contentBackgroundColor: kGris,
              headerBackgroundColorOpened: secondaryColor,
              paddingListHorizontal: 0,
              children: [
                AccordionSection(
                  contentBorderRadius: 0,
                  contentHorizontalPadding: 0,
                  header: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Mesures et Type de tenue",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                  ),
                  content: Column(
                    children: [
                      MeasureItemInfos(
                        title: "Type de tenue",
                        content: "${widget.measurement.model}",
                      ),
                      SizedBox(
                        height: measureHeight,
                        child: ListView.builder(
                          itemCount: widget.measurement.measures?.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = widget.measurement.measures!.keys
                                .elementAt(index);
                            return MeasureItemInfos(
                              title: key,
                              content: widget.measurement.measures![key],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  contentBorderRadius: 0,
                  contentHorizontalPadding: 0,
                  header: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Photo du model et du tissu",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                  ),
                  content: Column(
                    children: [
                      const MeasureItemInfos(
                        title: "Photo du model",
                        titleColor: primaryColor,
                      ),
                      widget.measurement.photoModelUrl != null &&
                              widget.measurement.photoModelUrl != ""
                          ? Container(
                              height: 256,
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 16),
                              decoration: BoxDecoration(
                                color: kWhite,
                                border: Border.all(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.measurement.photoModelUrl!,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return const LoadingSpinner();
                                },
                              ),
                            )
                          : const MeasureItemInfos(
                              title: "",
                              content: "Aucune photo du model ajoutee !",
                              contentColor: secondaryColor,
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      const MeasureItemInfos(
                        title: "Photo du tissu",
                        titleColor: primaryColor,
                      ),
                      widget.measurement.photoTissuUrl != null &&
                              widget.measurement.photoTissuUrl != ""
                          ? Container(
                              height: 256,
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 16),
                              decoration: BoxDecoration(
                                color: kWhite,
                                border: Border.all(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.measurement.photoTissuUrl!,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return const LoadingSpinner();
                                },
                              ),
                            )
                          : const MeasureItemInfos(
                              title: "",
                              content: "Aucune photo du tissu ajoutee !",
                              contentColor: secondaryColor,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> getMenuItems() {
    List<PopupMenuEntry<String>> menuItems = [];

    if (widget.measurement.status == 'PENDING') {
      menuItems.add(
        PopupMenuItem<String>(
          value: 'Commencer',
          child: CustomMenuItem(
            icon: Icons.start,
            name: "Commencer",
            color: primaryColor,
            onPressed: () {},
          ),
        ),
      );
      menuItems.add(
        PopupMenuItem<String>(
          value: 'Affecter',
          child: CustomMenuItem(
            icon: Icons.link,
            name: "Affecter",
            color: kGreen,
            onPressed: () {},
          ),
        ),
      );
      menuItems.add(
        PopupMenuItem<String>(
          value: 'Modifier',
          child: CustomMenuItem(
            icon: Icons.update,
            name: "Modifier",
            color: primaryColor,
            onPressed: () {},
          ),
        ),
      );
    } else if (widget.measurement.status == 'PRODRESS') {
      menuItems.add(
        PopupMenuItem<String>(
          value: 'Commencer',
          child: CustomMenuItem(
            icon: Icons.start,
            name: "Commencer",
            color: primaryColor,
            onPressed: () {},
          ),
        ),
      );
      menuItems.add(
        PopupMenuItem<String>(
          value: 'Affecter',
          child: CustomMenuItem(
            icon: Icons.link,
            name: "Affecter",
            color: kGreen,
            onPressed: () {},
          ),
        ),
      );
      menuItems.add(
        PopupMenuItem<String>(
          value: 'Clôturer',
          child: CustomMenuItem(
            icon: Icons.close,
            name: "Clôturer",
            color: kGreen,
            onPressed: () {},
          ),
        ),
      );
    }
    menuItems.add(
      PopupMenuItem<String>(
        value: 'Supprimer',
        child: CustomMenuItem(
          icon: Icons.delete,
          name: "Supprimer",
          color: secondaryColor,
          onPressed: () {},
        ),
      ),
    );
    return menuItems;
  }

  Color getStatusBgColor() {
    switch (widget.measurement.status) {
      case "PENDING":
        return secondaryColor;
      case "PROGRESS":
        return tertiaryColor;
      case "CLOSED":
        return kGreen;
      default:
        return tertiaryColor;
    }
  }

  String getStatusLibelle() {
    switch (widget.measurement.status) {
      case "PENDING":
        return "Couture en attente";
      case "PROGRESS":
        return "Couture en cours";
      case "CLOSED":
        return "Couture terminée";
      default:
        return "Couture en cours";
    }
  }

  void onNavigateToLink() {
    MaterialPageRoute route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return LinkCouturierPage(
          measureId: widget.measurement.id!,
        );
      },
    );
    Navigator.push(context, route).then((value) {
      if (value == true) {
        // onGoBack(context, true);
      }
    });
  }

  void _startWork(String status) {
    context.read<MeasureBloc>().add(
          UpdateMeasurementStatusEvent(
            measureId: widget.measurement.id!,
            status: status,
          ),
        );
  }

  void deteleMeasure() {
    context.read<MeasureBloc>().add(
          DeleteMeasurement(
            measurement: widget.measurement,
          ),
        );
  }

  void showToast(BuildContext buildContext, String message, String type) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Toast.showFlutterToast(
          context,
          message,
          type,
        );
      },
    );
  }

  void onGoBack(BuildContext context, bool response) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.pop(context, response);
      },
    );
  }
}
