import 'dart:ui';

class Globalization {
  //Locale
  static const Locale defaultLocale = Locale("en", "US");
  static const Locale englishLocale = Locale("en", "US");
  static const Locale chineseLocale = Locale("zh", "CN");
  static const Locale malayLocale = Locale("ms", "MY");

  //Language
  static const String english = "English";
  static const String chinese = "简体中文";
  static const String malay = "Bahasa Melayu";

  //Button
  static const String close = "Close";
  static const String yes = "Yes";
  static const String no = "No";
  static const String confirm = "Confirm";
  static const String cancel = "Cancel";
  static const String download = "Download";
  static const String upload = "Upload";
  static const String backup = "Backup";
  static const String restore = "Restore";
  static const String applySaveSetting = "Apply & Save Settings";
  static const String submit = "Submit";
  static const String save = "Save";

  static const String price = "Price";
  static const String amount = "Amount";
  static const String amt = "Amt.";
  static const String date = "Date";
  static const String user = "User";
  static const String qty = "QTY";

  //Login Page
  static const String login = "login";
  static const String userID = "user_id";
  static const String password = "password";
  static const String userPIN = "User PIN";
  static const String fastLoginPIN = "Fast Login PIN";
  static const String emptyFastLoginPIN = "Fast Login PIN is empty";
  static const String emptyUserID = "User ID is empty";
  static const String emptyPassword = "Password is empty";
  static const String invalidLoginCred = "Invalid login credential";

  static const String resetAdminPassword = "Reset Admin Password";
  static const String changeMachineId = "Change Machine ID";
  static const String checkPermission = "Check Permissions";

  //Menu Page
  static const String operationFunctions = "Operation Functions";
  static const String posModule = "POS Module";
  static const String salesScreen = "Sales Screen";
  static const String openCounter = "Open Counter";
  static const String closeCounter = "Close Counter";
  static const String cashInOut = "Cash In/Out";
  static const String stockAdjustment = "Stock Adjustment";
  static const String logout = "Logout";
  static const String salesOder = "Sales Order";
  static const String salesInvoice = "Sales Invoice";
  static const String customerPayment = "Customer Payment";
  static const String description = "Description";

  static const String reports = "Reports";
  static const String generalReports = "General Report";
  static const String malaysiaEInvoice = "Malaysia E-Invoice";
  static const String consolidatedEInvoice = "Consolidated E-Invoice";
  static const String documentSyncReport = "Documents Sync Report";
  static const String membersSyncReport = "Member Sync Report";
  static const String eInvoiceSyncReport = "MyInvois Sync Report";
  static const String stockReport = "Stock Report";
  static const String stockBalanceReport = "Stock Balance Report";
  static const String stockCardReport = "Stock Card Report";
  static const String balanceQty = "Balance Qty";
  static const String stockIn = "Stock In";
  static const String stockOut = "Stock Out";
  static const String documentListing = "Document Listing";

  static const String maintenance = "Maintenance";
  static const String stockItem = "Stock Item";
  static const String member = "Member";
  static const String customer = "Customer";
  static const String menuSettings = "Menu Settings";
  static const String paymentMethod = "Payment Method";
  static const String dataManagement = "Data Management";
  static const String companyProfile = "Company Profile";
  static const String companyLogo = "Company Logo";
  static const String customerMaintenance = "Customer Maintenance";

  static const String settings = "Settings";
  static const String systemSettings = "System Settings";
  static const String scaleSettings = "Weight Scale Settings";
  static const String hardwareSettings = "Hardware Settings";
  static const String generalSettings = "General Settings";
  static const String counterSettings = "Counter Settings";

  static const String serverSettings = "Server Settings";
  static const String userMaintenance = "User Maintenance";

