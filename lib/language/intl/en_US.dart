import '../globalization.dart';

class EnUs {
  static Map<String, String> get keys => {
        //Login Page
        Globalization.login: "Login",
        Globalization.userID: "User ID",
        Globalization.password: "Password",
        Globalization.userPIN: "User PIN",
        Globalization.fastLoginPIN: "Fast Login PIN",
        Globalization.emptyFastLoginPIN: "Fast Login PIN is empty",
        Globalization.emptyUserID: "User ID is empty",
        Globalization.emptyPassword: "Password is empty",
        Globalization.invalidLoginCred: "Invalid login credential",

        Globalization.resetAdminPassword: "Reset Admin Password",
        Globalization.changeMachineId: "Change Machine ID",
        Globalization.checkPermission: "Check Permissions",

        //Buttons
        Globalization.close: "Close",
        Globalization.yes: "Yes",
        Globalization.no: "No",
        Globalization.confirm: "Confirm",
        Globalization.cancel: "Cancel",
        Globalization.download: "Download",
        Globalization.upload: "Upload",
        Globalization.backup: "Backup",
        Globalization.restore: "Restore",
        Globalization.applySaveSetting: "Apply & Save Settings",
        Globalization.submit: "Submit",
        Globalization.save: "Save",

        Globalization.price: "Price",
        Globalization.amount: "Amount",
        Globalization.date: "Date",
        Globalization.user: "User",
        Globalization.qty: "QTY",

        //Menu Page
        Globalization.operationFunctions: "Operation Functions",
        Globalization.posModule: "Pos Module",
        Globalization.salesScreen: "Sales Screen",
        Globalization.openCounter: "Open Counter",
        Globalization.closeCounter: "Close Counter",
        Globalization.cashInOut: "Cash In/Out",
        Globalization.stockAdjustment: "Stock Adjustment",
        Globalization.logout: "Logout",
        Globalization.salesOder: "Sales Order",
        Globalization.salesInvoice: "Sales Invoice",
        Globalization.customerPayment: "Customer Payment",

        Globalization.reports: "Report",
        Globalization.generalReports: "General Report",
        Globalization.malaysiaEInvoice: "Malaysia E-Invoice",
        Globalization.consolidatedEInvoice: "Consolidated E-Invoice",
        Globalization.documentSyncReport: "Documents Sync Report",
        Globalization.membersSyncReport: "Member Sync Report",
        Globalization.eInvoiceSyncReport: "MyInvois Sync Report",
        Globalization.stockReport: "Stock Report",
        Globalization.stockBalanceReport: "Stock Balance Report",
        Globalization.stockCardReport: "Stock Card Report",
        Globalization.balanceQty: "Balance Qty",
        Globalization.stockIn: "Stock In",
        Globalization.stockOut: "Stock Out",
        Globalization.documentListing: "Document Listing",

        Globalization.maintenance: "Maintenance",
        Globalization.stockItem: "Stock Item",
        Globalization.member: "Member",
        Globalization.menuSettings: "Menu Settings",
        Globalization.paymentMethod: "Payment Method",
        Globalization.dataManagement: "Data Management",
        Globalization.companyProfile: "Company Profile",
        Globalization.companyLogo: "Company Logo",

        Globalization.settings: "Settings",
        Globalization.systemSettings: "System Settings",
        Globalization.generalSettings: "General Settings",
        Globalization.counterSettings: "Counter Settings",
        Globalization.scaleSettings: "Weight Scale Settings",
        Globalization.hardwareSettings: "Hardware Settings",
        Globalization.serverSettings: "Server Settings",
        Globalization.userMaintenance: "User Maintenance",

        //Data Managment Page
        Globalization.fullDownload: "Full Download",
        Globalization.downloadMaster: "Download Master Record",
        Globalization.downloadSysSetting: "Download System Settings",
        Globalization.downloadCustomer: "Download Customer Master",
        Globalization.downloadItemMaster: "Download Item Master",
        Globalization.downloadItemImage: "Download Item Image",
        Globalization.syncData: "Sync Data",
        Globalization.autoUploadTime: "Auto Upload Records Time",
        Globalization.minutes: "Minutes",
        Globalization.uploadData: "Upload Data",
        Globalization.uploadNewRecord: "Upload New Records",
        Globalization.uploadRecordBetweenDate:
            "Upload Records Between Shift Date",
        Globalization.backupRestoreData: "Backup Restore Data",
        Globalization.backupData: "Backup Data",
        Globalization.restoreData: "Restore Data",
        Globalization.purgeData: "Purge Data",
        Globalization.truncateDateBefore: "Truncate date before",
        Globalization.deleteAllTransaction: "Delete all transaction",
        Globalization.deleteAllData: "Delete all data",
        Globalization.selectDate: "Select Date",
        Globalization.selectDateRange: "Select Date Range",
        Globalization.downloadingSysSetting: "Downloading System Settings",
        Globalization.saveSysSetting: "Save System Settings",
        Globalization.failInsertCompanyProfile: "Fail Insert Company Profile",
        Globalization.failInsertPosUser: "Fail Insert Pos Users",
        Globalization.failInsertPymtMethod: "Fail Insert Payment Method",
        Globalization.downloadingItemMaster: "Downloading Item Master",
        Globalization.errorInsertItemMaster: "Insert Item Master Error",
        Globalization.downloadingItemBarcode: "Downloading Item Barcode",
        Globalization.insertItemMasterBarcode: "Insert Item Master Barcode",
        Globalization.downloadingItemMenu: "Downloading Item Menu",
        Globalization.insertItemMenuHdr: "Insert Item Menu Header",
        Globalization.insertItemMenuDtl: "Insert Item Menu Details",
        Globalization.downloadingItemImage: "Downloading Item Image",
        Globalization.downloadingCustomer: "Downloading Customer Master",
        Globalization.downloadComplete: "Download Completed",
        Globalization.confirmClearPOSTransaction:
            "This will clear POS transaction data. Do you want to continue?",
        Globalization.confirmClearWithPendingData:
            "There are pending documents that haven't upload to server. Do you want to continue?",
        Globalization.operationComplete: "Operation Completed",
        Globalization.confirmClearResetPOSData:
            "This will clear and reset POS data. Do you want to continue?",
        Globalization.closeCounterBeforeBackup:
            "Please close counter before backup",
        Globalization.closeCounterBeforeRestore:
            "Please close counter before restore",
        Globalization.confirmBackupImages: "Do you want to backup images?",
        Globalization.backupImage: "Backup Image",
        Globalization.backupComplete: "Backup Complete",
        Globalization.path: "Path",
        Globalization.errorInBackup: "An error found in backup file",
        Globalization.confirmDataRestoreOverwriteAndRestart:
            "Database restore will overwrite you existing database and application need to be restart.\nDo you want to continue?",
        Globalization.restoreCompleteLogout:
            "Restore Complete, system will now logout",
        Globalization.noPendingDocumentFound: "No pending document found",
        Globalization.dataRestore: "Data Restore",
        Globalization.confirmDownloadItemData:
            "Do you want to download item data now?",
        Globalization.confirmDownloadItemImage:
            "Do you want to download item image now?",
        Globalization.defaultBackupFolder: "Default Backup Folder",
        Globalization.downloadMemberRecord: "Download Members Record",
        Globalization.downloadMemberCompleted: "Completed Download Member",
        Globalization.uploadCompleted: "Upload Completed",
        Globalization.backupFolder: "Backup folder",
        Globalization.saveToFolder: "Save to this folder",
        Globalization.defaultFolderNotFound:
            "Default backup folder not found, auto backup fail",
        Globalization.failConnectServer: "Fail to connect server",

        Globalization.syncItemMastSubtitles:
            "Including item master files, item barcode and fast menu",
        Globalization.syncItemImageSubtitles: "Including item image",
        Globalization.uploadTransactionData: "Upload Transaction Data",
        Globalization.uploadTransDataSubtitles:
            "Including cash sales and sales return",

        //Cash In Out
        Globalization.cashIn: "Cash In",
        Globalization.cashOut: "Cash Out",
        Globalization.historyCashInOut: "Cash In/Out History",
        Globalization.reason: "Reason",
        Globalization.cashInAmount: "Cash In Amount",
        Globalization.cashOutAmount: "Cash Out Amount",
        Globalization.emptyAmount: "Amount cannot be empty",
        Globalization.attachment: "Attachment",

        // Dialog
        Globalization.information: "Information",
        Globalization.error: "Error",
        Globalization.isNull: "Null",
        Globalization.warning: "Warning",
        Globalization.settingSaved: "Settings Saved",
        Globalization.connectionFail: "Connection Fail",
        Globalization.remark: "Remark",
        Globalization.reference: "Reference",
        Globalization.fieldCannotBeEmpty: "Field Cannot Be Empty",
        Globalization.codeExist: "Code Already Exist",
        Globalization.uomMustMore: "UOM Rate must more or equal then 2",
        Globalization.operationFail: "Operation Fail",
        Globalization.confirmation: "Confirmation",
        Globalization.areYouSure: "Are You Sure?",
        Globalization.uomOptions: "UOM Options",
        Globalization.doYouWantRetry: "Do you want to retry?",
        Globalization.search: "Search",
        Globalization.filterOptions: "Filter Options",
        Globalization.filterByMember: "Filter documents by member",
        Globalization.filterByItem: "Filter documents by item",
        Globalization.filterByDocument: "Filter documents by document number",

        // Printer Settings Page / Hardware Setting Page
        Globalization.printerSettings: "Printer Settings",
        Globalization.connectionType: "Connection Type",
        Globalization.searchPrinter: "Search Printer",
        Globalization.connect: "Connect",
        Globalization.none: "None",
        Globalization.usb: "USB",
        Globalization.bluetooth: "Bluetooth",
        Globalization.network: "Network",
        Globalization.selectedPrinter: "Selected Printer",
        Globalization.testDrawer: "Test Drawer",
        Globalization.paperSize: "Paper Size",
        Globalization.connectCashDrawer: "Connect Cash Drawer",
        Globalization.directPrintReceipt: "Direct Print Receipt",
        Globalization.printQuantity: "Print Item Quantity",
        Globalization.pleaseSelectConnectionType:
            "Please Select Connection Type",
        Globalization.devicesFound: "Devices Found",
        Globalization.select: "Select",
        Globalization.unset: "Unset",
        Globalization.connected: "Connected",
        Globalization.printerConnectedSuccessful:
            "Printer Connected Successful",
        Globalization.pleaseKeyInPrinterAddress:
            "Please Key In Printer Address",
        Globalization.testPrint: "Test Print",
        Globalization.failConnectPrinter: "Fail to connect printer",
        Globalization.printReceipt: "Print Receipt",
        Globalization.printCopies: "Print copies :",
        Globalization.defaultReceiptCopy: "Default Receipt Copy",
        Globalization.iMinDevice: "iMin Device",

        //Sales Screen Page
        Globalization.priceChecker: "P.Checker",
        Globalization.holdBill: "Hold Bill",
        Globalization.loadBill: "Load Bill",
        Globalization.lastBill: "Last Bill",
        Globalization.drawer: "Drawer",
        Globalization.barcode: "Barcode",
        Globalization.uPrice: "U.Price",
        Globalization.unitPrice: "Unit Price",
        Globalization.quantity: "Quantity",
        Globalization.discount: "Discount",
        Globalization.subTotal: "Sub Total",
        Globalization.scan: "Scan",
        Globalization.clearSalesCart: "Clear Sales Cart",
        Globalization.emptyCart: "Cart is empty",
        Globalization.itemNotFound: "Item not found",
        Globalization.confirmToExit: "Are you sure you want to exit?",
        Globalization.confirmToRemoveItem:
            "Are you sure you want to remove this item?",
        Globalization.changeUnitPriceFrom:
            "Do you want change the unit price from",
        Globalization.changeTo: "to",
        Globalization.cartItemExistConfirm:
            "Cart is not empty. Do you want to continue?",
        Globalization.taxAmt: "Tax Amt.",
        Globalization.rounding: "Rounding",
        Globalization.docAmt: "Doc. Amount",
        Globalization.clearHoldBillDoc: "Clear Hold Bill Document",
        Globalization.dateTime: "Date Time",
        Globalization.invalidQty: "Invalid Quantity",
        Globalization.invalidValue: "Invalid Value",
        Globalization.invalidDiscount: "Invalid Discount",
        Globalization.total: "Total",

        Globalization.notAllowBecauseReturnMsg:
            "Sales return item in list, operation is not allowed",
        Globalization.salesTotalCannotLessThanOrEqualZero:
            "Sales total cannot be less than or equal to 0",
        Globalization.salesTotalCannotLessThanZero:
            "Sales total cannot be less than 0",
        Globalization.salesTotalustGreaterThanZero:
            "Sales total must be greater than 0",

        //System Setting Page
        Globalization.sysLanguage: "System Language",
        Globalization.useCameraAsScanner: "Use Camera As Scanner",
        Globalization.mergeDuplicateItem: "Merge Duplicate Items",
        Globalization.currencySymbol: "Currency Symbol",
        Globalization.currencyPosition: "Currency Position",
        Globalization.unitPriceRoundDecimal:
            "Unit Price Rounding Decimal Place",
        Globalization.qtyRoundDecimal: "Quantity Rounding Decimal Place",
        Globalization.centRoundingOptions: "Cent Rounding Options",
        Globalization.requireRemarkOnHoldBill: "Require Remark On Hold Bill",
        Globalization.allowZeroOpencounter: "Allow Zero Amount In Open Counter",
        Globalization.emptyCurrencySymbol: "Currency Symbol cannot be empty",
        Globalization.allowZeroItemPrice: "Allow Zero Item Price",
        Globalization.promptOnZeroPriceItem: "Prompt On Zero Price Item",
        Globalization.cashOutRequireAttachment:
            "Attachment Is Required To Cash Out",
        Globalization.documentPrefixLabel: "Document Prefix Label",
        Globalization.allowCounterCrossDay: "Allow Counter Cross Day",

        //Server Setting Page
        Globalization.localServerConnection: "Local Data Server Connection",
        Globalization.profileName: "Profile Name",
        Globalization.serverIPAdd: "Server IP",
        Globalization.serverPort: "Port",
        Globalization.hostPassword: "Host Password",
        Globalization.connectUpdateSetting: "Connect & Update Settings",
        Globalization.ezyMemberServerConnection: "Ezymember Server Connection",
        Globalization.serverID: "Server ID",
        Globalization.companyKey: "Company Key",
        Globalization.serverUrl: "Server URL",
        Globalization.publicKey: "Public Key",
        Globalization.privateKey: "Private Key",
        Globalization.invalidQrCode: "Invalid QR Code",
        Globalization.invalidBarcode: "Invalid Barcode",
        Globalization.emptyProfileName: "Profile Name is empty",
        Globalization.emptyServerIPAdd: "Server IP is empty",
        Globalization.emptyPort: "Port is empty",
        Globalization.emptyHostPassword: "Host Password is empty",
        Globalization.connectingToServer: "Connecting To Server",
        Globalization.emptyServerID: "Server ID is empty",
        Globalization.emptyCompanyID: "Company ID is empty",
        Globalization.emptyCompanyKey: "Company Key is empty",
        Globalization.emptyServerUrl: "Server URL is empty",
        Globalization.emptyPublicKey: "Public Key is empty",
        Globalization.emptyPrivateKey: "Private Key is empty",
        Globalization.connectServerSuccessful: "Connect Server Successful",
        Globalization.updateSuccessful: "Update Successful",
        Globalization.pairServer: "Pair Server",
        Globalization.cloudServer: "Cloud Server",
        Globalization.noRegisterTokenUpdateAbort:
            "No register token found, update abort",

        Globalization.updateServerSettings: "Update Server Settings",

        Globalization.next: "Next",
        Globalization.back: "Back",

        Globalization.serverType: "Data Server Connection Type",
        Globalization.emailServerSettings: "Email Server Settings",
        Globalization.enableEmailService: "Enable Email Service",
        Globalization.autoEmailOnCloseCounter: "Auto Email On Close Counter",
        Globalization.invalidEmail: "Invalid Email Address",

        //Menu Design Page
        Globalization.menuHeader: "Menu Header",
        Globalization.menuDetail: "Menu Details",
        Globalization.showMenuByDefault: "Show Menu By Default",
        Globalization.menuHdrRows: "Menu Header Rows",
        Globalization.menuDtlColumns: "Menu Detail Columns",
        Globalization.confirmRemoveSelectedItem:
            "Are you confirm you want to remove selected item?",
        Globalization.menuTextSize: "Menu Text Size",

        Globalization.newItem: "New Item",
        Globalization.editItem: "Edit Item",
        Globalization.deleteItem: "Delete Item",
        Globalization.reorderItem: "Reorder Items",
        Globalization.weightItem: "Weight Goods",

        //Payment Method Page
        Globalization.paymentMenu: "Payment Menu",
        Globalization.paymentMenuSetting: "Payment Menu Settings",
        Globalization.checkoutDelay: "Check-out Delay",
        Globalization.maxPaymentMethod: "Maximum Payment Method",
        Globalization.paymentMenuColumns: "Payment Menu Columns",
        Globalization.confirmRemovePaymentMethod:
            "Are you confirm you want to remove selected payment method?",

        //Payment Method Page - Add / Edit
        Globalization.newPaymentMethod: "New Payment Method",
        Globalization.paymentCode: "Payment Code",
        Globalization.paymentDescription: "Payment Description",
        Globalization.paymentType: "Payment Type",
        Globalization.cash: "Cash",
        Globalization.qrPayment: "QR Payment",
        Globalization.paymentTerminal: "Payment Terminal",
        Globalization.revenueMonster: "Revenue Monster",
        Globalization.others: "Others",
        Globalization.openCashDrawer: "Open Cash Drawer",
        Globalization.requireReference: "Require Reference",
        Globalization.addPayment: "Add Payment",
        Globalization.editPaymentMethod: "Edit Payment Method",
        Globalization.saveChanges: "Save Changes",

        //Company Profile Page
        Globalization.companyInfo: "Company Info",
        Globalization.companyName: "Company Name",
        Globalization.companyROC: "Company ROC",
        Globalization.address: "Address",
        Globalization.address1: "Address 1",
        Globalization.address2: "Address 2",
        Globalization.address3: "Address 3",
        Globalization.address4: "Address 4",
        Globalization.contactInfo: "Contact Info",
        Globalization.contactNo: "Contact No.",
        Globalization.updateProfile: "Update Profile",

        Globalization.taxNo: "Tax No.",
        Globalization.email: "Email",
        Globalization.tinNo: "TIN No.",

        //Weight Scale Setting Page
        Globalization.connectDigitalWeightMachine:
            "Connected to Digital Weight Machine",

        //Maintain Item
        Globalization.itemDetails: "Item Details",
        Globalization.itemImage: "Item Image",
        Globalization.itemCode: "Item Code",
        Globalization.itemDescription: "Item Description",
        Globalization.additionalDescription: "Additional Description",
        Globalization.addUom: "Add UOM",
        Globalization.baseUom: "Base UOM",
        Globalization.itemUom: "Item UOM",
        Globalization.uomCode: "UOM Code",
        Globalization.uomRate: "UOM Rate",
        Globalization.altBarcode: "Alternative Barcode",
        Globalization.saveRecord: "Save Record",
        Globalization.itemType: "Item Type",
        Globalization.classification: "Classification",
        Globalization.taxCode: "Tax Code",
        Globalization.tariff: "Tariff",

        //Reports Page
        Globalization.fromDate: "From Date",
        Globalization.toDate: "To Date",
        Globalization.reportType: "Report Type",
        Globalization.apply: "Apply",
        Globalization.docDate: "Doc. Date",
        Globalization.docNo: "Doc. No",
        Globalization.shiftNo: "Shift No",
        Globalization.docTotal: "Doc. Total",
        Globalization.counterOpenTime: "Open Counter Time",
        Globalization.openBy: "Open By",
        Globalization.counterCloseTime: "Close Counter Time",
        Globalization.closeBy: "Close By",
        Globalization.totalIn: "Total Cash In",
        Globalization.totalOut: "Total Cash Out",
        Globalization.warehouse: "Warehouse",
        Globalization.counter: "Counter",
        Globalization.shift: "Shift",
        Globalization.openingCash: "Opening Cash",
        Globalization.sales: "Sales",
        Globalization.salesReturn: "Sales Return",
        Globalization.confirmCloseCounter:
            "Are you sure you want to close the counter?",
        Globalization.closeCounterClearHoldBill:
            "Please clear all hold bills before close the counter.\nDo you want to clear it now?",
        Globalization.confirmUploadPendingData:
            "There are pending documents that haven't upload to server.\nDo you want to upload now?",
        Globalization.counterInfo: "Counter Info",
        Globalization.loadReport: "Load Report",

        //Sync Log Page
        Globalization.docType: "Document Type",
        Globalization.syncTime: "Sync Date",
        Globalization.status: "Status",
        Globalization.clearAllPendingRecords: "Clear All Pending Records",

        //Sales Document Listing
        Globalization.salesDocument: "Sales Document",
        Globalization.salesDocumentListing: "Sales Document Listing",
        Globalization.returnDocumentListing: "Return Document Listing",
        Globalization.salesDocumentDetails: "Sales Document Details",
        Globalization.returnDocumentDetails: "Return Document Details",
        Globalization.salesPaymentDetails: "Sales Payment Details",
        Globalization.refundPaymentDetails: "Refund Payment Details",

        //Shift Listing
        Globalization.shiftListing: "Shift Listing",

        //Cash In/Out By Shift
        Globalization.cashIOListing: "Cash In/Out Listing",

        //Item Sales Summary
        Globalization.itemSalesSummary: "Item Sales Summary",

        //Payment Page
        Globalization.invalidAmt: "Invalid Amount",
        Globalization.invalidPaymentMethod: "Invalid Payment Method",
        Globalization.confirmRemovePayment:
            "Are you sure you want to remove this payment?",
        Globalization.insufficientAmount: "Insufficient Amount",
        Globalization.saving: "Saving",
        Globalization.paidAmt: "Paid Amount",
        Globalization.confirmClearAllPayment:
            "Discount have to make before payment. This will clear all payment.\nYou sure you want to continue?",
        Globalization.changeAmt: "Change Amount",
        Globalization.balanceAmt: "Balance Amount",
        Globalization.totalPaidAmt: "Total Paid Amount",
        Globalization.totalRefundAmt: "Total Refund Amount",
        Globalization.checkOut: "Check Out",
        Globalization.refund: "Refund",
        Globalization.grandTotal: "Grand Total",
        Globalization.confirmCancelPayment:
            "Are you sure you want to cancel payment?",
        Globalization.only: "Only",
        Globalization.paymentMethodAllowed: "payment method allowed",
        Globalization.currentPaymentMethodNotAllow:
            "This payment method is not allow",
        Globalization.balanceNotEnoughToPay:
            "Your balance is not enough to pay",
        Globalization.amountIsFullyPaid: "Amount is fully paid",
        Globalization.ezypointCannotBeRemove: "EZYPOINT cannot be remove",
        Globalization.ezypointCannotBeEdit: "EZYPOINT cannot be edit",

        //Customer Info
        Globalization.customerName: "Customer Name",
        Globalization.customerName2: "Customer Name2",
        Globalization.rocIcPassport: "ROC/IC/Passport",
        Globalization.tinNumber: "TIN Number",
        Globalization.emailAddress: "E-Mail Address",

        //Price Checker Page
        Globalization.findItemWithQuickScan:
            "Find the item price with a quick scan",

        //Welcome Page
        Globalization.welcome: "Welcome",
        Globalization.choosingEzyRetailProAndBegin:
            "Thank You for choosing EzyRetail Pro. It is a joy for us to help you with our products.\nLet's select your option to start.",
        Globalization.activate: "Activate",
        Globalization.licenseAlreadyActivateInDevice:
            "I already have my license and would like to activate in this device",
        Globalization.registerTrial: "Register for trial",
        Globalization.interestedTrialPeriodToTest:
            "I'm interested in its features and would like to inquire a trial period to test",
        Globalization.trySampleData: "Try with sample data",
        Globalization.interestedSampleData:
            "I'm interested in experimenting with sample data to grasp its functionality",
        Globalization.confirmCancelSetupUnableLoginUntilComplete:
            "This will cancel setup and you will not able to login until you complete the setup\nDo you want to continue?",
        Globalization.connectingToHost: "Connecting To Host",

        //Change App Ver Page
        Globalization.changeEdition: "Change Edition",
        Globalization.warningBeforeChangeEdition:
            "Before you start, please be remind that change of edition might need to reset your database. Please backup before you perform any action. Let's select your option to start.",
        Globalization.directToServerPage: "Direct me to server settings page",
        Globalization.generateNewEzyLinkToolsEdition:
            "Generate new EzyLink Tools Edition",
        Globalization.generateCloudEdition: "Generate new Online Cloud edition",
        Globalization.generateEmptyStandaloneEdition:
            "Generate empty stand alone edition",
        Globalization.restoreOwnBackupEdition: "Restore my backup",
        Globalization.generateStandaloneWithSample:
            "Generate stand alone with sample data",
        Globalization.generateDatabase: "Generate Database",
        Globalization.generateSampleDatabase: "Generate Sample Database",
        Globalization.invalidBackupFile: "Invalid Backup File",
        Globalization.advanceOptions: "Advance Options",
        Globalization.confirmResetCreateNewDb:
            "This process will reset and create a new database.\nDo you want to continue?",

        //Version Option Page
        Globalization.standalone: "Stand alone",
        Globalization.operateIndependently:
            "My POS operate independently, not connected to any data server",
        Globalization.connectedToEzyLinkToolsServer:
            "My POS is connected to EzyLink tools, all my master data is from application server",
        Globalization.dealerUse: "Dealer Use",
        Globalization.forInternalUseOnly: "For internal use only",
        Globalization.loadSettings: "Load Settings",
        Globalization.choosePosEdition: "Choose your POS editions",

        //User Maintenance Page
        Globalization.userDetails: "User Details",
        Globalization.accessLevel: "Access Level",
        Globalization.administrator: "Administrator",
        Globalization.allowAccessAllOptions:
            "(Allow access all options in the system)",
        Globalization.supervisor: "Supervisor",
        Globalization.allowAccessMostOptionAcceptDelete:
            "(Allow access most options other than delete)",
        Globalization.systemUser: "System User",
        Globalization.allowAccessBasicFunction:
            "(Allow access basic function of the system)",
        Globalization.userIdExists: "User ID already exist",
        Globalization.fastLoginPinExists: "Fast Login PIN already exist",
        Globalization.confirmDeleteSelectedUser:
            "Are you sure want to delete selected User?",
        Globalization.selectedUserOperationExistDelete:
            "Selected User perform operation before, delete is not allowed",

        //Stock Item Page
        Globalization.itemIsUsedNotAllowedDelete:
            "Deletion failed. This item has been used in system",
        Globalization.confirmToDeleteSelectedItem:
            "Are you sure you want to delete selected item?",

        //Last Bill Page
        Globalization.invoiceList: "Invoice List",
        Globalization.confirmReturnSelectedItem:
            "Are you confirm to return selected item?",
        Globalization.invoiceDetails: "Invoice Details",
        Globalization.paymentDetails: "Payment Details",
        Globalization.confirmCreateSalesReturn:
            "Are you sure want to initiate a sales return?",
        Globalization.previousReturned: "Previous Returned",
        Globalization.currentReturn: "Current Return",
        Globalization.allItemsReturned: "All items returned",
        Globalization.confirmReturnAllDiscountedItem:
            "You are only allow to return all items for discounted items. Do you want to continue?",
        Globalization.invalidReturnQty: "Invalid return Quantity",
        Globalization.itemReturnedOnSelectedDoc:
            "There are item returned in selected document.\nSales return is not allowed.",

        //Signup Page
        Globalization.businessInfo: "Business Info",
        Globalization.infoUseOnPrinting:
            "This information will use in receipt printing",
        Globalization.postCode: "Postcode",
        Globalization.state: "State",
        Globalization.city: "City",
        Globalization.fullname: "Full Name",
        Globalization.recordOwnerApplication:
            "This is to record the owner of this application",
        Globalization.contactNumber: "Contact Number",
        Globalization.emptyCompName: "Company Name cannot be empty",
        Globalization.emptyAddress: "Address cannot be empty",
        Globalization.emptyFullName: "Full Name cannot be empty",
        Globalization.emptyContactNumber: "Contact Number cannot be empty",
        Globalization.emptyEmail: "Email cannot be empty",

        //Member / Customer
        Globalization.expiredDate: "Expired Date",
        Globalization.noMemberServer: "No Member Server",
        Globalization.noConnectAnyMemberSvr:
            "Not connected to any member server",
        Globalization.ezyMemberServerSetting: "EzyMember Server Settings",
        Globalization.connectedEzyMemberSvr: "Connected to EzyMember server",
        Globalization.enableEzyMember: "Enable EzyMember",
        Globalization.connectionErrorCheckSetting:
            "Connection Error, please check your connection settings",
      };
}
