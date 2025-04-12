import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/helpers/image_helper.dart';
import 'package:ezyretail/models/cash_io_model.dart';
import 'package:ezyretail/models/check_out_model.dart';
import 'package:ezyretail/models/company_profile_model.dart';
import 'package:ezyretail/models/customer_model.dart';
import 'package:ezyretail/models/item_barcode_model.dart';
import 'package:ezyretail/models/item_master_model.dart';
import 'package:ezyretail/models/item_menu_model.dart';
import 'package:ezyretail/models/item_sum_report_model.dart';
import 'package:ezyretail/models/payment_method_model.dart';
import 'package:ezyretail/models/promotion_model.dart';
import 'package:ezyretail/models/shift_batch_model.dart';
import 'package:ezyretail/models/tax_object.dart';
import 'package:ezyretail/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../models/sales.dart';

class DatabaseHelper{
  static final DatabaseHelper instance = DatabaseHelper._init();

  static const databaseName = 'ezyRetail.db';
  static const databaseVer = 1;

  static const companyProfileTable = 'CompanyProfile';
  static const companyName = 'CompanyName';
  static const companyRoc = 'CompanyRoc';
  static const companyTaxNo = 'CompanyTaxNo';
  static const companyAddress1 = 'Address1';
  static const companyAddress2 = 'Address2';
  static const companyAddress3 = 'Address3';
  static const companyAddress4 = 'Address4';
  static const companyPhone = 'Phone';
  static const companyEmail = 'Email';
  static const counter = 'Counter';
  static const token = 'Token';
  static const label = 'Label';
  static const companyLogo = 'CompanyLogo';
  static const location = 'Location';
  static const posCode = 'Poscode';
  static const city = 'City';
  static const state = 'State';
  static const country = 'Country';

  static const itemTable = 'ItemMaster';
  static const barcodeTable = 'ItemBarcode';
  static const imageTable = 'ImageTable';

  static const supplier = 'Supplier';
  static const customerTable = 'Customer';

  static const itemCode = 'ItemCode';
  static const itemDesc = 'ItemDesc';
  static const itemDesc2 = 'ItemDesc2';
  static const itemGroup = 'ItemGroup';
  static const itemCategory = 'ItemCategory';
  static const itemStatus = 'ItemStatus';
  static const itemUom = 'ItemUom';
  static const uomQTY = 'UomRate';
  static const itemCost = 'ItemCost';
  static const itemPrice = 'ItemPrice';
  static const itemBarcode = 'ItemBarcode';
  static const itemImage = 'ItemImage';
  static const signature = 'Signature';
  static const sellingPrice = 'SellingPrice';
  static const itemAmount = 'ItemAmount';
  static const classification = 'Classification';
  static const tariff = 'Tariff';

  static const custCode = 'CustCode';
  static const custName = 'CustName';

  static const customerCode = 'CustomerCode';
  static const customerName = 'CustomerName';
  static const customerName2 = 'CustomerName2';
  static const customerPhone = 'CustomerPhone';
  static const customerMobile = 'CustomerMobile';
  static const customerExpiryDate = 'CustomerExpiryDate';
  static const customerStatus = 'CustomerStatus';
  static const industryCode = 'IndustryCode';
  static const priceTag = 'PriceTag';

  //For E invoice
  static const customerTin = 'CustomerTin';
  static const customerIcNum = 'CustomerICNum';
  static const customerSST = 'CustomerSST';

  static const docKey = 'DocKey';
  static const stkCountTitle = 'DocTitle';
  static const docLocation = 'DocLocation';
  static const subLocation = 'SubLocation';
  static const docDate = 'DocDate';
  static const itemQty = 'CountQty';
  static const usedQty = 'UsedQty';
  static const remainQty = 'RemainQty';
  static const versions = 'Version';
  static const isBatch = 'IsBatch';
  static const isSerial = 'IsSerial';
  static const isAddFastMenu = 'IsAddFastMenu';

  static const baseUom = 'BaseUom';
  static const itemPrice2 = 'ItemPrice2';
  static const itemPrice3 = 'ItemPrice3';
  static const itemPrice4 = 'ItemPrice4';
  static const itemPrice5 = 'ItemPrice5';
  static const itemPrice6 = 'ItemPrice6';
  static const memberPrice = 'MemberPrice';

  static const createDate = 'CreateDate';
  static const lastUpdate = 'LastUpdate';

  static const docCount = 'DocCount';
  static const localDoc = 'LocalDoc';
  static const fromLoc = 'FromLoc';
  static const toLoc = 'ToLoc';
  static const remark = 'Remark';

  static const tempItem = 'TempItem';
  static const status = 'Status';
  static const expiryDate = 'ExpiryDate';

  //Scale Barcode Setting Table
  static const scaleBarcodeSettingTable = 'ScaleBarcodeSettingTable';
  static const barcodeLength = 'BarcodeLength';
  static const codeStart = 'CodeStart';
  static const codeEnd = 'CodeEnd';
  static const qtyStart = 'QtyStart';
  static const qtyEnd = 'QtyEnd';
  static const decimalDigit = 'DecimalDigit';

  //Customer Table
  static const memberTable = 'Member';
  static const memberId = 'MemberId';
  static const memberName = 'MemberName';
  static const memberType = 'MemberType';
  static const memberPhone = 'MemberPhone';
  static const memberEmail = 'MemberEmail';
  static const memberAddress1 = 'MemberAddress1';
  static const memberAddress2 = 'MemberAddress2';
  static const memberAddress3 = 'MemberAddress3';
  static const memberAddress4 = 'MemberAddress4';
  static const memberIdentificationNum = 'MemberIdentificationNum';
  static const memberTin = 'MemberTin';
  static const memberSST = 'MemberSST';

  static const isActive = 'IsActive';

  static const customerRegistrationNum = 'CustomerRegistrationNumber';
  static const companyRegistrationNum = 'CompanyRegistrationNumber';
  static const companyTin = 'CompanyTin';
  static const companySST = 'CompanySST';
  static const lastModified = 'LastModified';

  //Sales Table
  static const salesTable = 'Sales';
  static const salesKey = 'SalesKey';
  static const invoiceDoc = 'InvoiceDoc';
  static const customerKey = 'CustomerKey';
  static const paymentMethodKey = 'PaymentMethodKey';
  static const taxAmount = 'TaxAmount';
  static const voucher = 'Voucher';
  static const voucherAmount = 'VoucherAmount';
  static const isFooterDiscountPercent = 'IsFooterDiscountPercent';
  static const footerDiscountPercent = 'FooterDiscountPercent';
  static const footerDiscountValue = 'FooterDiscountValue';
  static const subtotal = 'Subtotal';
  static const roundedAmount = 'RoundedAmount';
  static const total = 'Total';
  static const createdAt = 'CreatedAt';
  static const transactionId = 'TransactionId';
  static const transactionAt = 'TransactionAt';
  static const lastSync = 'LastSync';
  static const isVoid = 'IsVoid';
  static const salesKeyReferCount = 'SalesKeyReferCount';
  static const salesDetailCount = 'SalesDetailCount';
  static const fromSalesKeyCount = 'FromSalesKeyCount';
  static const paymentRef = 'PaymentRef';
  static const returnUserKey = 'ReturnUserKey';
  static const authorizeUserKey = 'AuthorizeUserKey';
  static const returnSalesAt = 'ReturnSalesAt';
  static const notSyncItemQty = 'NotSyncItemQty';
  static const customerAddress1 = 'CustomerAddress1';
  static const customerAddress2 = 'CustomerAddress2';
  static const customerAddress3 = 'CustomerAddress3';
  static const customerAddress4 = 'CustomerAddress4';
  static const ezyPointEarnPoint = 'EzyPointEarnPoint';
  static const ezyPointRedeemPoint = 'EzyPointRedeemPoint';
  static const ezyPointRedeemValue = 'EzyPointRedeemValue';
  static const ezyCreditValue = 'EzyCreditValue';
  static const editedCustomerName = 'EditedCustomerName';
  static const editedCustomerAddress1 = 'EditedCustomerAddress1';
  static const editedCustomerAddress2 = 'EditedCustomerAddress2';
  static const editedCustomerAddress3 = 'EditedCustomerAddress3';
  static const editedCustomerAddress4 = 'EditedCustomerAddress4';

  //Sales Detail Table
  static const salesDetailTable = 'SalesDetail';
  static const salesDetailKey = 'SalesDetailKey';
  static const itemKey = 'ItemKey';
  static const quantity = 'Quantity';
  static const price = 'Price';
  static const totalAmount = 'TotalAmount';
  static const uom = 'UOM';
  static const discountValue = 'DiscountValue';
  static const discountPercent = 'DiscountPercent';
  static const isDiscountInPercent = 'IsDiscountInPercent';
  static const taxCode = 'TaxCode';
  static const taxRate = 'TaxRate';
  static const fromSalesKey = 'FromSalesKey';
  static const fromSalesDetailKey = 'FromSalesDetailKey';
  static const salesDetailKeyReferCount = 'SalesDetailKeyReferCount';
  static const sumReturnQuantity = 'SumReturnQuantity';
  static const promotionType = 'PromotionType';
  static const promotionDetailKey = 'PromotionDetailKey';
  static const promotionDiscount = 'PromotionDiscount';
  static const promoPrice = 'PromoPrice';
  static const baseQty = 'baseQty';

  //Old
  static const discount = 'Discount';
  static const description = 'Description';

  //Pending Sales Table
  static const pendingSalesTable = 'PendingSales';
  static const key = 'Key';

  //Pending Sales Detail Table
  static const pendingSalesDetailTable = 'PendingSalesDetail';

  //Menu Header Table
  static const menuHeaderTable = 'MenuHeader';
  static const headerId = 'HeaderId';
  static const menuId = 'MenuId';
  static const menuSeq = 'MenuSeq';
  static const itemType = 'ItemType';
  static const textColor = 'TextColor';
  static const baseColor = 'BaseColor';
  static const isWeightItem = 'WeightItem';

  //Menu Detail Table
  static const menuDetailTable = 'MenuDetail';

  //Batch Table
  static const batchTable = 'Batch';
  static const batchKey = 'BatchKey';
  static const startCounter = 'StartCounter';
  static const endCounter = 'EndCounter';
  static const openCounterUser = 'OpenCounterUser';
  static const closeCounterUser = 'CloseCounterUser';

  //Activity Table
  static const activityTable = 'Activity';

  // static const userId = 'UserId';
  static const loginTime = 'LoginTime';
  static const logoutTime = 'LogoutTime';

  //Cash In/Out Table
  static const cashInOutTable = 'CashInOut';
  static const cashType = 'CashType';
  static const performTime = 'PerformTime';
  static const cashInOutAmount = 'CashInOutAmount';
  static const reason = 'Reason';
  static const isOpening = 'IsOpening';
  static const isClosing = 'IsClosing';
  static const attachment = 'Attachment';

  //Cash In/Out reason Table
  static const cashInOutReasonTable = 'CashIOReason';
  static const reasonCode = 'ReasonCode';
  static const reasonDesc = 'ReasonDesc';
  static const isCashIn = 'IsCashIn';
  static const isCashOut = 'IsCashOut';

  //User Table
  static const userTable = 'User';
  static const userKey = 'UserKey';
  static const userName = 'UserName';
  static const password = 'Password';
  static const access = 'Access';
  static const pin = 'PIN';

  //ActivityBatchTable
  static const activityBatchTable = 'ActivityBatch';
  static const activityKey = 'ActivityKey';

  //Customer Info Table
  static const customerInfoTable = 'CustomerInfo';
  static const customerEmail = 'CustomerEmail';
  static const whatsapp = 'Whatsapp';

