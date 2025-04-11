import "package:ezyretail/models/my_printer.dart";
import "package:intl/intl.dart";
// import "package:presentation_displays/displays_manager.dart";

import "models/company_profile_model.dart";

bool activateStatus = false;
int licenceMode = 2;
// 0 = Stand Alone
// 1 = Link Tools
// 2 = Demo
// 3 = Cloud

//Backup path
String defaultBackupPath = "";

String manualUpdateUrl = "";

//Auto Sync
bool syncMemberLogInProgress = false;
bool syncInProgress = false;
int autoSynchronizeTime = 0;
bool autoSyncItem = false;
bool autoSyncImage = false;
bool syncEInvoiceInProgress = false;

int memberSyncDelayMinutes = 15;
int eInvoiceSyncDelayMinutes = 15;

String systemLanguage = "en_US";

CompanyProfileModel? systemCompanyProfile;
String systemBatchKey = "";

int globalMenuHeaderRows = 2;
int globalMenuDetailColumn = 4;
int menuTextSize = 12;

int maxPayment = 1;
int paymentMenuColumn = 3;
int paymentCompleteDelay = 3;

bool usePinLogin = false;

int cent1 = 0;
int cent2 = 0;
int cent3 = 0;
int cent4 = 5;
int cent5 = 5;
int cent6 = 5;
int cent7 = 5;
int cent8 = 10;
int cent9 = 10;

int counter = 0;
String wareHouse = "";
String loginUserKey = "";
int userAccess = 1;
String loginUserName = "";
String loginUserPin = "";
String loginPass = "";
bool accessQty = false;
bool accessCost = false;

String companyId = "";
String serverIp = "";
String serverPort = "";
String serverKey = "";
String appId = "";

String cloudToken = "";
String companyKey = "";
String serverUrl = "";
String publicKey = "";
String privateKey = "";

//EzyMember Server
// bool ezyMemberEnable = false;
String memberServerId = "";
String memberCompanyId = "";
String memberServerUrl = "";
String memberPublicKey = "";
String memberPrivateKey = "";
bool memberIsActive = false;

int ezyMemberEarnPoint = 0;
int ezyMemberEarnPrice = 0;
int ezyMemberRedeemPoint = 0;
int ezyMemberRedeemPrice = 0;
int ezyMemberRoundingMethod = 0;

String lastLogin = "";
String lastSync = "";
String lastImgSync = "";

bool livedata = false;

//Scale Barcode Setting
int barcodeLength = 0;
int codeStart = 0;
int codeEnd = 0;
int qtyStart = 0;
int qtyEnd = 0;
int decimalDigit = 0;

//Currency Settings Start
enum CurrencyPosition { left, right }

String currencySymbol = 'RM';
CurrencyPosition currencyPosition = CurrencyPosition.left;
DateFormat systemShortDate = DateFormat("dd/MM/yyyy");
DateFormat systemLongDate = DateFormat("dd/MM/yyyy HH:mm");
DateFormat systemTime = DateFormat("HH:mm a");
DateFormat systemDateTime = DateFormat("dd/MM/yyyy HH:mm:00");
DateFormat cloudDateTime = DateFormat("yyyy-MM-dd HH:mm:ss");
DateFormat dbDateFormat = DateFormat("yyyy-MM-dd");

bool enableUseCameraToScan = true;
bool showMenuByDefault = true;
bool mergeDuplicateSales = false;
bool requireRemarkOnHoldBil = false;
bool allowZeroOpenCounter = false;
bool allowZeroItemPrice = false;
bool promptOnZeroPriceItem = true;
bool cashOutAttachment = false;

int unitPriceDecPlace = 2;
int quantityDecPlace = 1;

//Printer Settings
// MyPrinter? selectedGlobalPrinter;
// PaperSize selectedGlobalPaperSize = PaperSize.mm58;
bool directlyPrintReceipt = false;
bool useCashDrawer = false;
bool iminCashDrawer = false;
int defaultPrintCopy = 1;
bool printQty = false;
bool printCompanyLogo = false;

bool iminBuildInDisplay = false;

DateTime lastSyncItemDate = DateTime.now();
DateTime lastSyncImgDate = DateTime.now();
DateTime lastSyncCustomerDate = DateTime.now();

String powerByText = "Powered by EzyRetail POS";

//Modules Control
bool enableInventoryModule = false;

//Second Display Control
bool dualScreenDisplay = false;
int secondDisplayIndex = -1;
String secondDisplayName = "";
// DisplayManager? secondScreenManager;

String whatsappVersion = ""; //businessWhatsapp/whatsapp

//email settings
bool enableEzyMail = false;
bool autoSendClosingReport = false;

//eInvoice Control
String eInvoiceUrl = "";
String eInvoiceKey = "";
String eInvoiceExpired = "";
String eInvoiceClientId = "";
bool eInvoiceEnable = false;

bool keepScreenAwakeOnSales = true;
bool allowCrossDay = false;