  //Data Management Page
  static const String fullDownload = "Full Download";
  static const String downloadMaster = "Download Master Record";
  static const String downloadSysSetting = "Download System Settings";
  static const String downloadCustomer = "Download Customer Master";
  static const String downloadItemMaster = "Download Item Master";
  static const String downloadItemImage = "Download Item Image";
  static const String syncData = "Sync Data";
  static const String autoUploadTime = "Auto Upload Records Time";
  static const String minutes = "Minutes";
  static const String uploadData = "Upload Data";
  static const String uploadNewRecord = "Upload New Records";
  static const String uploadRecordBetweenDate =
      "Upload Records Between Shift Date";
  static const String backupRestoreData = "Backup Restore Data";
  static const String backupData = "Backup Data";
  static const String restoreData = "Restore Data";
  static const String purgeData = "Purge Data";
  static const String truncateDateBefore = "Truncate date before";
  static const String deleteAllTransaction = "Delete all transaction";
  static const String deleteAllData = "Delete all data";
  static const String selectDate = "Select Date";
  static const String selectDateRange = "Select Date Range";
  static const String downloadingSysSetting = "Downloading System Settings";
  static const String saveSysSetting = "Save System Settings";
  static const String failInsertCompanyProfile = "Fail Insert Company Profile";
  static const String failInsertPosUser = "Fail Insert Pos Users";
  static const String failInsertPymtMethod = "Fail Insert Payment Method";
  static const String downloadingItemMaster = "Downloading Item Master";
  static const String errorInsertItemMaster = "Insert Item Master Error";
  static const String downloadingItemBarcode = "Downloading Item Barcode";
  static const String insertItemMasterBarcode = "Insert Item Master Barcode";
  static const String downloadingItemMenu = "Downloading Item Menu";
  static const String insertItemMenuHdr = "Insert Item Menu Header";
  static const String insertItemMenuDtl = "Insert Item Menu Details";
  static const String downloadingItemImage = "Downloading Item Image";
  static const String downloadingCustomer = "Downloading Customer Master";
  static const String downloadComplete = "Download Completed";
  static const String confirmClearPOSTransaction =
      "This will clear POS transaction data. Do you want to continue?";
  static const String operationComplete = "Operation Completed";
  static const String confirmClearResetPOSData =
      "This will clear and reset POS data. Do you want to continue?";
  static const String confirmClearWithPendingData =
      "There are pending documents that haven't upload to server. Do you want to continue?";
  static const String closeCounterBeforeBackup =
      "Please close counter before backup";
  static const String closeCounterBeforeRestore =
      "Please close counter before restore";
  static const String confirmBackupImages = "Do you want to backup images?";
  static const String backupImage = "Backup Image";
  static const String backupComplete = "Backup Complete";
  static const String path = "Path";
  static const String errorInBackup = "An error found in backup file";
  static const String confirmDataRestoreOverwriteAndRestart =
      "Database restore will overwrite you existing database and application need to be restart.\nDo you want to continue?";
  static const String restoreCompleteLogout =
      "Restore Complete, system will now logout";
  static const String noPendingDocumentFound = "No pending document found";
  static const String dataRestore = "Data Restore";
  static const String confirmDownloadItemData =
      "Do you want to download item data now?";
  static const String confirmDownloadItemImage =
      "Do you want to download item image now?";
  static const String defaultBackupFolder = "Default Backup Folder";
  static const String downloadMemberRecord = "Download Members Record";
  static const String downloadMemberCompleted = "Completed Download Member";
  static const String uploadCompleted = "Upload Completed";
  static const String backupFolder = "Backup folder";
  static const String saveToFolder = "Save to this folder";
  static const String defaultFolderNotFound =
      "Default backup folder not found, auto backup fail";
  static const String failConnectServer = "Fail to connect server";

  static const String syncItemMastSubtitles =
      "Including item master files, item barcode and fast menu";
  static const String syncItemImageSubtitles = "Including item image";
  static const String uploadTransactionData = "Upload Transaction Data";
  static const String uploadTransDataSubtitles =
      "Including cash sales and sales return";

  //Cash In Out Page
  static const String cashIn = "Cash In";
  static const String cashOut = "Cash Out";
  static const String historyCashInOut = "Cash In/Out History";
  static const String reason = "Reason";
  static const String cashInAmount = "Cash In Amount";
  static const String cashOutAmount = "Cash Out Amount";
  static const String emptyAmount = "Amount cannot be empty";
  static const String attachment = "Attachment";

