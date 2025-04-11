import 'package:ezyretail/dialogs/system_status_dialog.dart';
import 'package:ezyretail/globals.dart';
import 'package:ezyretail/language/globalization.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/pages/maintenance_screen/data_management_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/main_manu_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int gridCol = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.myWhite,
      appBar: AppBar(
        backgroundColor: ColorHelper.myDominantColor,
        centerTitle: true,
        title: SizedBox(
            height: 30, child: Image.asset("assets/images/ezypos_logo_w.png")),
        actions: [
          ZoomTapAnimation(
            onTap: () async {
              await Get.dialog(const StatusInfoDialog());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: ColorHelper.myWhite,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Image.asset("assets/icons/info_icon.png", height: 25),
            ),
          ),
          const Gap(10),
        ],
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: ColorHelper.myWhite,
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Text(
                      Globalization.posModule.tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.myBlack),
                    ),
                    const Gap(20),
                    GridView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCol,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      children: [
                        MainMenuPageItemButtonWidget(
                          enabled: systemBatchKey != "",
                          title: Globalization.salesScreen.tr,
                          icon: "assets/icons/sales_screen.png",
                          onTab: () async {
                            // if (await checkShiftDate()) {
                            //   Get.to(() => const SalesScreen());
                            // }
                          },
                        ),
                        systemBatchKey == ""
                            ? MainMenuPageItemButtonWidget(
                          enabled: systemBatchKey == "",
                          title: Globalization.openCounter.tr,
                          icon: "assets/icons/open_counter.png",
                          onTab: () async {
                            // Decimal? returnAmount = await Get.dialog(
                            //     DecimalNumPad(
                            //       title: Globalization.openCounter.tr,
                            //       initialValue: Decimal.zero,
                            //       allowZero: allowZeroOpenCounter,
                            //     ),
                            //     barrierDismissible: false);
                            //
                            // if (returnAmount != null) {
                            //   openCounter(returnAmount);
                            // }
                          },
                        )
                            : MainMenuPageItemButtonWidget(
                          enabled: systemBatchKey != "",
                          title: Globalization.closeCounter.tr,
                          icon: "assets/icons/close_counter.png",
                          onTab: () async {
                            // var result =
                            // await Get.to(() => const CloseCounter());
                            //
                            // if (result != null) {
                            //   setState(() {
                            //     systemBatchKey = "";
                            //   });
                            // }
                          },
                        ),
                        MainMenuPageItemButtonWidget(
                          enabled: systemBatchKey != "",
                          title: Globalization.cashInOut.tr,
                          icon: "assets/icons/cash_io.png",
                          onTab: () {
                            // Get.to(() => const CashInOut());
                          },
                        ),
                        if (licenceMode == 0 || licenceMode == 2)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.stockAdjustment.tr,
                            icon: "assets/icons/stock_adjust.png",
                            onTab: () {
                              // Get.to(() => const StockAdjustmentPage());
                            },
                          ),
                        MainMenuPageItemButtonWidget(
                          title: Globalization.logout.tr,
                          icon: "assets/icons/exit.png",
                          onTab: () {
                            Get.offAll(() => const LoginScreen());
                          },
                        ),
                      ],
                    ),
                    if (kDebugMode)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Text(
                            "Advance Module",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorHelper.myBlack),
                          ),
                          const Gap(20),
                          GridView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: gridCol,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            children: [
                              MainMenuPageItemButtonWidget(
                                enabled: true,
                                title: Globalization.salesOder.tr,
                                icon: "assets/icons/order_cart.png",
                                onTab: () {
                                  // Get.to(() => const SalesOrderPage());
                                },
                              ),
                              MainMenuPageItemButtonWidget(
                                enabled: true,
                                title: Globalization.salesInvoice.tr,
                                icon: "assets/icons/sales.png",
                                onTab: () {
                                  // Get.to(() => const InvoiceDocumentPage());
                                },
                              ),
                              MainMenuPageItemButtonWidget(
                                enabled: true,
                                title: Globalization.salesReturn.tr,
                                icon: "assets/icons/return.png",
                                onTab: () {},
                              ),
                              MainMenuPageItemButtonWidget(
                                enabled: true,
                                title: Globalization.customerPayment.tr,
                                icon: "assets/icons/other_payment.png",
                                onTab: () {
                                  // Get.to(() => const SingUpPage());
                                },
                              ),
                              MainMenuPageItemButtonWidget(
                                enabled: true,
                                title: Globalization.customerMaintenance.tr,
                                icon: "assets/icons/customer.png",
                                onTab: () {
                                  // Get.to(() => const CustomerMaintenancePage());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (eInvoiceEnable)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Text(
                            "MyInvois",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorHelper.myBlack),
                          ),
                          const Gap(20),
                          GridView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: gridCol,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            children: [
                              //TODO EInvoice

                              /*   MainMenuPageItemButtonWidget(
                              title: Globalization.malaysiaEInvoice.tr,
                              icon: "assets/icons/consolidate_file.png",
                              onTab: () {
                                Get.to(() => const MyEInvoicePage());
                              },
                              enabled: true,
                            ),*/
                              MainMenuPageItemButtonWidget(
                                title: Globalization.eInvoiceSyncReport.tr,
                                icon: "assets/icons/sync_log.png",
                                onTab: () {
                                  // Get.to(() => const SyncEinvoiceReportPage());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    const Gap(20),
                    Text(
                      Globalization.reports.tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.myBlack),
                    ),
                    const Gap(20),
                    GridView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCol,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      children: [
                        MainMenuPageItemButtonWidget(
                          title: Globalization.documentListing.tr,
                          icon: "assets/icons/reports.png",
                          onTab: () {
                            // Get.to(() => const GeneralReportsPage());
                          },
                        ),
                        if (licenceMode == 1 || licenceMode == 3)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.documentSyncReport.tr,
                            icon: "assets/icons/sync_log.png",
                            onTab: () {
                              // Get.to(() => const SyncSalesReportPage());
                            },
                          ),
                        if (memberIsActive)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.membersSyncReport.tr,
                            icon: "assets/icons/sync_log.png",
                            onTab: () {
                              // Get.to(() => const SyncMemberReportPage());
                            },
                          ),
                        if (licenceMode == 0 || licenceMode == 2)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.stockBalanceReport.tr,
                            icon: "assets/icons/item_report.png",
                            onTab: () {
                              // Get.to(() => const StockBalanceReport());
                            },
                          ),
                        if (licenceMode == 0 || licenceMode == 2)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.stockCardReport.tr,
                            icon: "assets/icons/stock_card_report.png",
                            onTab: () {
                              // Get.to(() => const StockCardReport());
                            },
                          ),
                      ],
                    ),
                    const Gap(20),
                    Text(
                      Globalization.maintenance.tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.myBlack),
                    ),
                    const Gap(20),
                    GridView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCol,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      children: [
                        MainMenuPageItemButtonWidget(
                          title: Globalization.stockItem.tr,
                          icon: "assets/icons/items.png",
                          onTab: () {
                            // Get.to(() => const StockItem());
                          },
                        ),
                        /* MenuPageItemButtonWidget(
                          title: Globalization.customer.tr,
                          icon: "assets/icons/customer.png",
                          onTab: () {
                            Get.updateLocale(Globalization.chineseLocale);
                          },
                        ),*/
                        MainMenuPageItemButtonWidget(
                          title: Globalization.menuSettings.tr,
                          icon: "assets/icons/edit_menu.png",
                          onTab: () {
                            // Get.to(() => const MenuMaintenance());
                          },
                        ),
                        MainMenuPageItemButtonWidget(
                          title: Globalization.paymentMethod.tr,
                          icon: "assets/icons/payment_mode.png",
                          onTab: () {
                            // Get.to(() => const PaymentMethodMaintenance());
                          },
                        ),
                        MainMenuPageItemButtonWidget(
                          title: Globalization.promotion.tr,
                          icon: "assets/icons/promotion.png",
                          onTab: () {
                            // Get.to(() => const PromotionPlans());
                          },
                        ),
                        if (kDebugMode)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.promotion.tr,
                            icon: "assets/icons/tax.png",
                            onTab: () {},
                          ),
                        MainMenuPageItemButtonWidget(
                          title: Globalization.dataManagement.tr,
                          icon: "assets/icons/data_management.png",
                          onTab: () {
                            Get.to(() => const DataManagementScreen());
                          },
                        ),
                        if (licenceMode != 1 && licenceMode != 3)
                          if (userAccess == 1)
                            MainMenuPageItemButtonWidget(
                              title: Globalization.userMaintenance.tr,
                              icon: "assets/icons/pos_user.png",
                              onTab: () {
                                // Get.to(() => const UserMaintenance());
                              },
                            ),
                        if (userAccess == 1)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.companyProfile.tr,
                            icon: "assets/icons/company_info.png",
                            onTab: () {
                              // Get.to(() => const CompanyProfile());
                            },
                          ),
                      ],
                    ),
                    const Gap(20),
                    Text(
                      Globalization.settings.tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.myBlack),
                    ),
                    const Gap(20),
                    GridView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCol,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      children: [
                        MainMenuPageItemButtonWidget(
                          title: Globalization.systemSettings.tr,
                          icon: "assets/icons/system_settings.png",
                          enabled: userAccess < 3,
                          onTab: () {
                            // Get.to(() => const SystemSettings());
                          },
                        ),
                        // TODO Scale Barcode
                        if (enableInventoryModule)
                          MainMenuPageItemButtonWidget(
                            title: Globalization.scaleSettings.tr,
                            icon: "assets/icons/scale_settings.png",
                            enabled: false,
                            onTab: () {
                              // Get.to(() => const ScaleSettings());
                            },
                          ),
                        MainMenuPageItemButtonWidget(
                          title: Globalization.hardwareSettings.tr,
                          icon: "assets/icons/printer_settings.png",
                          enabled: userAccess < 3,
                          onTab: () {
                            // Get.to(() => const PrinterSetting());
                          },
                        ),
                        MainMenuPageItemButtonWidget(
                          title: Globalization.serverSettings.tr,
                          icon: "assets/icons/server_settings.png",
                          enabled: userAccess < 3,
                          onTab: () async {
                            // await Get.to(() {
                            //   return const ServerSettings();
                            // });
                            //
                            // setState(() {});
                          },
                        ),
                        if (kDebugMode)
                          MainMenuPageItemButtonWidget(
                            title: "Display",
                            icon: "assets/icons/eyes.png",
                            onTab: () {
                              // Get.to(() => const DisplayManagerScreen());
                            },
                          ),
                        if (kDebugMode)
                          MainMenuPageItemButtonWidget(
                            title: "IMIN",
                            icon: "assets/icons/eyes.png",
                            onTab: () {
                              // Get.to(() => const IminTest());
                            },
                          ),
                        if (kDebugMode)
                          MainMenuPageItemButtonWidget(
                            title: "EInvoice",
                            icon: "assets/icons/eyes.png",
                            onTab: () async {
                              // String ff = "KTNCS05241024-10002";
                              // List<FullSalesDoc> salesDocList =
                              // await DatabaseHelper.instance
                              //     .getSingleSalesDocForTest(ff);
                              //
                              // String url =
                              //     "$eInvoiceUrl/api/cashsales/add?supplier_uuid=$eInvoiceClientId";
                              //
                              // String rr = await postPendingEInvoiceLog(
                              //     url, salesDocList, eInvoiceClientId);
                            },
                          ),
                        if (kDebugMode)
                          MainMenuPageItemButtonWidget(
                            title: "Test Api",
                            icon: "assets/icons/eyes.png",
                            onTab: () {
                              // Get.to(() => const TestApi());
                            },
                          ),
                      ],
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