  //Promotion Table
  static const promotionTable = 'Promotion';
  static const promotionKey = 'PromotionKey';
  static const priority = 'Priority';
  static const promotionCode = 'PromotionCode';
  static const promotionDesc = 'PromotionDesc';
  static const fromDate = 'FromDate';
  static const toDate = 'ToDate';
  static const fromTime = 'FromTime';
  static const toTime = 'ToTime';
  static const validDay1 = 'ValidDay1';
  static const validDay2 = 'ValidDay2';
  static const validDay3 = 'ValidDay3';
  static const validDay4 = 'ValidDay4';
  static const validDay5 = 'ValidDay5';
  static const validDay6 = 'ValidDay6';
  static const validDay7 = 'ValidDay7';
  static const validNoneMember = 'ValidOneMember';
  static const validBirthday = 'ValidBirthday';
  static const validBirthdayMonth = 'ValidBirthdayMonth';
  static const exceedMaxPurchasedQty = 'ExceedMaxPurchasedQty';
  static const createdTime = 'CreatedTime';

  //Promotion Item Table
  static const promotionItemTable = 'PromotionItem';
  static const promotionItemKey = 'PromotionItemKey';
  static const minPurchaseQty = 'MinPurchaseQty';
  static const maxPurchaseQty = 'MaxPurchaseQty';
  static const unitPrice = 'UnitPrice';
  static const memberLevel1Price = 'MemberLevel1Price';
  static const memberLevel1Discount = 'MemberLevel1Discount';
  static const memberLevel2Price = 'MemberLevel2Price';
  static const memberLevel2Discount = 'MemberLevel2Discount';
  static const memberLevel3Price = 'MemberLevel3Price';
  static const memberLevel3Discount = 'MemberLevel3Discount';

  //Promotion MIX & MATCH Table
  static const promotionMixMatchTable = 'PromotionMixMatch';

  //promotionMixMatchKey
  static const pMixMatchKey = 'PMMKey';

  //mixMatchDescription
  static const mixMatchDesc = 'MixMatchDesc';
  static const type = 'Type';
  static const qty = 'Qty';
  static const totalPrice = 'TotalPrice';
  static const onlyMatchQty = 'OnlyMatchQty';
  static const type2 = 'Type2';
  static const qty2 = 'Qty2';
  static const totalPrice2 = 'TotalPrice2';
  static const unitPrice2 = 'unitPrice2';
  static const discount2 = 'Discount2';
  static const onlyMatchQty2 = 'OnlyMatchQty2';
  static const matchDifferentOnly = ' MatchDifferentOnly';

  //Promotion MIX & MATCH Detail Table
  static const promotionMixMatchDetailTable = 'PromotionMixMatchDetail';

  //promotionMixMatchDetailKey
  static const pMixMatchDetailKey = 'PMMDetailKey';

  //Promotion Purchase With Purchase Table
  static const promotionPurchaseWithPurchaseTable =
      'PromotionPurchaseWithPurchase';

  //promotionPurchaseWithPurchaseKey
  static const pPWPKey = 'PPWPKey';

  //purchaseWithPurchaseDescription
  static const pPWPDesc = 'PWPDesc';
  static const purchasedQty = 'PurchasedQty';
  static const purchasedAmount = 'PurchasedAmount';
  static const matchOne = 'MatchOne';

  //Promotion Purchase With Purchase Detail Table
  static const promotionPurchaseWithPurchaseDetailTable =
      'PromotionPurchaseWithPurchaseDetail';

  //promotionPurchaseWithPurchaseDetailKey
  static const pPWPDetailKey = 'PPWPDetailKey';
  static const isFOC = 'IsFOC';

  //Scale Barcode Profile Table
  static const scaleBarcodeProfileTable = 'ScaleBarcodeProfile';
  static const scaleBarcodeProfileKey = 'ScaleBarcodeProfileKey';
  static const departmentCode = 'DepartmentCode';
  static const departmentName = 'DepartmentName';

  //Payment Method Table
  static const paymentMethodTable = 'PaymentMethod';
  static const paymentCode = 'PaymentCode';
  static const paymentType = 'PaymentType';
  static const paymentImage = 'PaymentImage';
  static const paymentDescription = 'PaymentDescription';
  static const paymentNeedRef = 'PaymentNeedRef';
  static const paymentOpenDrawer = 'PaymentOpenDrawer';
  static const useTerminal = 'UseTerminal';
  static const terminalId = 'TerminalId';
  static const refundPin = 'RefundPin';
  static const storeId = 'StoreId';
  static const clientId = 'ClientId';
  static const clientKey = 'ClientKey';
  static const privateKey = 'PrivateKey';
  static const publicKey = 'PublicKey';
  static const usedCreditCard = 'UsedCreditCard';
  static const usedEWallet = 'UsedEWallet';

  //Sales Payment Record Table
  static const salesPaymentRecordTable = 'SalesPaymentRecord';
  static const knockOffAmount = 'KnockOffAmount';
  static const paidAmount = 'PaidAmount';
  static const dueAmount = 'DueAmount';
  static const changeAmount = 'ChangeAmount';
  static const reference = 'Reference';

  //Stock Transaction Table
  static const stockTransactionTable = 'StockTransaction';
  static const postDate = 'PostDate';
  static const docType = 'DocType';
  static const docDtlKey = 'DocDtlKey';
  static const docDesc = 'DocDesc';
  static const qtyIn = 'QtyIn';
  static const qtyOut = 'QtyOut';
  static const balanceQty = 'BalanceQty';

  //Stock Adjustment Table
  static const stockAdjustmentTable = 'StockAdjustment';
  static const docNo = 'DocNo';

  //Stock Adjustment Detail Table
  static const stockAdjustmentDetailTable = 'StockAdjustmentDetail';
  static const rate = 'Rate';

  //Standard Quantity
  static const stdQty = 'StdQty';

  //Sync Record Table
  static const syncRecordTable = 'SyncRecord';
  static const syncTime = 'SyncTime';

  //E-Invoice Table
  static const eInvoiceTable = 'eInvoice';
  static const eInvoiceNum = 'eInvoiceNum';
  static const eInvoiceRemark = 'eInvoiceRemark';

  //Return Table
  static const salesReturnTable = 'SalesReturnTable';
  static const salesReturnDetailTable = 'SalesReturnDetailTable';

  //Refund Table
  static const refundTable = 'RefundTable';

  //Sync Member Table
  static const syncMemberTable = 'SyncMemberTable';
  static const docAmount = 'DocAmount';
  static const memberPoint = 'MemberPoint';

  //Sales Order Table
  static const salesOrderTable = 'SalesOrderTable';
  static const salesOrderDetailTable = 'SalesOrderDetailTable';
  static const salesOrderPaymentTable = 'SalesOrderPaymentTable';

  //Invoice Table
  static const invoiceTable = 'InvoiceTable';
  static const invoiceDetailTable = 'InvoiceDetailTable';
  static const invoicePaymentTable = 'InvoicePaymentTable';