  // Dialog
  static const String information = "Information";
  static const String error = "Error";
  static const String isNull = "Null";
  static const String warning = "Warning";
  static const String settingSaved = "Settings Saved";
  static const String connectionFail = "Connection Fail";
  static const String remark = "Remark";
  static const String reference = "Reference";
  static const String fieldCannotBeEmpty = "Field Cannot Be Empty";
  static const String codeExist = "Code Already Exist";
  static const String uomMustMore = "UOM Rate must more or equal then 2";
  static const String operationFail = "Operation Fail";
  static const String confirmation = "Confirmation";
  static const String areYouSure = "Are You Sure?";
  static const String uomOptions = "UOM Options";
  static const String doYouWantRetry = "Do you want to retry?";
  static const String search = "Search";
  static const String filterOptions = "Filter Options";
  static const String filterByMember = "Filter documents by member";
  static const String filterByItem = "Filter documents by item";
  static const String filterByDocument = "Filter documents by document number";

  // Printer Settings Page / Hardware Setting Page
  static const String printerSettings = "Printer Settings";
  static const String connectionType = "Connection Type";
  static const String searchPrinter = "Search Printer";
  static const String connect = "Connect";
  static const String none = "None";
  static const String usb = "USB";
  static const String bluetooth = "Bluetooth";
  static const String network = "Network";
  static const String selectedPrinter = "Selected Printer";
  static const String testDrawer = "Test Drawer";
  static const String paperSize = "Paper Size";
  static const String connectCashDrawer = "Connect Cash Drawer";
  static const String directPrintReceipt = "Direct Print Receipt";
  static const String printQuantity = "Print Item Quantity";
  static const String printCompanyLogo = "Print Company Logo";
  static const String pleaseSelectConnectionType =
      "Please Select Connection Type";
  static const String devicesFound = "Devices Found";
  static const String select = "Select";
  static const String connected = "Connected";
  static const String unset = "Unset";
  static const String printerConnectedSuccessful =
      "Printer Connected Successful";
  static const String pleaseKeyInPrinterAddress =
      "Please Key In Printer Address";
  static const String testPrint = "Test Print";
  static const String failConnectPrinter = "Fail to connect printer";
  static const String printReceipt = "Print Receipt";
  static const String printCopies = "Print copies :";
  static const String defaultReceiptCopy = "Default Receipt Copy";
  static const String iMinDevice = "iMin Device";

  static const String secondDisplaySettings = "Second Display Settings";
  static const String iMinBuiltInDisplay = "iMin Built In Display";
  static const String testDisplay = "Test Display";

  //Sales Screen Page
  static const String priceChecker = "P.Checker";
  static const String holdBill = "Hold Bill";
  static const String loadBill = "Load Bill";
  static const String lastBill = "Last Bill";
  static const String drawer = "Drawer";
  static const String barcode = "Barcode";
  static const String uPrice = "U.Price";
  static const String unitPrice = "Unit Price";
  static const String quantity = "Quantity";
  static const String discount = "Discount";
  static const String subTotal = "Sub Total";
  static const String scan = "Scan";
  static const String clearSalesCart = "Clear Sales Cart";
  static const String emptyCart = "Cart is empty";
  static const String itemNotFound = "Item not found";
  static const String confirmToExit = "Are you sure you want to exit?";
  static const String confirmToRemoveItem =
      "Are you sure you want to remove this item?";
  static const String changeUnitPriceFrom =
      "Do you want change the unit price from ";
  static const String changeTo = "to";
  static const String cartItemExistConfirm =
      "Cart is not empty. Do you want to continue?";
  static const String taxAmt = "Tax Amt.";
  static const String rounding = "Rounding";
  static const String docAmt = "Doc. Amount";
  static const String clearHoldBillDoc = "Clear Hold Bill Document";
  static const String dateTime = "Date Time";
  static const String invalidQty = "Invalid Quantity";
  static const String invalidValue = "Invalid Value";
  static const String invalidDiscount = "Invalid Discount";
  static const String total = "Total";
  static const String promotion = "Promotion";