  //Tax Table
  static const taxTable = 'TaxTable';
  static const taxDesc = 'TaxDesc';
  static const tariffCode = 'TariffCode';
  static const taxIncl = 'TaxIncl';
  static const defaultTax = 'DefaultTax';

  Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: databaseVer,
        onCreate: _createDB,
        onUpgrade: upgradeDatabase,
        onDowngrade: downgradeDatabase);
  }

  Future<void> downgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    int dbVersion = newVersion;

    if (oldVersion > newVersion) {}
  }

  Future<void> upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    int dbVersion = oldVersion;
    if (oldVersion < newVersion) {
      try {
        List<String> errorList = [];
      } catch (e) {
        debugPrint(e.toString());
        await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
            barrierDismissible: false);
      }
    }
  }

  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }

  Future<void> reopenDatabase() async {
    _database ??= await _initDB(databaseName);
  }

  Future _createDB(Database db, int version) async {
    //Create Profile
    createProfileTable(db);

    //Create Item Master Table
    createItemMasterTable(db);

    //Create Item Barcode Table
    createItemBarcodeTable(db);

    //Create Item Image Table
    createItemImageTable(db);

    //Create Customer Table
    createCustomerTable(db);

    //Create Scale Barcode Setting Table
    createScaleBarcodeSettingTable(db);

    //Create Scale Barcode Profile Table
    createScaleBarcodeProfileTable(db);

    //Create Batch Table
    createBatchTable(db);

    //Create Activity Table
    createActivityTable(db);

    //Create Cash In Out Table
    createCashInOutTable(db);

    //Create Cash In Out Reason Table
    createCashIOReasonTable(db);

    //Create Member Table
    createMemberTable(db);

    //Create Sales Table
    createSalesTable(db);

    //Create Sales Detail Table
    createSalesDetailTable(db);

    //Create Sales Order Table
    createSalesOrderTable(db);

    //Create Sales Order Detail Table
    createSalesOrderDetailTable(db);

    //Create Invoice Table
    createInvoiceTable(db);

    //Create Invoice Detail Table
    createInvoiceDetailTable(db);

    //Create Pending Sales Table
    createPendingSalesTable(db);

    //Create Pending Sales Detail Table
    createPendingSalesDetailTable(db);

    //Create Menu Header Table
    createMenuHeaderTable(db);

    //Create Menu Detail Table
    createMenuDetailTable(db);

    //Create User Table
    createUserTable(db);

    //Create ActivityBatch Table
    createActivityBatchTable(db);

    //Create Customer Info Table
    createCustomerInfoTable(db);

    //Create Promotion Table
    createPromotionTable(db);

    //Create Promotion Item Table
    createPromotionItemTable(db);

    //Create Promotion Mix & Match Table
    createPromotionMMTable(db);

    //Create Promotion Mix & Match Detail Table
    createPromotionMMDetailTable(db);

    //Create Promotion Purchase With Purchase Table
    createPromotionPWPTable(db);

    //Create Promotion Purchase With Purchase Detail Table
    createPromotionPWPDetailTable(db);

    //Create Payment Method Table
    createPaymentMethodTable(db);

    //Create Sales Payment Record Table
    createSalesPaymentRecordTable(db);

    //Create Sales Order Payment Table
    createSalesOrderPaymentTable(db);

    //Create Invoice Payment Table
    createInvoicePaymentTable(db);

    //Create Stock Transaction Table
    // createStockTransactionTable(db); Remove on 19/02/2025

    //Create Stock Adjustment Table
    createStockAdjustmentTable(db);

    //Create Stock Adjustment Detail Table
    createStockAdjustmentDetailTable(db);

    //Create Sync Record
    createSyncRecord(db);

    //Create EInvoice
    createEInvoiceTable(db);

    //Create Sales Return Table
    createSalesReturnTable(db);

    //Create Sales Return Detail Table
    createReturnDetailTable(db);

    //Create Refund Table
    createSalesRefundRecordTable(db);

    //Create Sync Member Table
    createSyncMemberTable(db);

    //Create Tax Table
    createTaxTable(db);
  }

  Future<bool> dropAllTable() async {
    bool result = false;
    try {
      await dropProfileTable();
      await dropActivityTable();
      await dropActivityBatchTable();
      await dropBatchTable();
      await dropCashInOutTable();
      await dropCustomerTable();
      await dropCustomerInfoTable();
      await dropImageTbl();
      await dropBarcodeTbl();
      await dropItemTbl();
      await dropMemberTable();
      await dropMenuHeaderTable();
      await dropMenuDetailTable();
      await dropPendingSalesTable();
      await dropPendingSalesDetailTable();
      await dropPromotionTable();
      await dropSalesTable();
      await dropSalesDetailTable();
      await dropSalesOrderTable();
      await dropSalesOrderDetailTable();
      await dropInvoiceTable();
      await dropInvoiceDetailTable();
      await dropScaleBarcodeTbl();
      await dropScaleProfileTbl();
      await dropUserTable();
      await dropPaymentMethodTable();
      await dropSalesPaymentRecordTable();
      await dropInvoicePaymentTable();
      await dropSalesOrderPaymentTable();
      // await dropStockTransactionTable(); Remove on 19/02/2025
      await dropStockAdjustmentTable();
      // await dropStockAdjustmentDetailTable(); Remove on 19/02/2025
      await dropSyncRecord();
      await dropEInvoiceTable();
      await dropSalesReturnTable();
      await dropReturnDetailTable();
      await dropSalesRefundRecordTable();
      await dropSyncMemberTable();
      await dropCashInOutReasonTable();
      await dropTaxTable();

      result = true;
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return result;
  }

  Future<bool> deleteTransactionTable() async {
    bool result = false;
    try {
      await dropActivityTable();
      await dropActivityBatchTable();
      await dropBatchTable();
      await dropCashInOutTable();

      await dropPendingSalesTable();
      await dropPendingSalesDetailTable();

      await dropSalesTable();
      await dropSalesDetailTable();
      await dropSalesOrderTable();
      await dropSalesOrderDetailTable();
      await dropInvoiceTable();
      await dropInvoiceDetailTable();

      await dropSalesPaymentRecordTable();
      await dropSalesOrderPaymentTable();
      await dropInvoicePaymentTable();
      // await dropStockTransactionTable(); Remove on 19/02/2025
      await dropStockAdjustmentTable();
      // await dropStockAdjustmentDetailTable(); Remove on 19/02/2025
      await dropSyncRecord();

      await dropEInvoiceTable();
      await dropSalesReturnTable();
      await dropReturnDetailTable();
      await dropSalesRefundRecordTable();
      await dropSyncMemberTable();

      result = true;
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return result;
  }

  Future<void> createProfileTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $companyProfileTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $companyName TEXT,
    $companyTaxNo TEXT DEFAULT '',
    $companyRoc TEXT DEFAULT '',
    $companyTin TEXT DEFAULT '',
    $companyAddress1 TEXT DEFAULT '',
    $companyAddress2 TEXT DEFAULT '',
    $companyAddress3 TEXT DEFAULT '',
    $companyAddress4 TEXT DEFAULT '',
    $companyPhone TEXT DEFAULT '',
    $companyEmail TEXT DEFAULT '',   
    $counter INTEGER DEFAULT 0,
    $token TEXT DEFAULT '',
    $label TEXT DEFAULT '',
    $companyLogo BLOB,
    $location TEXT DEFAULT '',
    $posCode TEXT DEFAULT '',
    $city TEXT DEFAULT '',
    $state TEXT DEFAULT '',
    $country TEXT DEFAULT 'MY'
    )
    ''');
  }

  Future<void> createItemMasterTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $itemTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $itemCode TEXT,
    $itemDesc TEXT DEFAULT '',
    $itemDesc2 TEXT DEFAULT '',
    $itemUom TEXT DEFAULT '',
    $baseUom TEXT DEFAULT '',
    $uomQTY REAL DEFAULT 0.0,
    $itemGroup TEXT DEFAULT '',
    $itemCategory TEXT DEFAULT '',
    $itemCost REAL DEFAULT 0.0,
    $itemPrice REAL DEFAULT 0.0,
    $itemPrice2 REAL DEFAULT 0.0,
    $itemPrice3 REAL DEFAULT 0.0,
    $itemPrice4 REAL DEFAULT 0.0,
    $itemPrice5 REAL DEFAULT 0.0,
    $itemPrice6 REAL DEFAULT 0.0,
    $memberPrice REAL DEFAULT 0.0,
    $itemStatus INTEGER DEFAULT 1,
    $tempItem INTEGER DEFAULT 0,
    $itemType TEXT DEFAULT '',
    $classification TEXT DEFAULT '',
    $taxCode TEXT DEFAULT '',
    $tariff TEXT DEFAULT '',
    $isBatch TEXT DEFAULT 0,
    $isSerial TEXT DEFAULT 0,
    $lastModified TEXT DEFAULT ''    
    )
    ''');
  }

  Future<void> createItemBarcodeTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $barcodeTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $itemCode TEXT,
    $itemBarcode TEXT,
    $itemUom TEXT,
    $tempItem INTEGER DEFAULT 0
    )
    ''');
  }

  Future<void> createItemImageTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $imageTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $itemCode TEXT,
    $itemImage TEXT,
    $tempItem INTEGER DEFAULT 0
    )   
    ''');
  }

  Future<void> createCustomerTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $customerTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $customerCode TEXT, 
    $customerName TEXT,
    $customerName2 TEXT DEFAULT '',
    $customerPhone TEXT DEFAULT '',
    $customerMobile TEXT DEFAULT '',
    $customerEmail TEXT DEFAULT '',
    $customerAddress1 TEXT DEFAULT '',
    $customerAddress2 TEXT DEFAULT '',
    $customerAddress3 TEXT DEFAULT '',
    $customerAddress4 TEXT DEFAULT '',
    $posCode TEXT DEFAULT '',
    $city TEXT DEFAULT '',
    $state TEXT DEFAULT '',
    $country TEXT DEFAULT '',    
    $customerRegistrationNum TEXT DEFAULT '',
    $customerTin TEXT DEFAULT '',
    $customerSST TEXT DEFAULT '',
    $industryCode TEXT DEFAULT '00000',
    $customerStatus TEXT DEFAULT '',
    $priceTag TEXT DEFAULT ''
    )
    ''');

    //Create Index
    await db
        .execute("CREATE INDEX customer_idx ON $customerTable ($customerCode)");
  }

  Future<void> createUserTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $userTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $userKey TEXT,
    $userName TEXT,
    $password TEXT,
    $access INTEGER,
    $pin TEXT
    )
    ''');
  }

  Future<void> createBatchTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $batchTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,   
    $batchKey TEXT,
    $startCounter TEXT,
    $openCounterUser TEXT,
    $endCounter TEXT,
    $closeCounterUser TEXT
    )
    ''');
  }

  Future<void> createActivityTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $activityTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $userKey TEXT,
    $loginTime TEXT,
    $logoutTime TEXT
    )
    ''');
  }

  Future<void> createCashInOutTable(db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $cashInOutTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $docNo TEXT,
    $batchKey TEXT,
    $userKey TEXT,
    $performTime TEXT,
    $cashInOutAmount REAL,
    $reasonCode TEXT DEFAULT '',
    $reason TEXT,
    $isOpening INTEGER DEFAULT 0,
    $isClosing INTEGER DEFAULT 0,
    $attachment BLOB
    )
    ''');
  }

  Future<void> createMemberTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $memberTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $memberId TEXT, 
    $memberName TEXT, 
    $memberType TEXT,         
    $memberPhone TEXT,    
    $memberEmail TEXT,
    $memberAddress1 TEXT,
    $memberAddress2 TEXT,
    $memberAddress3 TEXT,
    $memberAddress4 TEXT,
    $memberIdentificationNum TEXT,
    $memberTin TEXT,  
    $expiryDate TEXT,   
    $isActive INTEGER
    )
    ''');
  }

  Future<void> createSyncRecord(db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $syncRecordTable (
        id integer primary key autoincrement,
        $docDate TEXT DEFAULT '',
        $docNo TEXT DEFAULT '',
        $docType TEXT DEFAULT '',
        $syncTime TEXT DEFAULT '',
        $status TEXT DEFAULT ''    
      )
    """);
  }

  Future<void> createSalesTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT, 
    $batchKey TEXT,
    $userKey TEXT,
    $invoiceDoc TEXT,    
    $customerKey TEXT,    
    $transactionId TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $status TEXT,    
    $createdAt TEXT DEFAULT CURRENT_TIMESTAMP,    
    $transactionAt TEXT,    
    $voucher TEXT,    
    $voucherAmount REAL DEFAULT 0.0,    
    $footerDiscountPercent INTEGER DEFAULT 0,    
    $footerDiscountValue REAL DEFAULT 0.0,    
    $isFooterDiscountPercent INTEGER DEFAULT 0,    
    $subtotal REAL DEFAULT 0.0,
    $total REAL DEFAULT 0.0,
    $roundedAmount REAL DEFAULT 0.0,
    $lastSync TEXT DEFAULT '',
    $returnUserKey TEXT DEFAULT '',
    $authorizeUserKey TEXT DEFAULT '',
    $returnSalesAt TEXT DEFAULT '',
        
    $customerName TEXT DEFAULT '',
    $customerAddress1 TEXT DEFAULT '',
    $customerAddress2 TEXT DEFAULT '',
    $customerAddress3 TEXT DEFAULT '',
    $customerAddress4 TEXT DEFAULT '',
    
    $customerPhone TEXT DEFAULT '',
    $customerEmail TEXT DEFAULT '',
    $customerTin TEXT DEFAULT '',
    $customerIcNum TEXT DEFAULT '',
    $customerSST TEXT DEFAULT '',
 
    $ezyPointEarnPoint REAL DEFAULT 0.0,
    $ezyPointRedeemPoint REAL DEFAULT 0.0,
    $ezyPointRedeemValue REAL DEFAULT 0.0,
    $ezyCreditValue REAL DEFAULT 0.0    
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_invNo ON $salesTable($invoiceDoc)
    ''');
  }

  Future<void> createSalesDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesDetailKey TEXT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $itemCode TEXT,
    $itemDesc TEXT DEFAULT '',
    $itemDesc2 TEXT DEFAULT '',    
    $quantity REAL DEFAULT 0.0,    
    $price REAL DEFAULT 0.0,    
    $totalAmount REAL,    
    $uom TEXT DEFAULT '',   
    $baseQty REAL DEFAULT 0.0, 
    $discountValue REAL DEFAULT 0.0,    
    $discountPercent INTEGER DEFAULT 0,    
    $isDiscountInPercent INTEGER DEFAULT 0,    
    $taxCode TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $taxRate INTEGER DEFAULT 0,
    $fromSalesKey TEXT DEFAULT '',
    $fromSalesDetailKey TEXT DEFAULT '',
    $promotionKey TEXT DEFAULT '',
    $promotionType TEXT DEFAULT '',
    $promotionDetailKey TEXT DEFAULT '',
    $promotionDiscount REAL DEFAULT 0.0
   
    )
    ''');
  }

  Future<void> createSalesOrderTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesOrderTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT, 
    $batchKey TEXT,
    $userKey TEXT,
    $invoiceDoc TEXT,    
    $customerKey TEXT,    
    $transactionId TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $status TEXT,    
    $createdAt TEXT DEFAULT CURRENT_TIMESTAMP,    
    $transactionAt TEXT,    
    $voucher TEXT,    
    $voucherAmount REAL DEFAULT 0.0,    
    $footerDiscountPercent INTEGER DEFAULT 0,    
    $footerDiscountValue REAL DEFAULT 0.0,    
    $isFooterDiscountPercent INTEGER DEFAULT 0,    
    $subtotal REAL DEFAULT 0.0,
    $total REAL DEFAULT 0.0,
    $roundedAmount REAL DEFAULT 0.0,
    $lastSync TEXT DEFAULT '',
    $returnUserKey TEXT DEFAULT '',
    $authorizeUserKey TEXT DEFAULT '',
    $returnSalesAt TEXT DEFAULT '',
        
    $customerName TEXT DEFAULT '',
    $customerAddress1 TEXT DEFAULT '',
    $customerAddress2 TEXT DEFAULT '',
    $customerAddress3 TEXT DEFAULT '',
    $customerAddress4 TEXT DEFAULT '',
    
    $customerPhone TEXT DEFAULT '',
    $customerEmail TEXT DEFAULT '',
    $customerTin TEXT DEFAULT '',
    $customerIcNum TEXT DEFAULT '',
    $customerSST TEXT DEFAULT '',
 
    $ezyPointEarnPoint REAL DEFAULT 0.0,
    $ezyPointRedeemPoint REAL DEFAULT 0.0,
    $ezyPointRedeemValue REAL DEFAULT 0.0,
    $ezyCreditValue REAL DEFAULT 0.0    
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_invNo ON $salesTable($invoiceDoc)
    ''');
  }

  Future<void> createSalesOrderDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesOrderDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesDetailKey TEXT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $itemCode TEXT,
    $itemDesc TEXT DEFAULT '',
    $itemDesc2 TEXT DEFAULT '',    
    $quantity REAL DEFAULT 0.0,    
    $price REAL DEFAULT 0.0,    
    $totalAmount REAL,    
    $uom TEXT DEFAULT '',   
    $baseQty REAL DEFAULT 0.0, 
    $discountValue REAL DEFAULT 0.0,    
    $discountPercent INTEGER DEFAULT 0,    
    $isDiscountInPercent INTEGER DEFAULT 0,    
    $taxCode TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $taxRate INTEGER DEFAULT 0,
    $fromSalesKey TEXT DEFAULT '',
    $fromSalesDetailKey TEXT DEFAULT '',
    $promotionKey TEXT DEFAULT '',
    $promotionType TEXT DEFAULT '',
    $promotionDetailKey TEXT DEFAULT '',
    $promotionDiscount REAL DEFAULT 0.0
   
    )
    ''');
  }

  Future<void> createInvoiceTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $invoiceTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT, 
    $batchKey TEXT,
    $userKey TEXT,
    $invoiceDoc TEXT,    
    $customerKey TEXT,    
    $transactionId TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $status TEXT,    
    $createdAt TEXT DEFAULT CURRENT_TIMESTAMP,    
    $transactionAt TEXT,    
    $voucher TEXT,    
    $voucherAmount REAL DEFAULT 0.0,    
    $footerDiscountPercent INTEGER DEFAULT 0,    
    $footerDiscountValue REAL DEFAULT 0.0,    
    $isFooterDiscountPercent INTEGER DEFAULT 0,    
    $subtotal REAL DEFAULT 0.0,
    $total REAL DEFAULT 0.0,
    $roundedAmount REAL DEFAULT 0.0,
    $lastSync TEXT DEFAULT '',
    $returnUserKey TEXT DEFAULT '',
    $authorizeUserKey TEXT DEFAULT '',
    $returnSalesAt TEXT DEFAULT '',
        
    $customerName TEXT DEFAULT '',
    $customerAddress1 TEXT DEFAULT '',
    $customerAddress2 TEXT DEFAULT '',
    $customerAddress3 TEXT DEFAULT '',
    $customerAddress4 TEXT DEFAULT '',
    
    $customerPhone TEXT DEFAULT '',
    $customerEmail TEXT DEFAULT '',
    $customerTin TEXT DEFAULT '',
    $customerIcNum TEXT DEFAULT '',
    $customerSST TEXT DEFAULT '',
 
    $ezyPointEarnPoint REAL DEFAULT 0.0,
    $ezyPointRedeemPoint REAL DEFAULT 0.0,
    $ezyPointRedeemValue REAL DEFAULT 0.0,
    $ezyCreditValue REAL DEFAULT 0.0    
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_invNo ON $salesTable($invoiceDoc)
    ''');
  }

  Future<void> createInvoiceDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $invoiceDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesDetailKey TEXT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $itemCode TEXT,
    $itemDesc TEXT DEFAULT '',
    $itemDesc2 TEXT DEFAULT '',    
    $quantity REAL DEFAULT 0.0,    
    $price REAL DEFAULT 0.0,    
    $totalAmount REAL,    
    $uom TEXT DEFAULT '',   
    $baseQty REAL DEFAULT 0.0, 
    $discountValue REAL DEFAULT 0.0,    
    $discountPercent INTEGER DEFAULT 0,    
    $isDiscountInPercent INTEGER DEFAULT 0,    
    $taxCode TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $taxRate INTEGER DEFAULT 0,
    $fromSalesKey TEXT DEFAULT '',
    $fromSalesDetailKey TEXT DEFAULT '',
    $promotionKey TEXT DEFAULT '',
    $promotionType TEXT DEFAULT '',
    $promotionDetailKey TEXT DEFAULT '',
    $promotionDiscount REAL DEFAULT 0.0
   
    )
    ''');
  }

  Future<void> createPendingSalesTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $pendingSalesTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT, 
    $batchKey TEXT,
    $userKey TEXT,
    $invoiceDoc TEXT,    
    $customerKey TEXT,    
    $transactionId TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $status TEXT,    
    $createdAt TEXT DEFAULT CURRENT_TIMESTAMP,    
    $transactionAt TEXT,    
    $voucher TEXT,    
    $voucherAmount REAL DEFAULT 0.0,    
    $footerDiscountPercent INTEGER DEFAULT 0,    
    $footerDiscountValue REAL DEFAULT 0.0,    
    $isFooterDiscountPercent INTEGER DEFAULT 0,    
    $subtotal REAL DEFAULT 0.0,
    $total REAL DEFAULT 0.0,
    $roundedAmount REAL DEFAULT 0.0,
    $lastSync TEXT DEFAULT '',
    $returnUserKey TEXT DEFAULT '',
    $authorizeUserKey TEXT DEFAULT '',
    $returnSalesAt TEXT DEFAULT '',
        
    $customerName TEXT DEFAULT '',
    $customerAddress1 TEXT DEFAULT '',
    $customerAddress2 TEXT DEFAULT '',
    $customerAddress3 TEXT DEFAULT '',
    $customerAddress4 TEXT DEFAULT '',
    
    $customerPhone TEXT DEFAULT '',
    $customerEmail TEXT DEFAULT '',
    $customerTin TEXT DEFAULT '',
    $customerIcNum TEXT DEFAULT '',
    $customerSST TEXT DEFAULT '',
 
    $ezyPointEarnPoint REAL DEFAULT 0.0,
    $ezyPointRedeemPoint REAL DEFAULT 0.0,
    $ezyPointRedeemValue REAL DEFAULT 0.0,
    $ezyCreditValue REAL DEFAULT 0.0   
    )
    ''');
  }

  Future<void> createPendingSalesDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $pendingSalesDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesDetailKey TEXT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $itemCode TEXT,
    $itemDesc TEXT DEFAULT '',
    $itemDesc2 TEXT DEFAULT '',    
    $quantity REAL DEFAULT 0.0,    
    $price REAL DEFAULT 0.0,    
    $totalAmount REAL,    
    $uom TEXT DEFAULT '',  
    $baseQty REAL DEFAULT 0.0,   
    $discountValue REAL DEFAULT 0.0,    
    $discountPercent INTEGER DEFAULT 0,    
    $isDiscountInPercent INTEGER DEFAULT 0,    
    $taxCode TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $taxRate INTEGER DEFAULT 0,
    $fromSalesKey TEXT DEFAULT '',
    $fromSalesDetailKey TEXT DEFAULT '',
    $promotionKey TEXT DEFAULT '',
    $promotionType TEXT DEFAULT '',
    $promotionDetailKey TEXT DEFAULT '',
    $promotionDiscount REAL DEFAULT 0.0
    )
    ''');
  }

  Future<void> createMenuHeaderTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $menuHeaderTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $headerId TEXT,
    $menuId TEXT,
    $menuSeq INTEGER,
    $itemType TEXT,
    $itemCode TEXT,
    $itemDesc TEXT,
    $itemUom TEXT,
    $textColor TEXT,
    $baseColor TEXT,
    $isWeightItem INTEGER DEFAULT 0
    )
    ''');
  }

  Future<void> createMenuDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $menuDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $headerId TEXT,
    $menuId TEXT,
    $menuSeq INTEGER,
    $itemType TEXT,
    $itemCode TEXT,
    $itemDesc TEXT,
    $itemUom TEXT,
    $textColor TEXT,
    $baseColor TEXT,
    $isWeightItem INTEGER DEFAULT 0
    )
    ''');
  }

  Future<void> createActivityBatchTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $activityBatchTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $activityKey TEXT, 
    $batchKey TEXT
    )
    ''');
  }

  Future<void> createCustomerInfoTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $customerInfoTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $customerEmail TEXT, 
    $whatsapp TEXT,
    $customerName TEXT
    )
    ''');
  }

  Future<void> createPromotionTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $promotionTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $promotionKey TEXT, 
    $priority INTEGER,
    $promotionCode TEXT, 
    $description TEXT, 
    $promotionType INTEGER, 
    $fromDate TEXT, 
    $toDate TEXT, 
    $fromTime TEXT, 
    $toTime TEXT, 
    $validDay1 INTEGER,
    $validDay2 INTEGER, 
    $validDay3 INTEGER, 
    $validDay4 INTEGER, 
    $validDay5 INTEGER, 
    $validDay6 INTEGER, 
    $validDay7 INTEGER, 
    $validNoneMember INTEGER,
    $validBirthday INTEGER,
    $validBirthdayMonth INTEGER
    )
    ''');
  }

  Future<void> createPromotionItemTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $promotionItemTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $promotionKey TEXT,
    $itemCode TEXT, 
    $uom TEXT,
    $minPurchaseQty NUMERIC(18,6), 
    $maxPurchaseQty NUMERIC(18,6),
    $unitPrice NUMERIC(18,6),
    $discount NUMERIC(18,6),
    $promoPrice NUMERIC(18,6)
    )
    ''');
  }

  Future<void> createPromotionMMTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $promotionMixMatchTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $pMixMatchKey TEXT,
    $promotionKey TEXT,
    $mixMatchDesc TEXT, 
    $type TEXT,
    $qty NUMERIC(18,6),
    $totalPrice NUMERIC(18,6),
    $unitPrice NUMERIC(18,6),
    $discount NUMERIC(18,6),  
    $onlyMatchQty INTEGER,
    $type2 TEXT,
    $qty2 NUMERIC(18,6),
    $totalPrice2 NUMERIC(18,6),
    $unitPrice2 NUMERIC(18,6),
    $discount2 NUMERIC(18,6),
    $onlyMatchQty2 INTEGER,
    $matchDifferentOnly INTEGER
    )
    ''');
  }

  Future<void> createPromotionMMDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $promotionMixMatchDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $pMixMatchDetailKey TEXT,
    $pMixMatchKey TEXT,
    $itemCode TEXT,
    $uom TEXT,
    $description TEXT
    )
    ''');
  }

  Future<void> createPromotionPWPTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $promotionPurchaseWithPurchaseTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $pPWPKey TEXT,
    $promotionKey TEXT,
    $pPWPDesc TEXT,
    $description TEXT,
    $type TEXT,
    $itemCode TEXT,
    $uom TEXT,
    $purchasedQty NUMERIC(18,6),
    $purchasedAmount NUMERIC(18,6),
    $matchOne INTEGER
    )
    ''');
  }

  Future<void> createPromotionPWPDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $promotionPurchaseWithPurchaseDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $pPWPDetailKey TEXT,
    $pPWPKey TEXT,
    $itemCode TEXT,
    $uom TEXT,
    $description TEXT,
    $isFOC INTEGER,
    $qty NUMERIC(18,6),
    $unitPrice NUMERIC(18,6),
    $discount NUMERIC(18,6)
    )
    ''');
  }

  Future<void> createScaleBarcodeSettingTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $scaleBarcodeSettingTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $barcodeLength INTEGER,
    $codeStart INTEGER,
    $codeEnd INTEGER,
    $qtyStart INTEGER,
    $qtyEnd INTEGER,
    $decimalDigit INTEGER
    
    )
    ''');
  }

  Future<void> createScaleBarcodeProfileTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $scaleBarcodeProfileTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $scaleBarcodeProfileKey INTEGER,
    $departmentCode TEXT,
    $departmentName TEXT
    )
    ''');
  }

  Future<void> createPaymentMethodTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $paymentMethodTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $paymentCode TEXT,
    $paymentType INTEGER,
    $paymentImage TEXT,
    $paymentDescription TEXT,
    $paymentNeedRef INTEGER,
    $paymentOpenDrawer INTEGER,
    $textColor TEXT,
    $baseColor TEXT,
    $useTerminal INTEGER,
    $terminalId TEXT,
    $refundPin TEXT,
    $storeId TEXT,
    $clientId TEXT,
    $clientKey TEXT,
    $privateKey TEXT,
    $publicKey TEXT,
    $usedCreditCard INTEGER,
    $usedEWallet INTEGER
    )
    ''');
  }

  Future<void> createSalesPaymentRecordTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesPaymentRecordTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $totalAmount REAL,
    $knockOffAmount REAL,
    $paidAmount REAL,
    $changeAmount REAL,
    $paymentCode TEXT,
    $reference TEXT,
    $paymentType INTEGER
    )
    ''');
  }

  Future<void> createSalesOrderPaymentTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesOrderPaymentTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $totalAmount REAL,
    $knockOffAmount REAL,
    $paidAmount REAL,
    $changeAmount REAL,
    $paymentCode TEXT,
    $reference TEXT,
    $paymentType INTEGER
    )
    ''');
  }

  Future<void> createInvoicePaymentTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $invoicePaymentTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $totalAmount REAL,
    $knockOffAmount REAL,
    $paidAmount REAL,
    $changeAmount REAL,
    $paymentCode TEXT,
    $reference TEXT,
    $paymentType INTEGER
    )
    ''');
  }

  Future<void> createStockTransactionTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $stockTransactionTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $itemCode TEXT,
    $postDate TEXT,
    $docType TEXT,
    $docKey TEXT,
    $docDtlKey TEXT,
    $qty REAL,
    $batchKey TEXT DEFAULT ''
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_docKey ON $stockTransactionTable($docKey)
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_itemCode ON $stockTransactionTable($itemCode)
    ''');
  }

  Future<void> createStockAdjustmentTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $stockAdjustmentTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $docNo TEXT,
    $docDate TEXT,
    $description TEXT,
    $userKey TEXT,
    $isActive INTEGER DEFAULT 1,
    $lastUpdate TEXT DEFAULT CURRENT_TIMESTAMP
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_adjHdrDocNo ON $stockAdjustmentTable($docNo)
    ''');
  }

  Future<void> createStockAdjustmentDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $stockAdjustmentDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $docNo TEXT,
    $itemCode TEXT,
    $itemDesc TEXT,
    $qty REAL,
    $uom TEXT,
    $rate REAL,
    $stdQty REAL,
    $unitPrice REAL
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_adjDtlItemCode ON $stockAdjustmentDetailTable($itemCode)
    ''');
  }

  Future<void> createEInvoiceTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $eInvoiceTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,    
    $docDate TEXT,
    $docType TEXT,
    $docNo TEXT,
    $syncTime TEXT DEFAULT '',
    $status TEXT DEFAULT '',
    $eInvoiceNum TEXT DEFAULT '',
    $eInvoiceRemark TEXT DEFAULT ''
    )
    ''');
  }

  Future<void> createSalesReturnTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesReturnTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT, 
    $batchKey TEXT,
    $userKey TEXT,
    $invoiceDoc TEXT,    
    $customerKey TEXT,    
    $transactionId TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $status TEXT,    
    $createdAt TEXT DEFAULT CURRENT_TIMESTAMP,    
    $transactionAt TEXT,    
    $voucher TEXT,    
    $voucherAmount REAL DEFAULT 0.0,    
    $footerDiscountPercent INTEGER DEFAULT 0,    
    $footerDiscountValue REAL DEFAULT 0.0,    
    $isFooterDiscountPercent INTEGER DEFAULT 0,    
    $subtotal REAL DEFAULT 0.0,
    $total REAL DEFAULT 0.0,
    $roundedAmount REAL DEFAULT 0.0,
    $lastSync TEXT DEFAULT '',
    $returnUserKey TEXT DEFAULT '',
    $authorizeUserKey TEXT DEFAULT '',
    $returnSalesAt TEXT DEFAULT '',
        
    $customerName TEXT DEFAULT '',
    $customerAddress1 TEXT DEFAULT '',
    $customerAddress2 TEXT DEFAULT '',
    $customerAddress3 TEXT DEFAULT '',
    $customerAddress4 TEXT DEFAULT '',
    
    $customerPhone TEXT DEFAULT '',
    $customerEmail TEXT DEFAULT '',
    $customerTin TEXT DEFAULT '',
    $customerIcNum TEXT DEFAULT '',
    $customerSST TEXT DEFAULT '',
 
    $ezyPointEarnPoint REAL DEFAULT 0.0,
    $ezyPointRedeemPoint REAL DEFAULT 0.0,
    $ezyPointRedeemValue REAL DEFAULT 0.0,
    $ezyCreditValue REAL DEFAULT 0.0
    )
    ''');

    await db.rawQuery('''
    CREATE INDEX IF NOT EXISTS idx_invNo ON $salesReturnTable($invoiceDoc)
    ''');
  }

  Future<void> createReturnDetailTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $salesReturnDetailTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesDetailKey TEXT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $itemCode TEXT,
    $itemDesc TEXT DEFAULT '',
    $itemDesc2 TEXT DEFAULT '',    
    $quantity REAL DEFAULT 0.0,    
    $price REAL DEFAULT 0.0,    
    $totalAmount REAL,    
    $uom TEXT DEFAULT '',    
    $baseQty REAL DEFAULT 0.0, 
    $discountValue REAL DEFAULT 0.0,    
    $discountPercent INTEGER DEFAULT 0,    
    $isDiscountInPercent INTEGER DEFAULT 0,    
    $taxCode TEXT,    
    $taxAmount REAL DEFAULT 0.0,    
    $taxRate INTEGER DEFAULT 0,
    $fromSalesKey TEXT DEFAULT '',
    $fromSalesDetailKey TEXT DEFAULT '',
    $promotionKey TEXT DEFAULT '',
    $promotionType TEXT DEFAULT '',
    $promotionDetailKey TEXT DEFAULT '',
    $promotionDiscount REAL DEFAULT 0.0
    )
    ''');
  }

  Future<void> createSalesRefundRecordTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $refundTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $salesKey TEXT,
    $invoiceDoc TEXT,
    $totalAmount REAL,
    $knockOffAmount REAL,
    $paidAmount REAL,
    $changeAmount REAL,
    $paymentCode TEXT,
    $reference TEXT,
    $paymentType INTEGER
    )
    ''');
  }

  Future<void> createSyncMemberTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $syncMemberTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $docNo TEXT,
    $docAmount REAL,
    $description TEXT,
    $memberId TEXT,
    $memberPoint TEXT,
    $counter TEXT,
    $docDate TEXT,
    $status TEXT,
    $syncTime TEXT
    )
    ''');
  }

  Future<void> createCashIOReasonTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $cashInOutReasonTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    $reasonCode TEXT,
    $reasonDesc TEXT,
    $isCashIn INTEGER,
    $isCashOut INTEGER
    )   
    ''');
  }

  Future<void> createTaxTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $taxTable(
    Id INTEGER PRIMARY KEY AUTOINCREMENT, 
    $taxCode TEXT,
    $taxDesc TEXT,
    $taxRate TEXT,
    $tariffCode TEXT,
    $taxIncl INTEGER DEFAULT 0,
    $defaultTax INTEGER DEFAULT 0
    )
    ''');
  }

  Future<bool> dropProfileTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $companyProfileTable");

      await createProfileTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropActivityTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $activityTable");

      await createActivityTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropActivityBatchTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $activityBatchTable");

      await createActivityBatchTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropBatchTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $batchTable");

      await createBatchTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropCashInOutTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $cashInOutTable");

      await createCashInOutTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropCustomerInfoTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $customerInfoTable");

      await createCustomerInfoTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropCustomerTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $customerTable");

      await createCustomerTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropBarcodeTbl() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.rawQuery("DROP INDEX IF EXISTS itemBarcode_idx");
      await db.execute("DROP TABLE IF EXISTS $barcodeTable");

      createItemBarcodeTable(db);

      await db.rawQuery(
          "CREATE INDEX itemBarcode_idx ON $barcodeTable ($itemBarcode)");
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropMenuHeaderTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $menuHeaderTable");

      await createMenuHeaderTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Menu Detail Table
  Future<bool> dropMenuDetailTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $menuDetailTable");

      await createMenuDetailTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropItemTbl() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.rawQuery("DROP INDEX IF EXISTS itemMast_idx");
      await db.execute("DROP TABLE IF EXISTS $itemTable");

      // createItemMasterTable(db);
      await createItemMasterTable(db);

      await db.rawQuery("CREATE INDEX itemMast_idx ON $itemTable ($itemCode)");
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropMemberTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $memberTable");

      await createMemberTable(db);
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Pending Sales Table
  Future<bool> dropPendingSalesTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $pendingSalesTable");

      //Create Pending Sales Table
      await createPendingSalesTable(db);

      await Future.delayed(const Duration(milliseconds: 500));
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Pending Sales Detail Table
  Future<bool> dropPendingSalesDetailTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $pendingSalesDetailTable");

      //Create Pending Sales Detail Table
      await createPendingSalesDetailTable(db);

      await Future.delayed(const Duration(milliseconds: 500));
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropSyncRecord() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $syncRecordTable");
      await createSyncRecord(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Sales Table
  Future<bool> dropSalesTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $salesTable");
      await createSalesTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Sales Detail Table
  Future<bool> dropSalesDetailTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $salesDetailTable");
      await createSalesDetailTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Invoice Table
  Future<bool> dropInvoiceTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $invoiceTable");
      await createInvoiceTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Invoice Detail Table
  Future<bool> dropInvoiceDetailTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $invoiceDetailTable");
      await createInvoiceDetailTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Sales Order Table
  Future<bool> dropSalesOrderTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $salesOrderTable");
      await createSalesOrderTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Sales Detail Table
  Future<bool> dropSalesOrderDetailTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $salesOrderDetailTable");
      await createSalesOrderDetailTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Promotion Table
  Future<bool> dropPromotionTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $promotionTable");
      await db.execute("DROP TABLE IF EXISTS $promotionItemTable");
      await db.execute("DROP TABLE IF EXISTS $promotionMixMatchTable");
      await db.execute("DROP TABLE IF EXISTS $promotionMixMatchDetailTable");
      await db
          .execute("DROP TABLE IF EXISTS $promotionPurchaseWithPurchaseTable");
      await db.execute(
          "DROP TABLE IF EXISTS $promotionPurchaseWithPurchaseDetailTable");

      await createPromotionTable(db);
      await createPromotionItemTable(db);
      await createPromotionMMTable(db);
      await createPromotionMMDetailTable(db);
      await createPromotionPWPTable(db);
      await createPromotionPWPDetailTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropScaleBarcodeTbl() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $scaleBarcodeSettingTable");

      await createScaleBarcodeSettingTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropScaleProfileTbl() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $scaleBarcodeProfileTable");

      await createScaleBarcodeProfileTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropUserTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $userTable");

      await createUserTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropPaymentMethodTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $paymentMethodTable");

      await createPaymentMethodTable(db);

      result = true;
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $s');
    }
    return result;
  }

  Future<bool> dropSalesPaymentRecordTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $salesPaymentRecordTable");

      await createSalesPaymentRecordTable(db);

      result = true;
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $s');
    }
    return result;
  }

  Future<bool> dropSalesOrderPaymentTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $salesOrderPaymentTable");

      await createSalesOrderPaymentTable(db);

      result = true;
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $s');
    }
    return result;
  }

  Future<bool> dropInvoicePaymentTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $invoicePaymentTable");

      await createInvoicePaymentTable(db);

      result = true;
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $s');
    }
    return result;
  }

  Future<bool> dropStockTransactionTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      // await db.rawQuery("DROP INDEX IF EXISTS idx_docKey");
      // await db.rawQuery("DROP INDEX IF EXISTS idx_itemCode");
      await db.execute("DROP TABLE IF EXISTS $stockTransactionTable");

      await createStockTransactionTable(db);
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropStockAdjustmentTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.rawQuery("DROP INDEX IF EXISTS idx_adjHdrDocNo");
      await db.rawQuery("DROP INDEX IF EXISTS idx_adjDtlItemCode");

      await db.execute("DROP TABLE IF EXISTS $stockAdjustmentTable");
      await db.execute("DROP TABLE IF EXISTS $stockAdjustmentDetailTable");

      await createStockAdjustmentTable(db);
      await createStockAdjustmentDetailTable(db);

      await Future.delayed(const Duration(milliseconds: 100));
      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  // Future<bool> dropStockAdjustmentDetailTable() async {
  //   bool result = false;
  //   try {
  //     Database db = await instance.database;
  //     // await db.rawQuery("DROP INDEX IF EXISTS idx_itemCode");
  //     await db.execute("DROP TABLE IF EXISTS $stockAdjustmentDetailTable");
  //
  //     await createStockAdjustmentDetailTable(db);
  //     result = true;
  //   } catch (e) {
  //     debugPrint('$e');
  //   }
  //   return result;
  // }

  Future<bool> dropImageTbl() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.rawQuery("DROP INDEX IF EXISTS itemImg_idx");
      await db.execute("DROP TABLE IF EXISTS $imageTable");
      await createItemImageTable(db);
      await db.rawQuery("CREATE INDEX itemImg_idx ON $imageTable ($itemCode)");
      result = true;
    } catch (e) {
      result = false;
    }

    return result;
  }

  Future<bool> dropEInvoiceTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $eInvoiceTable");

      await createEInvoiceTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropSalesReturnTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $salesReturnTable");

      await createSalesReturnTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropReturnDetailTable() async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.execute("DROP TABLE IF EXISTS $salesReturnDetailTable");

      await createReturnDetailTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> dropSalesRefundRecordTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $refundTable");

      await createSalesRefundRecordTable(db);

      result = true;
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $s');
    }
    return result;
  }

  //Drop Sales Detail Table
  Future<bool> dropSyncMemberTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $syncMemberTable");
      await createSyncMemberTable(db);
      //Create Pending Sales Detail Table

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Cash In Out Reason
  Future<bool> dropCashInOutReasonTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $cashInOutReasonTable");

      await createCashIOReasonTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  //Drop Tax Table
  Future<bool> dropTaxTable() async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.execute("DROP TABLE IF EXISTS $taxTable");

      await createTaxTable(db);

      result = true;
    } catch (e) {
      debugPrint('$e');
    }
    return result;
  }

  Future<bool> insertCompanyProfile(CompanyProfileModel compProfile) async {
    bool result = false;
    try {
      Database db = await instance.database;

      db.insert(companyProfileTable, compProfile.toDB());

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }
    return result;
  }

  Future<bool> insertUserList(List<UsersModel> userList) async {
    bool result = false;
    try {
      Database db = await instance.database;

      String insertQuery =
          "INSERT Into $userTable($userKey, $userName, $password, $access, $pin)"
          " VALUES (?, ?, ?, ?, ?)";

      for (UsersModel user in userList) {
        await db.rawInsert(insertQuery, [
          user.userKey,
          user.name,
          user.password,
          user.access,
          user.pin,
        ]);
      }

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> updateCompanyProfileWhenCheck(
      CompanyProfileModel compProfile) async {
    bool result = false;
    try {
      Database db = await instance.database;

      var temp = await db.rawQuery("SELECT * FROM $companyProfileTable");

      if (temp.isEmpty) {
        db.insert(companyProfileTable, compProfile.toDB());
      } else {
        db.rawUpdate(
            "UPDATE $companyProfileTable SET $companyName = ?, $token = ?, $companyTaxNo = ?, $companyRoc = ?, $companyTin = ?, $companyAddress1 = ?, $companyAddress2 = ?, $companyAddress3 = ?, $companyAddress4 = ?, $companyPhone = ?,  $companyEmail = ?",
            [
              compProfile.name,
              compProfile.token,
              compProfile.tax,
              compProfile.roc,
              compProfile.tin,
              compProfile.add1,
              compProfile.add2,
              compProfile.add3,
              compProfile.add4,
              compProfile.phone,
              compProfile.email
            ]);
      }

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllItemImage() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp = [];

    try {
      String query = "SELECT * FROM $imageTable";
      temp = await db.rawQuery(query);
    } catch (e) {
      debugPrint(e.toString());
    }
    return temp;
  }

  Future<bool> updateImageTable(String imgCode, String img64) async {
    Database db = await instance.database;
    bool result = false;

    try {
      String query =
          "UPDATE $imageTable SET $itemImage = ? WHERE $itemCode = ?";
      await db.rawUpdate(query, [img64, imgCode]);
      result = true;
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllPaymentImage() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp = [];

    try {
      String query =
          "SELECT $paymentCode, $paymentImage FROM $paymentMethodTable WHERE $paymentImage != ''";
      temp = await db.rawQuery(query);
    } catch (e) {
      debugPrint(e.toString());
    }
    return temp;
  }

  Future<bool> updatePaymentImage(String imgCode, String img64) async {
    Database db = await instance.database;
    bool result = false;

    try {
      String query =
          "UPDATE $paymentMethodTable SET $paymentImage = ? WHERE $paymentCode = ?";
      await db.rawUpdate(query, [img64, imgCode]);
      result = true;
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return result;
  }

  Future<CompanyProfileModel?> getCompanyProfile() async {
    try {
      Database db = await instance.database;
      String queryString =
          "SELECT DISTINCT * FROM $companyProfileTable LIMIT 1";

      var result = await db.rawQuery(queryString);

      if (result.isNotEmpty) {
        for (var item in result) {
          return CompanyProfileModel.fromDB(item);
        }
      }
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }
    return null;
  }

  Future<bool> insertPaymentMethod(List<PaymentMethodModel> paymentList) async {
    bool result = false;
    try {
      Database db = await instance.database;
      String insertQuery =
          "INSERT Into $paymentMethodTable($paymentCode, $paymentType, $paymentImage, $paymentDescription, $paymentNeedRef, $paymentOpenDrawer, $textColor, $baseColor, $useTerminal, $terminalId, $refundPin, $storeId, $clientId, $clientKey, $privateKey, $publicKey, $usedCreditCard, $usedEWallet)"
          " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

      for (PaymentMethodModel payment in paymentList) {
        await db.rawInsert(insertQuery, [
          payment.code,
          payment.paymentType,
          payment.imgString,
          payment.description,
          (payment.rReference ? 1 : 0),
          (payment.rDrawer ? 1 : 0),
          payment.textColor,
          payment.baseColor,
          (payment.useTerminal ? 1 : 0),
          payment.terminalKey,
          payment.refundPin,
          payment.storeId,
          payment.clientId,
          payment.clientKey,
          payment.privateKey,
          payment.publicKey,
          (payment.useCreditCard ? 1 : 0),
          (payment.useQrPay ? 1 : 0),
        ]);
      }

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> insertCompanyLogo(Uint8List imgByte) async {
    bool result = false;

    try {
      Database db = await instance.database;

      String sql = "UPDATE $companyProfileTable SET $companyLogo = ?";
      await db.rawUpdate(sql, [imgByte]);

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> resetAdminPassword(String newPassword) async {
    bool result = false;
    try {
      Database db = await instance.database;

      await db.rawUpdate(
          "UPDATE $userTable SET $password = ? WHERE $userKey = ?",
          [newPassword, "ADMIN"]);

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }
    return result;
  }

  Future<bool> batchInsertTax(List<TaxObject> taxList) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var taxObj in taxList) {
          batch.insert(taxTable, taxObj.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> insertCashIReason(List<CashIoReasonModel> reasons) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var reason in reasons) {
          batch.insert(cashInOutReasonTable, reason.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> insertItem(List<ItemMasterModel> items) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var item in items) {
          batch.insert(itemTable, item.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> insertItemBarcode(List<ItemBarcodeModel> itemBarcodeList) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var item in itemBarcodeList) {
          batch.insert(barcodeTable, item.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }
    return result;
  }

  Future<bool> insertItemMenuHeader(List<ItemMenuModel> itemHdr) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var item in itemHdr) {
          batch.insert(menuHeaderTable, item.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }
    return result;
  }

  Future<bool> insertItemMenuDetail(List<ItemMenuModel> itemDtl) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var item in itemDtl) {
          batch.insert(menuDetailTable, item.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }
    return result;
  }

  Future<bool> insertItemImage(String codeData, String imagePath) async {
    bool result = false;
    try {
      Database db = await instance.database;
      await db.transaction((txn) async {
        String query = "INSERT INTO $imageTable($itemCode, $itemImage)"
            " VALUES (?, ?)";
        await txn.rawInsert(query, [codeData, imagePath]);
      });
      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<List<CashIOModel>> getCashIOBySession(String batch) async {
    List<CashIOModel> cashIo = [];

    Database db = await instance.database;
    List<Map<String, dynamic>> temp;

    temp = await db.rawQuery(
        "SELECT m.* FROM $cashInOutTable m WHERE m.$batchKey = '$batch'");
    if (temp.isNotEmpty) {
      cashIo = temp.map((menu) => CashIOModel.fromDB(menu)).toList();
    }

    return cashIo;
  }

  Future<CashIOObject?> getBatchIOAmount(String batchCode) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp = [];

    CashIOObject? resultObject;

    try {
      String query =
          "SELECT * FROM $cashInOutTable WHERE $batchKey = '$batchCode'";
      temp = await db.rawQuery(query);

      double openingAmount = 0.0;
      double closingAmount = 0.0;
      double cashInAmount = 0.0;
      double cashOutAmount = 0.0;

      if (temp.isNotEmpty) {
        for (var item in temp) {
          if (item[cashInOutAmount] > 0) {
            if (item[isOpening] == 1) {
              openingAmount = openingAmount + item[cashInOutAmount];
            } else {
              cashInAmount = cashInAmount + item[cashInOutAmount];
            }
          } else {
            if (item[isClosing] == 1) {
              closingAmount = closingAmount + item[cashInOutAmount];
            } else {
              cashOutAmount = cashOutAmount + item[cashInOutAmount];
            }
          }
        }

        resultObject = CashIOObject(
            batchKey: batchCode,
            openingAmount: openingAmount,
            closingAmount: closingAmount,
            cashInAmount: cashInAmount,
            cashOutAmount: cashOutAmount);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return resultObject;
  }

  Future<List<ShiftObject>> getSingleShift(String batch) async {
    List<ShiftObject> result = [];
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.rawQuery(
          "SELECT a.*, (SELECT $userName FROM $userTable WHERE $userKey = a.$openCounterUser) AS OPENUSER, (SELECT $userName FROM $userTable WHERE $userKey = a.$closeCounterUser) AS CLOSEUSER FROM $batchTable a WHERE a.$batchKey = '$batch'");

      if (temp.isNotEmpty) {
        result = temp.map((menu) => ShiftObject.fromDB(menu)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<FullSalesDoc?> getSalesDocByDocNum(String docNum) async {
    FullSalesDoc result;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter, c.* FROM $salesTable a LEFT JOIN $batchTable b ON a.$batchKey = b.$batchKey LEFT JOIN $userTable c ON a.$userKey = c.$userKey WHERE a.$invoiceDoc = '$docNum'");

      if (temp.isNotEmpty) {
        result = FullSalesDoc.fromDB(temp[0]);

        List<SalesDetail> docDtl = [];
        List<SalesPaymentRecord> payDtl = [];
        temp = await db.rawQuery(
            "SELECT a.*, b.$itemImage FROM $salesDetailTable a LEFT JOIN $imageTable b ON b.$itemCode = a.$itemCode WHERE a.$salesKey = '${result.salesKey}'");

        if (temp.isNotEmpty) {
          docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

          result.salesDetails = docDtl;
        }

        temp = await db.rawQuery(
            "SELECT * FROM $salesPaymentRecordTable WHERE $invoiceDoc = '${result.invoiceDoc.trim()}'");

        if (temp.isNotEmpty) {
          payDtl = temp
              .map((payItem) => SalesPaymentRecord.fromDB(payItem))
              .toList();

          result.salesPayment = payDtl;
        }

        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return null;
  }

  Future<FullSalesDoc?> getReturnDocByDocNum(String docNum) async {
    FullSalesDoc result;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter, c.* FROM $salesReturnTable a LEFT JOIN $batchTable b ON a.$batchKey = b.$batchKey LEFT JOIN $userTable c ON a.$userKey = c.$userKey WHERE a.$invoiceDoc = '$docNum'");

      if (temp.isNotEmpty) {
        result = FullSalesDoc.fromDB(temp[0]);

        List<SalesDetail> docDtl = [];
        List<SalesPaymentRecord> payDtl = [];
        temp = await db.rawQuery(
            "SELECT a.*, b.$itemImage FROM $salesReturnDetailTable a LEFT JOIN $imageTable b ON b.$itemCode = a.$itemCode WHERE a.$salesKey = '${result.salesKey}'");

        if (temp.isNotEmpty) {
          docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

          result.salesDetails = docDtl;
        }

        temp = await db.rawQuery(
            "SELECT * FROM $refundTable WHERE $invoiceDoc = '${result.invoiceDoc.trim()}'");

        if (temp.isNotEmpty) {
          payDtl = temp
              .map((payItem) => SalesPaymentRecord.fromDB(payItem))
              .toList();

          result.salesPayment = payDtl;
        }

        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return null;
  }

  Future<FullSalesDoc?> getSalesDocBySalesKey(String key) async {
    FullSalesDoc result;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter, c.* FROM $salesTable a LEFT JOIN $batchTable b ON a.$batchKey = b.$batchKey LEFT JOIN $userTable c ON a.$userKey = c.$userKey WHERE a.$salesKey = '$key'");

      if (temp.isNotEmpty) {
        result = FullSalesDoc.fromDB(temp[0]);

        List<SalesDetail> docDtl = [];
        List<SalesPaymentRecord> payDtl = [];
        temp = await db.rawQuery(
            "SELECT a.*, b.$itemImage FROM $salesDetailTable a LEFT JOIN $imageTable b ON b.$itemCode = a.$itemCode WHERE a.$salesKey = '${result.salesKey}'");

        if (temp.isNotEmpty) {
          docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

          result.salesDetails = docDtl;
        }

        temp = await db.rawQuery(
            "SELECT * FROM $salesPaymentRecordTable WHERE $invoiceDoc = '${result.invoiceDoc.trim()}'");

        if (temp.isNotEmpty) {
          payDtl = temp
              .map((payItem) => SalesPaymentRecord.fromDB(payItem))
              .toList();

          result.salesPayment = payDtl;
        }

        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }
    return null;
  }

  Future<double> getTotalSalesAmount(String batchCode) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp = [];
    double result = 0;

    try {
      String query =
          "SELECT COALESCE(SUM($total), 0.0) AS TOTAL FROM $salesTable WHERE $batchKey = '$batchCode'";
      temp = await db.rawQuery(query);

      if (temp.isNotEmpty) {
        result = temp.first['TOTAL'];
      }

      query =
      "SELECT COALESCE(SUM($total), 0.0) AS TOTAL FROM $salesReturnTable WHERE $batchKey = '$batchCode'";
      temp = await db.rawQuery(query);

      if (temp.isNotEmpty) {
        result = result - temp.first['TOTAL'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<List<CheckOutPaymentObject>> getClosingPaymentSummary(
      String batchCode) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> tempPayType = [];
    List<Map<String, dynamic>> tempPayRec = [];
    List<CheckOutPaymentObject> result = [];

    try {
      String query = "SELECT a.* FROM $paymentMethodTable a";
      tempPayType = await db.rawQuery(query);

      if (tempPayType.isNotEmpty) {
        for (var item in tempPayType) {
          String payCode = item[paymentCode];

          String itemQuery =
              "SELECT COALESCE(SUM(a.$knockOffAmount), 0.0) AS $totalAmount, COALESCE(COUNT(a.$paymentCode), 0) AS TOTALSALES FROM $salesPaymentRecordTable a JOIN $salesTable b ON a.$invoiceDoc = b.$invoiceDoc WHERE a.$paymentCode = '$payCode' AND b.$batchKey = '$batchCode'";

          tempPayRec = await db.rawQuery(itemQuery);

          if (tempPayRec.isNotEmpty) {
            for (var rec in tempPayRec) {
              CheckOutPaymentObject paymentObject = CheckOutPaymentObject(
                  batchKey: batchCode,
                  code: payCode,
                  description: item[paymentDescription],
                  paymentType: item[paymentType],
                  salesCount: rec['TOTALSALES'],
                  returnCount: 0,
                  salesAmount: rec[totalAmount],
                  returnAmount: 0.0,
                  totalAmount: rec[totalAmount]);

              result.add(paymentObject);
            }
          }

          itemQuery =
          "SELECT COALESCE(SUM(a.$totalAmount), 0.0) AS $totalAmount, COALESCE(COUNT(a.$paymentCode), 0) AS TOTALRETURN FROM $refundTable a JOIN $salesReturnTable b ON a.$invoiceDoc = b.$invoiceDoc WHERE a.$paymentCode = '$payCode' AND b.$batchKey = '$batchCode'";

          tempPayRec = await db.rawQuery(itemQuery);

          if (tempPayRec.isNotEmpty) {
            for (var rec in tempPayRec) {
              CheckOutPaymentObject? paymentObject =
              result.firstWhere((item) => item.code == payCode);

              if (paymentObject != null) {
                paymentObject.returnCount = rec['TOTALRETURN'];
                paymentObject.returnAmount = rec[totalAmount];
                paymentObject.totalAmount =
                    paymentObject.totalAmount - rec[totalAmount];
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<SalesAndReturnModel?> getItemSalesAndReturnSumReport(
      String batch) async {
    SalesAndReturnModel? result;
    List<ItemSummaryReportModel> salesResult = [];
    List<ItemSummaryReportModel> returnResult = [];

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp = [];

      temp = await db.rawQuery(
          "SELECT b.$batchKey, a.$itemCode, c.$itemDesc, c.$itemUom, SUM(a.$quantity * (SELECT $uomQTY FROM $itemTable WHERE $itemCode = a.$itemCode AND $itemUom = a.$uom)) AS $quantity, SUM(a.$totalAmount) AS $totalAmount FROM $salesDetailTable a JOIN $salesTable b ON a.$salesKey = b.$salesKey JOIN $itemTable c ON a.$itemCode = c.$itemCode WHERE b.$batchKey = '$batch' AND c.$baseUom = c.$itemUom GROUP BY b.$batchKey, a.$itemCode, c.$itemDesc, a.$uom");
      if (temp.isNotEmpty) {
        salesResult =
            temp.map((menu) => ItemSummaryReportModel.fromDB(menu)).toList();
      }

      temp = [];

      temp = await db.rawQuery(
          "SELECT b.$batchKey, a.$itemCode, c.$itemDesc, c.$itemUom, SUM(a.$quantity * (SELECT $uomQTY FROM $itemTable WHERE $itemCode = a.$itemCode AND $itemUom = a.$uom)) AS $quantity, SUM(a.$totalAmount) AS $totalAmount FROM $salesReturnDetailTable a JOIN $salesReturnTable b ON a.$salesKey = b.$salesKey JOIN $itemTable c ON a.$itemCode = c.$itemCode WHERE b.$batchKey = '$batch' AND c.$baseUom = c.$itemUom GROUP BY b.$batchKey, a.$itemCode, c.$itemDesc, a.$uom");
      if (temp.isNotEmpty) {
        returnResult =
            temp.map((menu) => ItemSummaryReportModel.fromDB(menu)).toList();
      }

      result = SalesAndReturnModel(
        salesList: salesResult,
        returnList: returnResult,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<Uint8List?> getCompanyLogo() async {
    Uint8List? result;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;
      temp = await db
          .rawQuery("SELECT $companyLogo FROM $companyProfileTable LIMIT 1");
      if (temp.isNotEmpty) {
        result = temp[0][companyLogo];
      }
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> isColumnExist(String tableName, String columnName) async {
    Database db = await instance.database;
    // Query the table's columns
    List<Map<String, dynamic>> result =
    await db.rawQuery("PRAGMA table_info($tableName)");

    // Check if the column is present
    for (var column in result) {
      if (column['name'] == columnName) {
        return true;
      }
    }

    return false;
  }

  Future<bool> clearPendingLog() async {
    bool result = false;
    List<Map<String, dynamic>> temp = [];

    try {
      Database db = await instance.database;
      String query = "SELECT * FROM $syncRecordTable";
      temp = await db.rawQuery(query);

      if (temp.isNotEmpty) {
        await dropSyncRecord();
      }

      result = true;
    } catch (e) {
      result = false;
    }

    return result;
  }

  Future<bool> insertPromotion(List<PromotionModel> promoList) async {
    bool result = false;
    try {
      await dropPromotionTable();
      Database db = await instance.database;

      if (promoList.isNotEmpty) {
        for (PromotionModel item in promoList) {
          await db.insert(promotionTable, item.toDB());
          for (ItemPromotion subItem in item.itemPromotion) {
            await db.insert(promotionItemTable, subItem.toDB());
          }
        }
      }
      result = true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return result;
  }

  Future<bool> insertCustomers(List<CustomerModel> customers) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var customerList in customers) {
          batch.insert(customerTable, customerList.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> insertEzyMember(List<MemberModel> members) async {
    bool result = false;

    try {
      Database db = await instance.database;

      await db.transaction((txn) async {
        var batch = txn.batch();

        for (var member in members) {
          batch.insert(memberTable, member.toDB());
        }

        await batch.commit();
      });

      result = true;
    } catch (e) {
      Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  Future<bool> fastInsertItem(List<ItemMasterModel> items) async {
    bool result = false;

    try {
      Database db = await instance.database;
      List<String> itemCodes = [];
      for (var item in items) {
        itemCodes.add(item.itemCode);
      }

      List<String> uniqueList = removeDuplicates(itemCodes);

      for (String tmp in uniqueList) {
        await db.delete(itemTable, where: '$itemCode = ?', whereArgs: [tmp]);
        await db.delete(barcodeTable, where: '$itemCode = ?', whereArgs: [tmp]);
        await db.delete(imageTable, where: '$itemCode = ?', whereArgs: [tmp]);
        await ImageHelper.removeItemImage(tmp);
      }

      for (var item in items) {
        await db.insert(itemTable, item.toDB());
      }

      result = true;
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()));
    }

    return result;
  }

  List<String> removeDuplicates(List<String> list) {
    return list.toSet().toList();
  }

  Future<int> getTotalUploadRecordsSalesByDate(
      DateTime startDate, DateTime endDate) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    int? result = 0;

    String formattedStartDate = startDate.toIso8601String();
    String formattedEndDate = endDate.toIso8601String();

    try {
      temp = await db.rawQuery(
          "SELECT COUNT(*) as count FROM $salesTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE b.$startCounter BETWEEN '$formattedStartDate' AND '$formattedEndDate'");
      if (temp.isNotEmpty) {
        result = Sqflite.firstIntValue(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result ?? 0;
  }

  Future<List<FullSalesDoc>> getAllSalesDocListByDate(int itemBatch,
      int itemLimit, DateTime startDate, DateTime endDate) async {
    List<FullSalesDoc> result = [];

    int batchCount = itemLimit * itemBatch;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      String formattedStartDate = startDate.toIso8601String();
      String formattedEndDate = endDate.toIso8601String();

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter FROM $salesTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE b.$startCounter BETWEEN '$formattedStartDate' AND '$formattedEndDate' ORDER BY a.id LIMIT $itemLimit OFFSET $batchCount");
      if (temp.isNotEmpty) {
        result = temp.map((menu) => FullSalesDoc.fromDB(menu)).toList();

        for (FullSalesDoc doc in result) {
          List<SalesDetail> docDtl = [];
          List<SalesPaymentRecord> payDtl = [];
          temp = await db.rawQuery(
              "SELECT * FROM $salesDetailTable WHERE $salesKey = '${doc.salesKey}'");

          if (temp.isNotEmpty) {
            docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

            doc.salesDetails = docDtl;
          }

          temp = await db.rawQuery(
              "SELECT * FROM $salesPaymentRecordTable WHERE $invoiceDoc = '${doc.invoiceDoc}'");

          if (temp.isNotEmpty) {
            payDtl =
                temp.map((menu) => SalesPaymentRecord.fromDB(menu)).toList();

            doc.salesPayment = payDtl;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<void> updateSyncLogRecordsStatus(
      List<String> docNos, String statusValue) async {
    try {
      Database db = await instance.database;
      String syncDate = DateTime.now().toIso8601String();

      String sql =
          "UPDATE $syncRecordTable SET $syncTime = ?, $status = ? WHERE $docNo IN (${docNos.map((e) => '?').join(', ')})";
      await db.rawUpdate(sql, [syncDate, statusValue, ...docNos]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<int> getTotalUploadReturnRecordsByDate(
      DateTime startDate, DateTime endDate) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    int? result = 0;

    String formattedStartDate = startDate.toIso8601String();
    String formattedEndDate = endDate.toIso8601String();

    try {
      temp = await db.rawQuery(
          "SELECT COUNT(*) as count FROM $salesReturnTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE b.$startCounter BETWEEN '$formattedStartDate' AND '$formattedEndDate'");
      if (temp.isNotEmpty) {
        result = Sqflite.firstIntValue(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result ?? 0;
  }

  Future<List<FullSalesDoc>> getAllReturnDocListByDate(int itemBatch,
      int itemLimit, DateTime startDate, DateTime endDate) async {
    List<FullSalesDoc> result = [];

    int batchCount = itemLimit * itemBatch;

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      String formattedStartDate = startDate.toIso8601String();
      String formattedEndDate = endDate.toIso8601String();

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter FROM $salesReturnTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE b.$startCounter BETWEEN '$formattedStartDate' AND '$formattedEndDate' ORDER BY a.id LIMIT $itemLimit OFFSET $batchCount");
      if (temp.isNotEmpty) {
        result = temp.map((menu) => FullSalesDoc.fromDB(menu)).toList();

        for (FullSalesDoc doc in result) {
          List<SalesDetail> docDtl = [];
          List<SalesPaymentRecord> payDtl = [];
          temp = await db.rawQuery(
              "SELECT * FROM $salesReturnDetailTable WHERE $salesKey = '${doc.salesKey}'");

          if (temp.isNotEmpty) {
            docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

            doc.salesDetails = docDtl;
          }

          temp = await db.rawQuery(
              "SELECT * FROM $refundTable WHERE $invoiceDoc = '${doc.invoiceDoc}'");
          print(temp);

          if (temp.isNotEmpty) {
            payDtl =
                temp.map((menu) => SalesPaymentRecord.fromDB(menu)).toList();

            doc.salesPayment = payDtl;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<int> getTotalUploadCashIoRecordsByDate(
      DateTime startDate, DateTime endDate) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    int? result = 0;

    String formattedStartDate = startDate.toIso8601String();
    String formattedEndDate = endDate.toIso8601String();

    try {
      temp = await db.rawQuery(
          "SELECT COUNT(*) as count FROM $cashInOutTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE b.$startCounter BETWEEN '$formattedStartDate' AND '$formattedEndDate'");

      if (temp.isNotEmpty) {
        result = Sqflite.firstIntValue(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result ?? 0;
  }

  Future<List<CashIoUploadModel>> getUploadCashIoDocListByDate(
      DateTime startDate, DateTime endDate) async {
    List<CashIoUploadModel> result = [];

    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      String formattedStartDate = startDate.toIso8601String();
      String formattedEndDate = endDate.toIso8601String();

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter, (SELECT $label FROM $companyProfileTable LIMIT 1) AS $label, (SELECT $counter FROM $companyProfileTable LIMIT 1) AS $counter FROM $cashInOutTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE b.$startCounter BETWEEN '$formattedStartDate' AND '$formattedEndDate' ORDER BY a.id");
      if (temp.isNotEmpty) {
        result = temp.map((menu) => CashIoUploadModel.fromDB(menu)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<int> getTotalPendingSalesRecords() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    int? result = 0;

    try {
      temp = await db.rawQuery(
          "SELECT COUNT(*) as count FROM $syncRecordTable WHERE $status != 'SUCCESS' AND $docType = 'CS'");
      if (temp.isNotEmpty) {
        result = Sqflite.firstIntValue(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result ?? 0;
  }

  Future<List<SyncObject>> getCSSyncLogLimitRec(
      int limit, int offset, String uploadType) async {
    List<SyncObject> result = [];
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.query(
        syncRecordTable,
        where: '$status != ? AND $docType = ?',
        whereArgs: ['SUCCESS', uploadType],
        limit: limit,
        offset: offset,
      );
      if (temp.isNotEmpty) {
        result = temp.map((menu) => SyncObject.fromDB(menu)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<List<FullSalesDoc>> getAllSalesDocByList(List<String> docNos) async {
    List<FullSalesDoc> result = [];
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter FROM $salesTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE a.$invoiceDoc IN (${docNos.map((e) => '?').join(', ')})",
          [...docNos]);
      if (temp.isNotEmpty) {
        result = temp.map((menu) => FullSalesDoc.fromDB(menu)).toList();

        for (FullSalesDoc doc in result) {
          List<SalesDetail> docDtl = [];
          List<SalesPaymentRecord> payDtl = [];
          temp = await db.rawQuery(
              "SELECT * FROM $salesDetailTable WHERE $salesKey = '${doc.salesKey}'");

          if (temp.isNotEmpty) {
            docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

            doc.salesDetails = docDtl;
          }

          temp = await db.rawQuery(
              "SELECT * FROM $salesPaymentRecordTable WHERE $invoiceDoc = '${doc.invoiceDoc}'");

          if (temp.isNotEmpty) {
            payDtl =
                temp.map((menu) => SalesPaymentRecord.fromDB(menu)).toList();

            doc.salesPayment = payDtl;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<int> getTotalPendingReturnRecords() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    int? result = 0;

    try {
      temp = await db.rawQuery(
          "SELECT COUNT(*) as count FROM $syncRecordTable WHERE $status != 'SUCCESS' AND $docType = 'CN'");
      if (temp.isNotEmpty) {
        result = Sqflite.firstIntValue(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result ?? 0;
  }

  Future<List<FullSalesDoc>> getAllReturnDocByList(List<String> docNos) async {
    List<FullSalesDoc> result = [];
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> temp;

      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, b.$endCounter FROM $salesReturnTable a JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE a.$invoiceDoc IN (${docNos.map((e) => '?').join(', ')})",
          [...docNos]);
      if (temp.isNotEmpty) {
        result = temp.map((menu) => FullSalesDoc.fromDB(menu)).toList();

        for (FullSalesDoc doc in result) {
          List<SalesDetail> docDtl = [];
          List<SalesPaymentRecord> payDtl = [];
          temp = await db.rawQuery(
              "SELECT * FROM $salesReturnDetailTable WHERE $salesKey = '${doc.salesKey}'");

          if (temp.isNotEmpty) {
            docDtl = temp.map((menu) => SalesDetail.fromDB(menu)).toList();

            doc.salesDetails = docDtl;
          }

          temp = await db.rawQuery(
              "SELECT * FROM $refundTable WHERE $invoiceDoc = '${doc.invoiceDoc}'");

          if (temp.isNotEmpty) {
            payDtl =
                temp.map((menu) => SalesPaymentRecord.fromDB(menu)).toList();

            doc.salesPayment = payDtl;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<int> getTotalPendingCashIoRecords() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    int? result = 0;

    try {
      temp = await db.rawQuery(
          "SELECT COUNT(*) as count FROM $syncRecordTable WHERE $status != 'SUCCESS' AND $docType = 'IO'");
      if (temp.isNotEmpty) {
        result = Sqflite.firstIntValue(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result ?? 0;
  }

  Future<List<CashIoUploadModel>> getPendingUploadCashIoRecords(
      List<String> docNos) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp;
    List<CashIoUploadModel> result = [];

    try {
      temp = await db.rawQuery(
          "SELECT a.*, b.$startCounter, (SELECT $label FROM $companyProfileTable LIMIT 1) AS $label, (SELECT $counter FROM $companyProfileTable LIMIT 1) AS $counter FROM $syncRecordTable r JOIN $cashInOutTable a ON r.$docNo = a.$docNo JOIN $batchTable b ON a.$batchKey = b.$batchKey WHERE r.$status != 'SUCCESS' AND r.$docType = 'IO' AND a.$docNo IN (${docNos.map((e) => '?').join(', ')}) ORDER BY a.id",
          [...docNos]);

      if (temp.isNotEmpty) {
        result = temp.map((menu) => CashIoUploadModel.fromDB(menu)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result;
  }

  Future<UsersModel?> getMatchUserByPIN(String userPIN) async {
    Database db = await instance.database;

    var temp = await db
        .rawQuery("SELECT * FROM $userTable WHERE $pin = '$userPIN' LIMIT 1;");

    if (temp.isEmpty) {
      return null;
    } else {
      var data = temp[0];

      UsersModel user = UsersModel.fromDB(data);

      return user;
    }
  }

  Future<UsersModel?> getMatchUserByUsername(String id) async {
    Database db = await instance.database;

    var temp = await db.rawQuery(
        "SELECT * FROM $userTable WHERE lower($userName) = '$id'  LIMIT 1;");

    if (temp.isEmpty) {
      return null;
    } else {
      var data = temp[0];
      return UsersModel.fromDB(data);
    }
  }

  Future<List<Map<String, dynamic>>> getItemsListingSingle(
      String itemQuery, int itemBatch, int itemLimit) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> temp = [];

    int batchCount = itemLimit * itemBatch;

    try {
      if (itemQuery.trim().isEmpty) {
        String query =
            "SELECT DISTINCT a.*, (SELECT COUNT(p.$itemCode) FROM $itemTable p WHERE p.$itemCode = a.$itemCode) AS UomCount, c.$itemImage "
            "FROM $itemTable a LEFT JOIN $imageTable c ON c.$itemCode = a.$itemCode "
            "WHERE $itemUom = $baseUom ORDER BY a.$itemCode, a.$uomQTY LIMIT $itemLimit OFFSET $batchCount";

        temp = await db.rawQuery(query);
      } else {
        String query =
            "SELECT DISTINCT a.*, (SELECT COUNT(p.$itemCode) FROM $itemTable p WHERE p.$itemCode = a.$itemCode) AS UomCount, c.$itemImage "
            "FROM $itemTable a LEFT JOIN $imageTable c ON c.$itemCode = a.$itemCode "
            "WHERE (a.$itemDesc LIKE '%$itemQuery%' OR a.$itemCode LIKE '%$itemQuery%') AND a.$itemUom = a.$baseUom "
            "ORDER BY a.$itemCode, a.$uomQTY LIMIT $itemLimit OFFSET $batchCount";
        temp = await db.rawQuery(query);
      }

      if (temp.isEmpty) {
        String query =
            "SELECT DISTINCT a.*, (SELECT COUNT(p.$itemCode) FROM $itemTable p WHERE p.$itemCode = a.$itemCode) AS UomCount, c.$itemImage "
            "FROM $itemTable a LEFT JOIN $imageTable c ON c.$itemCode = a.$itemCode WHERE a.$itemCode = '$itemQuery' COLLATE NOCASE AND $itemUom = $baseUom";

        temp = await db.rawQuery(query);

        if (temp.isEmpty) {
          temp = await db.rawQuery(
              "SELECT DISTINCT a.*, (SELECT COUNT(p.$itemCode) FROM $itemTable p WHERE p.$itemCode = a.$itemCode) AS UomCount, c.$itemImage "
                  "FROM $barcodeTable b JOIN $itemTable a ON b.$itemCode = a.$itemCode AND a.$itemUom = b.$itemUom LEFT JOIN $imageTable c ON c.$itemCode = a.$itemCode "
                  "WHERE b.$itemBarcode = '$itemQuery' COLLATE NOCASE");
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return temp;
  }
}