  static const String notAllowBecauseReturnMsg =
      "Sales return item in list, operation is not allowed";
  static const String salesTotalCannotLessThanOrEqualZero =
      "Sales total cannot be less than or equal to 0";
  static const String salesTotalCannotLessThanZero =
      "Sales total cannot be less than 0";
  static const String salesTotalustGreaterThanZero =
      "Sales total must be greater than 0";

  //System Setting Page
  static const String sysLanguage = "System Language";
  static const String useCameraAsScanner = "User Camera As Scanner";
  static const String mergeDuplicateItem = "Merge Duplicate Items";
  static const String currencySymbol = "Currency Symbol";
  static const String currencyPosition = "Currency Position";
  static const String unitPriceRoundDecimal =
      "Unit Price Rounding Decimal Place";
  static const String qtyRoundDecimal = "Quantity Rounding Decimal Place";
  static const String centRoundingOptions = "Cent Rounding Options";
  static const String requireRemarkOnHoldBill = "Require Remark On Hold Bill";
  static const String allowZeroOpencounter =
      "Allow Zero Amount In Open Counter";
  static const String emptyCurrencySymbol = "Currency Symbol cannot be empty";
  static const String allowZeroItemPrice = "Allow Zero Item Price";
  static const String promptOnZeroPriceItem = "Prompt On Zero Price Item";
  static const String cashOutRequireAttachment =
      "Attachment Is Required To Cash Out";
  static const String documentPrefixLabel = "Document Prefix Label";
  static const String allowCounterCrossDay = "Allow Counter Cross Day";

  //Server Setting Page
  static const String localServerConnection = "Local Data Server Connection";
  static const String profileName = "Profile Name";
  static const String serverIPAdd = "Server IP";
  static const String serverPort = "Port";
  static const String hostPassword = "Host Password";
  static const String connectUpdateSetting = "Connect & Update Settings";
  static const String ezyMemberServerConnection = "Ezymember Server Connection";
  static const String serverID = "Server ID";
  static const String companyKey = "Company Key";
  static const String serverUrl = "Server URL";
  static const String publicKey = "Public Key";
  static const String privateKey = "Private Key";
  static const String invalidQrCode = "Invalid QR Code";
  static const String invalidBarcode = "Invalid Barcode";
  static const String emptyProfileName = "Profile Name is empty";
  static const String emptyServerIPAdd = "Server IP is empty";
  static const String emptyPort = "Port is empty";
  static const String emptyHostPassword = "Host Password is empty";
  static const String connectingToServer = "Connecting To Server";
  static const String emptyServerID = "Server ID is empty";
  static const String emptyCompanyID = "Company ID is empty";
  static const String emptyCompanyKey = "Company Key is empty";
  static const String emptyServerUrl = "Server URL is empty";
  static const String emptyPublicKey = "Public Key is empty";
  static const String emptyPrivateKey = "Private Key is empty";
  static const String connectServerSuccessful = "Connect Server Successful";
  static const String updateSuccessful = "Update Successful";
  static const String pairServer = "Pair Server";
  static const String cloudServer = "Cloud Server";
  static const String noRegisterTokenUpdateAbort =
      "No register token found, update abort";
  static const String deviceToken = "Device Token";

  static const String updateServerSettings = "Update Server Settings";

  static const String next = "Next";
  static const String back = "Back";

  static const String serverType = "Data Server Connection Type";
  static const String emailServerSettings = "Email Server Settings";
  static const String enableEmailService = "Enable Email Service";
  static const String autoEmailOnCloseCounter = "Auto Email On Close Counter";
  static const String invalidEmail = "Invalid Email Address";

  //Menu Design Page
  static const String menuHeader = "Menu Header";
  static const String menuDetail = "Menu Details";
  static const String showMenuByDefault = "Show Menu By Default";
  static const String menuHdrRows = "Menu Header Rows";
  static const String menuDtlColumns = "Menu Detail Columns";
  static const String confirmRemoveSelectedItem =
      "Are you confirm you want to remove selected item?";
  static const String menuTextSize = "Menu Text Size";

  static const String newItem = "New Item";
  static const String editItem = "Edit Item";
  static const String deleteItem = "Delete Item";
  static const String reorderItem = "Reorder Items";
  static const String weightItem = "Weight Goods";

  //Payment Method Page
  static const String paymentMenu = "Payment Menu";
  static const String paymentMenuSetting = "Payment Menu Settings";
  static const String checkoutDelay = "Check-out Delay";
  static const String maxPaymentMethod = "Maximum Payment Method";
  static const String paymentMenuColumns = "Payment Menu Columns";
  static const String confirmRemovePaymentMethod =
      "Are you confirm you want to remove selected payment method?";

  //Payment Method Page - Add / Edit
  static const String newPaymentMethod = "New Payment Method";
  static const String paymentCode = "Payment Code";
  static const String paymentDescription = "Payment Description";
  static const String paymentType = "Payment Type";
  static const String cash = "Cash";
  static const String qrPayment = "QR Payment";
  static const String paymentTerminal = "Payment Terminal";
  static const String revenueMonster = "Revenue Monster";
  static const String others = "Others";
  static const String openCashDrawer = "Open Cash Drawer";
  static const String requireReference = "Require Reference";
  static const String addPayment = "Add Payment";
  static const String editPaymentMethod = "Edit Payment Method";
  static const String saveChanges = "Save Changes";

  //Company Profile Page
  static const String companyInfo = "Company Info";
  static const String companyName = "Company Name";
  static const String companyROC = "Company ROC";
  static const String address = "Address";
  static const String address1 = "Address 1";
  static const String address2 = "Address 2";
  static const String address3 = "Address 3";
  static const String address4 = "Address 4";
  static const String contactInfo = "Contact Info";
  static const String contactNo = "Contact No.";
  static const String updateProfile = "Update Profile";

  static const String taxNo = "Tax No.";
  static const String email = "Email";
  static const String tinNo = "TIN No.";

  //Weight Scale Setting Page
  static const String connectDigitalWeightMachine =
      "Connected to Digital Weight Machine";

  //Maintain Item
  static const String itemDetails = "Item Details";
  static const String itemImage = "Item Image";
  static const String itemCode = "Item Code";
  static const String itemDescription = "Item Description";
  static const String additionalDescription = "Additional Description";
  static const String addUom = "Add UOM";
  static const String baseUom = "Base UOM";
  static const String itemUom = "Item UOM";
  static const String uomCode = "UOM Code";
  static const String uomRate = "UOM Rate";
  static const String altBarcode = "Alternative Barcode";
  static const String saveRecord = "Save Record";
  static const String itemType = "Item Type";
  static const String classification = "Classification";
  static const String taxCode = "Tax Code";
  static const String tariff = "Tariff";

  //Reports Page
  static const String fromDate = "From Date";
  static const String toDate = "To Date";
  static const String endDate = "End Date";
  static const String reportType = "Report Type";
  static const String apply = "Apply";
  static const String docDate = "Doc. Date";
  static const String docNo = "Doc. No";
  static const String shiftNo = "Shift No";
  static const String docTotal = "Doc. Total";
  static const String counterOpenTime = "Open Counter Time";
  static const String openBy = "Open By";
  static const String counterCloseTime = "Close Counter Time";
  static const String closeBy = "Close By";
  static const String totalIn = "Total Cash In";
  static const String totalOut = "Total Cash Out";
  static const String warehouse = "Warehouse";
  static const String counter = "Counter";
  static const String shift = "Shift";
  static const String openingCash = "Opening Cash";
  static const String sales = "Sales";
  static const String salesReturn = "Salse Return";
  static const String confirmCloseCounter =
      "Are you sure you want to close the counter?";
  static const String closeCounterClearHoldBill =
      "Please clear all hold bills before close the counter.\nDo you want to clear it now?";
  static const String confirmUploadPendingData =
      "There are pending documents that haven't upload to server.\nDo you want to upload now?";
  static const String counterInfo = "Counter Info";
  static const String loadReport = "Load Report";

  //Sync Log Page
  static const String docType = "Document Type";
  static const String syncTime = "Sync Date";
  static const String status = "Status";
  static const String clearAllPendingRecords = "Clear All Pending Records";

  //Sales Document Listing
  static const String salesDocument = "Sales Document";
  static const String salesDocumentListing = "Sales Document Listing";
  static const String returnDocumentListing = "Return Document Listing";
  static const String salesDocumentDetails = "Sales Document Details";
  static const String returnDocumentDetails = "Return Document Details";
  static const String salesPaymentDetails = "Sales Payment Details";
  static const String refundPaymentDetails = "Refund Payment Details";
  static const String allSyncLog = "All Documents Sync Log";
  static const String pendingSyncLog = "Pending Documents Sync Log";
  static const String successSyncLog = "Success Documents Sync Log";
  static const String failedSyncLog = "Failed Documents Sync Log";
  static const String memberSyncLog = "Pending Members Sync Log";

  //Shift Listing
  static const String shiftListing = "Shift Listing";

  //Cash In/Out By Shift
  static const String cashIOListing = "Cash In/Out Listing";

  //Item Sales Summary
  static const String itemSalesSummary = "Item Sales Summary";

  //Payment Page
  static const String invalidAmt = "Invalid Amount";
  static const String invalidPaymentMethod = "Invalid Payment Method";
  static const String confirmRemovePayment =
      "Are you sure you want to remove this payment?";
  static const String insufficientAmount = "Insufficient Amount";
  static const String saving = "Saving";
  static const String paidAmt = "Paid Amount";
  static const String confirmClearAllPayment =
      "Discount have to make before payment. This will clear all payment.\nYou sure you want to continue?";
  static const String changeAmt = "Change Amount";
  static const String balanceAmt = "Balance Amount";
  static const String totalPaidAmt = "Total Paid Amount";
  static const String totalRefundAmt = "Total Refund Amount";
  static const String checkOut = "Check Out";
  static const String refund = "Refund";
  static const String grandTotal = "Grand Total";
  static const String confirmCancelPayment =
      "Are you sure you want to cancel payment?";
  static const String only = "Only";
  static const String paymentMethodAllowed = "payment method allowed";
  static const String currentPaymentMethodNotAllow =
      "This payment method is not allow";
  static const String balanceNotEnoughToPay =
      "Your balance is not enough to pay";
  static const String amountIsFullyPaid = "Amount is fully paid";
  static const String ezypointCannotBeRemove = "EZYPOINT cannot be remove";
  static const String ezypointCannotBeEdit = "EZYPOINT cannot be edit";

  //Customer Info
  static const String customerInformation = "Customer Information";
  static const String customerCode = "Customer Code";
  static const String customerName = "Customer Name";
  static const String customerName2 = "Customer Name2";
  static const String rocIcPassport = "ROC/IC/Passport";
  static const String tinNumber = "TIN Number";
  static const String emailAddress = "E-Mail Address";
  static const String brnNo = "BRN";
  static const String MSIC = "MSIC";
  static const String phone = "Phone";
  static const String mobile = "Mobile";

  //Price Checker Page
  static const String findItemWithQuickScan =
      "Find the item price with a quick scan";

  //Welcome Page
  static const String welcome = "Welcome";
  static const String choosingEzyRetailProAndBegin =
      "Thank You for choosing EzyRetail Pro. It is a joy for us to help you with our products.\nLet's select your option to start.";
  static const String activate = "Activate";
  static const String licenseAlreadyActivateInDevice =
      "I already have my license and would like to activate in this device";
  static const String registerTrial = "Register for trial";
  static const String interestedTrialPeriodToTest =
      "I'm interested in its features and would like to inquire a trial period to test";
  static const String trySampleData = "Try with sample data";
  static const String interestedSampleData =
      "I'm interested in experimenting with sample data to grasp its functionality";
  static const String confirmCancelSetupUnableLoginUntilComplete =
      "This will cancel setup and you will not able to login until you complete the setup\nDo you want to continue?";
  static const String connectingToHost = "Connecting To Host";

  //Change App Ver Page
  static const String changeEdition = "Change Edition";
  static const String warningBeforeChangeEdition =
      "Before you start, please be remind that change of edition might need to reset your database. Please backup before you perform any action. Let's select your option to start.";
  static const String directToServerPage = "Direct me to server settings page";
  static const String generateNewEzyLinkToolsEdition =
      "Generate new EzyLink Tools Edition";
  static const String generateCloudEdition =
      "Generate new Online Cloud edition";
  static const String generateEmptyStandaloneEdition =
      "Generate empty stand alone edition";
  static const String restoreOwnBackupEdition = "Restore my backup";
  static const String generateStandaloneWithSample =
      "Generate stand alone with sample data";
  static const String generateDatabase = "Generate Database";
  static const String generateSampleDatabase = "Generate Sample Database";
  static const String invalidBackupFile = "Invalid Backup File";
  static const String advanceOptions = "Advance Options";
  static const String confirmResetCreateNewDb =
      "This process will reset and create a new database.\nDo you want to continue?";

  //Version Option Page
  static const String standalone = "Stand alone";
  static const String operateIndependently =
      "My POS operate independently, not connected to any data server";
  static const String connectedToEzyLinkToolsServer =
      "My POS is connected to EzyLink tools, all my master data is from application server";
  static const String dealerUse = "Dealer Use";
  static const String forInternalUseOnly = "For internal use only";
  static const String loadSettings = "Load Settings";
  static const String choosePosEdition = "Choose your POS editions";

  //User Maintenance Page
  static const String userDetails = "User Details";
  static const String accessLevel = "Access Level";
  static const String administrator = "Administrator";
  static const String allowAccessAllOptions =
      "(Allow access all options in the system)";
  static const String supervisor = "Supervisor";
  static const String allowAccessMostOptionAcceptDelete =
      "(Allow access most options other than delete)";
  static const String systemUser = "System User";
  static const String allowAccessBasicFunction =
      "(Allow access basic function of the system)";
  static const String userIdExists = "User ID already exist";
  static const String fastLoginPinExists = "Fast Login PIN already exist";
  static const String confirmDeleteSelectedUser =
      "Are you sure want to delete selected User?";
  static const String selectedUserOperationExistDelete =
      "Selected User perform operation before, delete is not allowed";

  //Stock Item Page
  static const String itemIsUsedNotAllowedDelete =
      "Deletion failed. This item has been used in system";
  static const String confirmToDeleteSelectedItem =
      "Are you sure you want to delete selected item?";

  //Last Bill Page
  static const String invoiceList = "Invoice List";
  static const String confirmReturnSelectedItem =
      "Are you confirm to return selected item?";
  static const String invoiceDetails = "Invoice Details";
  static const String paymentDetails = "Payment Details";
  static const String confirmCreateSalesReturn =
      "Are you sure want to initiate a sales return?";
  static const String previousReturned = "Previous Returned";
  static const String currentReturn = "Current Return";
  static const String allItemsReturned = "All items returned";
  static const String confirmReturnAllDiscountedItem =
      "You are only allow to return all items for discounted items. Do you want to continue?";
  static const String invalidReturnQty = "Invalid return Quantity";
  static const String itemReturnedOnSelectedDoc =
      "There are item returned in selected document.\nSales return is not allowed.";

  //Signup Page
  static const String businessInfo = "Business Info";
  static const String infoUseOnPrinting =
      "This information will use in receipt printing";
  static const String postCode = "Postcode";
  static const String state = "State";
  static const String city = "City";
  static const String country = "Country";
  static const String fullname = "Full Name";
  static const String recordOwnerApplication =
      "This is to record the owner of this application";
  static const String contactNumber = "Contact Number";
  static const String emptyCompName = "Company Name cannot be empty";
  static const String emptyAddress = "Address cannot be empty";
  static const String emptyFullName = "Full Name cannot be empty";
  static const String emptyContactNumber = "Contact Number cannot be empty";
  static const String emptyEmail = "Email cannot be empty";

  //Member / Customer
  static const String expiredDate = "Expired Date";
  static const String noMemberServer = "No Member Server";
  static const String noConnectAnyMemberSvr =
      "Not connected to any member server";
  static const String ezyMemberServerSetting = "EzyMember Server Settings";
  static const String connectedEzyMemberSvr = "Connected to EzyMember server";
  static const String enableEzyMember = "Enable EzyMember";
  static const String connectionErrorCheckSetting =
      "Connection Error, please check your connection settings";
}
