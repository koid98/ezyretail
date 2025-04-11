import '../globalization.dart';

class MsMy {
  static Map<String, String> get keys => {
        //Login Page
        Globalization.login: "Log Masuk",
        Globalization.userID: "ID Pengguna",
        Globalization.password: "Kata Laluan",
        Globalization.userPIN: "PIN Pengguna",
        Globalization.fastLoginPIN: "PIN Log Masuk",
        Globalization.emptyFastLoginPIN: "PIN Log Masuk Kosong",
        Globalization.emptyUserID: "ID Pengguna Kosong",
        Globalization.emptyPassword: "Kata Laluan Kosong",
        Globalization.invalidLoginCred: "Kelayakan log masuk tidak sah",

        Globalization.resetAdminPassword: "Tetapkan Semula Kata Laluan",
        Globalization.changeMachineId: "Tukar ID aplikasi",
        Globalization.checkPermission: "Semak Kebenaran",

        //Buttons
        Globalization.close: "Tutup",
        Globalization.yes: "Ya",
        Globalization.no: "Tidak",
        Globalization.confirm: "Mengesah",
        Globalization.cancel: "Batal",
        Globalization.download: "Muat Turun",
        Globalization.upload: "Muat Naik",
        Globalization.backup: "Sandaran",
        Globalization.restore: "Memulih",
        Globalization.applySaveSetting: "Terapkan & Simpan Tetapan",
        Globalization.submit: "Serah",
        Globalization.save: "Simpan",

        Globalization.price: "Harga",
        Globalization.amount: "Jumlah",
        Globalization.date: "Tarikh",
        Globalization.user: "Pengguna",
        Globalization.qty: "QTY",

        //Menu Page
        Globalization.operationFunctions: "Fungsi Operasi",
        Globalization.posModule: "Modul POS",
        Globalization.salesScreen: "Skrin Jualan",
        Globalization.openCounter: "Buka Kaunter",
        Globalization.closeCounter: "Tutup Kaunter",
        Globalization.cashInOut: "Tunai Masuk/Keluar",
        Globalization.stockAdjustment: "Pelarasan Stok",
        Globalization.logout: "Log Keluar",
        Globalization.salesOder: "Pesanan Jualan",
        Globalization.salesInvoice: "Invois Jualan",
        Globalization.customerPayment: "Bayaran Pelanggan",

        Globalization.reports: "Laporan",
        Globalization.generalReports: "Laporan Am",
        Globalization.malaysiaEInvoice: "E-Invois Malaysia",
        Globalization.consolidatedEInvoice: "Penyatuan E-Invois",
        Globalization.documentSyncReport: "Laporan Segerakkan Dokumen",
        Globalization.membersSyncReport: "Laporan Segerakkan Ahli",
        Globalization.eInvoiceSyncReport: "Laporan Penyegerakan MyInvois",
        Globalization.stockReport: "Laporan Stok",
        Globalization.stockBalanceReport: "Laporan Baki Stok",
        Globalization.stockCardReport: "Laporan Kad Stok",
        Globalization.balanceQty: "Baki Kuantiti",
        Globalization.stockIn: "Stok Masuk",
        Globalization.stockOut: "Stok Keluar",
        Globalization.documentListing: "Senarai Dokumen",

        Globalization.maintenance: "Penyelenggaraan",
        Globalization.stockItem: "Barang Jualan",
        Globalization.member: "Ahli",
        Globalization.menuSettings: "Tetapan Menu",
        Globalization.paymentMethod: "Kaedah Pembayaran",
        Globalization.dataManagement: "Pengurusan Data",
        Globalization.companyProfile: "Profil Syarikat",
        Globalization.companyLogo: "Logo Syarikat",
        Globalization.hardwareSettings: "Tetapan perkakasan",
        Globalization.settings: "Settings",
        Globalization.systemSettings: "Tetapan Sistem",
        Globalization.generalSettings: "Tetapan Umum",
        Globalization.counterSettings: "Tetapan Kaunter",
        Globalization.scaleSettings: "Tetapan Skala Berat",

        Globalization.serverSettings: "Tetapan Pelayan",
        Globalization.userMaintenance: "Pengurusan Pengguna",

        //Data Managment Page
        Globalization.fullDownload: "Muat Turun Penuh",
        Globalization.downloadMaster: "Muat Turun Rekod Utama",
        Globalization.downloadSysSetting: "Muat Turun Tetapan Sistem",
        Globalization.downloadCustomer: "Muat Turun Data Pelanggan",
        Globalization.downloadItemMaster: "Muat Turun Stok",
        Globalization.downloadItemImage: "Muat Turun Imej Item",
        Globalization.syncData: "Sinkronan Data",
        Globalization.autoUploadTime: "Masa Rekod Muat Naik Automatik",
        Globalization.minutes: "Minit",
        Globalization.uploadData: "Muat Naik Data",
        Globalization.uploadNewRecord: "Muat Naik Rekod Baharu",
        Globalization.uploadRecordBetweenDate:
            "Muat Naik Rekod Antara Tarikh Shift",
        Globalization.backupRestoreData: "Sandaran dan Pemulihan Data",
        Globalization.backupData: "Sandaran Data",
        Globalization.restoreData: "Pemulihan Data",
        Globalization.purgeData: "Padam Data",
        Globalization.truncateDateBefore: "Padam sebelum tarikh",
        Globalization.deleteAllTransaction: "Padam semua transaksi",
        Globalization.deleteAllData: "Padam semua data",
        Globalization.selectDate: "Pilih Tarikh",
        Globalization.selectDateRange: "Pilih Julat Tarikh",
        Globalization.downloadingSysSetting:
            "Sedang Memuat Turun Tetapan Sistem",
        Globalization.saveSysSetting: "Simpan Tetapan Sistem",
        Globalization.failInsertCompanyProfile:
            "Gagal memasukkan Profil Syarikat",
        Globalization.failInsertPosUser: "Gagal memasukkan Pos Pengguna",
        Globalization.failInsertPymtMethod:
            "Gagal memasukkan Kaedah Pembayaran",
        Globalization.downloadingItemMaster: "Sedang Muat Turun Stok",
        Globalization.errorInsertItemMaster: "Ralat Masukkan Stok",
        Globalization.downloadingItemBarcode: "Sedang Muat Turun Kod Bar Stok",
        Globalization.insertItemMasterBarcode: "Memasukkan Kod Bar Stok",
        Globalization.downloadingItemMenu: "Memuat Turun Menu Stok",
        Globalization.insertItemMenuHdr: "Memasukkan Tajuk Menu Stok",
        Globalization.insertItemMenuDtl: "Memasukkan Butiran Menu Stok",
        Globalization.downloadingItemImage: "Sedang Muat Turun Imej Stok",
        Globalization.downloadingCustomer: "Sedang Muat Turun Pelanggan",
        Globalization.downloadComplete: "Muat Turun Selesai",
        Globalization.confirmClearPOSTransaction:
            "Ini akan mengosongkan data transaksi POS. Adakah anda mahu meneruskan?",
        Globalization.operationComplete: "Operasi Selesai",
        Globalization.confirmClearResetPOSData:
            "Ini akan mengosongkan dan menetapkan semula data POS. Adakah anda mahu meneruskan?",
        Globalization.confirmClearWithPendingData:
            "Terdapat dokumen tertunda yang belum dimuat naik ke pelayan. Adakah anda ingin meneruskan?",
        Globalization.closeCounterBeforeBackup:
            "Sila tutup kaunter sebelum membuat sandaran",
        Globalization.closeCounterBeforeRestore:
            "Sila tutup kaunter sebelum membuat pemulihan",
        Globalization.confirmBackupImages:
            "Adakah anda mahu membuat sandaran imej?",
        Globalization.backupImage: "Imej Sandaran",
        Globalization.backupComplete: "Sandaran Selesai",
        Globalization.path: "Laluan Fail",
        Globalization.errorInBackup: "Ralat ditemui dalam fail sandaran",
        Globalization.confirmDataRestoreOverwriteAndRestart:
            "Pemulihan pangkalan data akan menimpa pangkalan data sedia ada anda dan aplikasi perlu dimulakan semula.\nAdakah anda mahu meneruskan?",
        Globalization.restoreCompleteLogout:
            "Pemulihan selesai, sistem akan log keluar sekarang",
        Globalization.noPendingDocumentFound: "Tiada dokumen tertunda ditemui",
        Globalization.dataRestore: "Pemulihan Data",
        Globalization.confirmDownloadItemData:
            "Anda ingin muat turun data stok sekarang?",
        Globalization.confirmDownloadItemImage:
            "Anda ingin muat turun imej item sekarang?",
        Globalization.defaultBackupFolder: "Folder Sandaran (Default)",
        Globalization.downloadMemberRecord: "Muat Turun Rekod Ahli",
        Globalization.downloadMemberCompleted: "Muat Turun Ahli Selesai",
        Globalization.uploadCompleted: "Muat Naik Selesai",
        Globalization.backupFolder: "Folder sandaran",
        Globalization.saveToFolder: "Simpan ke folder ini",
        Globalization.defaultFolderNotFound:
            "Folder sandaran (Default) tidak ditemui, sandaran automatik gagal",
        Globalization.failConnectServer: "Gagal Menyambung ke Pelayan",

        Globalization.syncItemMastSubtitles:
            "Termasuk item, kod bar item, dan menu",
        Globalization.syncItemImageSubtitles: "Termasuk imej item",
        Globalization.uploadTransactionData: "Muat Naik Data Transaksi",
        Globalization.uploadTransDataSubtitles:
            "Termasuk jualan tunai dan pemulangan jualan",

        //Cash In Out
        Globalization.cashIn: "Masuk Tunai",
        Globalization.cashOut: "Keluar Tunai",
        Globalization.historyCashInOut: "Rekod Masuk dan Keluar Tunai",
        Globalization.reason: "Sebab",
        Globalization.cashInAmount: "Jumlah Tunai Masuk",
        Globalization.cashOutAmount: "Jumlah Tunai Keluar",
        Globalization.emptyAmount: "Jumlah tidak boleh kosong",
        Globalization.attachment: "Lampiran",

        // Dialog
        Globalization.information: "Maklumat",
        Globalization.error: "Ralat",
        Globalization.isNull: "Tiada",
        Globalization.warning: "Amaran",
        Globalization.settingSaved: "Tetapan Disimpan",
        Globalization.connectionFail: "Sambungan Gagal",
        Globalization.remark: "Catatan",
        Globalization.reference: "Rujukan",
        Globalization.fieldCannotBeEmpty: "Teks Tidak Boleh Kosong",
        Globalization.codeExist: "Kod Sudah Wujud",
        Globalization.uomMustMore:
            "Kadar Ukuran Mestilah Lebih Atau Sama Dengan 2",
        Globalization.operationFail: "Operasi Tidak Berjaya",
        Globalization.confirmation: "Pengesahan",
        Globalization.areYouSure: "Adakah Anda Pasti?",
        Globalization.uomOptions: "Pilihan Ukuran",
        Globalization.doYouWantRetry: "Anda ingin cuba lagi?",
        Globalization.search: "Carian",
        Globalization.filterOptions: "Pilihan Penapis",
        Globalization.filterByMember: "Tapis dokumen mengikut ahli",
        Globalization.filterByItem: "Tapis dokumen mengikut stok",
        Globalization.filterByDocument: "Tapis dokumen mengikut nombor dokumen",

        // Printer Settings Page / Hardware Setting Page
        Globalization.printerSettings: "Tetapan Pencetak",
        Globalization.connectionType: "Jenis Sambungan",
        Globalization.searchPrinter: "Cari Pencetak",
        Globalization.connect: "Sambung",
        Globalization.none: "Tiada",
        Globalization.usb: "USB",
        Globalization.bluetooth: "Bluetooth",
        Globalization.network: "Rangkaian",
        Globalization.selectedPrinter: "Pencetak Terpilih",
        Globalization.testDrawer: "Uji Laci Tunai",
        Globalization.paperSize: "Saiz Kertas",
        Globalization.connectCashDrawer: "Sambung Laci Tunai",
        Globalization.directPrintReceipt: "Cetak Resit Terus",
        Globalization.printQuantity: "Cetak Kuantiti Barang",
        Globalization.pleaseSelectConnectionType: "Sila Pilih Jenis Sambungan",
        Globalization.devicesFound: "Peranti Ditemui",
        Globalization.select: "Pilih",
        Globalization.unset: "Lupuskan",
        Globalization.connected: "Bersambung",
        Globalization.printerConnectedSuccessful:
            "Pencetak Berjaya Disambungkan",
        Globalization.pleaseKeyInPrinterAddress:
            "Sila Masukkan Alamat Pencetak",
        Globalization.testPrint: "Uji Pencetak",
        Globalization.failConnectPrinter: "Gagal menyambung ke pencetak",
        Globalization.printReceipt: "Cetak Resit",
        Globalization.printCopies: "Salinan cetak :",
        Globalization.defaultReceiptCopy: "Salinan Resit Lalai",
        Globalization.iMinDevice: "Peranti iMin",

        //Sales Screen Page
        Globalization.priceChecker: "Harga (Semak)",
        Globalization.holdBill: "Tahan Bil",
        Globalization.loadBill: "Muat Bil",
        Globalization.lastBill: "Bil Terakhir",
        Globalization.drawer: "Laci",
        Globalization.barcode: "Kod Bar",
        Globalization.uPrice: "H.Seunit",
        Globalization.unitPrice: "Harga Unit",
        Globalization.quantity: "Kuantiti",
        Globalization.discount: "Diskaun",
        Globalization.subTotal: "Jumlah",
        Globalization.scan: "Imbas",
        Globalization.clearSalesCart: "Kosongkan Troli Jualan",
        Globalization.emptyCart: "Troli Kosong",
        Globalization.itemNotFound: "Item Tidak Ditemui",
        Globalization.confirmToExit: "Adakah anda pasti ingin keluar?",
        Globalization.confirmToRemoveItem:
            "Adakah anda pasti ingin membuang item ini?",
        Globalization.changeUnitPriceFrom:
            "Adakah anda ingin menukar harga unit dari",
        Globalization.changeTo: "kepada",
        Globalization.cartItemExistConfirm:
            "Troli mengandungi item. Anda ingin teruskan?",
        Globalization.taxAmt: "Jumlah Cukai",
        Globalization.rounding: "Pembulatan",
        Globalization.docAmt: "Jumlah Dokumen",
        Globalization.clearHoldBillDoc: "Lupuskan Dokumen Bil Ditahan",
        Globalization.dateTime: "Tarikh Masa",
        Globalization.invalidQty: "Kuantiti Tidak Sah",
        Globalization.invalidValue: "Nilai Tidak Sah",
        Globalization.invalidDiscount: "Diskaun Tidak Sah",
        Globalization.total: "Jumlah",

        Globalization.notAllowBecauseReturnMsg:
            "Barang pulangan jualan dalam senarai, operasi tidak dibenarkan",
        Globalization.salesTotalCannotLessThanOrEqualZero:
            "Jumlah jualan tidak boleh kurang daripada atau sama dengan 0",
        Globalization.salesTotalCannotLessThanZero:
            "Jumlah jualan tidak boleh kurang daripada 0",
        Globalization.salesTotalustGreaterThanZero:
            "Jumlah jualan mestilah lebih besar daripada 0",

        //System Setting Page
        Globalization.sysLanguage: "Bahasa Sistem",
        Globalization.useCameraAsScanner: "Gunakan Kamera sebagai Pengimbas",
        Globalization.mergeDuplicateItem: "Gabungkan Stok Berduplikasi",
        Globalization.currencySymbol: "Simbol Mata Wang",
        Globalization.currencyPosition: "Kedudukan Mata Wang",
        Globalization.unitPriceRoundDecimal:
            "Pembulatan Tempat Decimal Harga Unit",
        Globalization.qtyRoundDecimal: "Pembulatan Tempat Decimal Kuantiti",
        Globalization.centRoundingOptions: "Pilihan Pembundaran Sen",
        Globalization.requireRemarkOnHoldBill:
            "Memerlukan Catatan Semasa Tahan Bil",
        Globalization.allowZeroOpencounter: "Benarkan Sifar Dalam Buka Kaunter",
        Globalization.emptyCurrencySymbol:
            "Simbol Mata Wang tidak boleh kosong",
        Globalization.allowZeroItemPrice: "Benarkan Harga Item Kosong",
        Globalization.promptOnZeroPriceItem: "Gesaan pada Item Harga Kosong",
        Globalization.cashOutRequireAttachment:
            "Lampiran Diperlukan Untuk Mengeluarkan Wang",
        Globalization.documentPrefixLabel: "Label Awalan Dokumen",
        Globalization.allowCounterCrossDay: "Benarkan Kaunter Lintas Hari",

        //Server Setting Page
        Globalization.localServerConnection: "Sambungan Pelayan Data Lokal",
        Globalization.profileName: "Nama Profil",
        Globalization.serverIPAdd: "Alamat IP Pelayan",
        Globalization.serverPort: "Port Pelayan",
        Globalization.hostPassword: "Kata Laluan Hos",
        Globalization.connectUpdateSetting: "Sambung & Kemaskini Tetapan",
        Globalization.ezyMemberServerConnection: "Sambungan Pelayan Ezymember",
        Globalization.serverID: "ID Pelayan",
        Globalization.companyKey: "Kekunci Syarikat",
        Globalization.serverUrl: "URL Pelayan",
        Globalization.publicKey: "Kekunci Awam",
        Globalization.privateKey: "Kekunci Peribadi",
        Globalization.invalidQrCode: "Kod QR Tidak Sah",
        Globalization.invalidBarcode: "Kod Bar Tidak Sah",
        Globalization.emptyProfileName: "Nama Profil Kosong",
        Globalization.emptyServerIPAdd: "Alamat IP Pelayan Kosong",
        Globalization.emptyPort: "Port Kosong",
        Globalization.emptyHostPassword: "Kata Laluan Hos Kosong",
        Globalization.connectingToServer: "Menyambung ke Pelayan",
        Globalization.emptyServerID: "ID Pelayan Kosong",
        Globalization.emptyCompanyID: "ID Syarikat Kosong",
        Globalization.emptyCompanyKey: "Kekunci Syarikat Kosong",
        Globalization.emptyServerUrl: "URL Pelayan Kosong",
        Globalization.emptyPublicKey: "Kekunci Awam Kosong",
        Globalization.emptyPrivateKey: "Kekunci Peribadi Kosong",
        Globalization.connectServerSuccessful: "Berjaya Sambung ke Pelayan",
        Globalization.updateSuccessful: "Berjaya Kemaskini",
        Globalization.pairServer: "Memadankan Pelayan",
        Globalization.cloudServer: "Pelayan Awan",
        Globalization.noRegisterTokenUpdateAbort:
            "Token daftar tiada ditemui, kemas kini dibatalkan",

        Globalization.updateServerSettings: "Kemas Kini Tetapan Pelayan",

        Globalization.next: "Seterusnya",
        Globalization.back: "Balik",

        Globalization.serverType: "Jenis Sambungan Pelayan Data",
        Globalization.emailServerSettings: "Tetapan Pelayan E-mel",
        Globalization.enableEmailService: "Aktifkan Perkhidmatan E-mel",
        Globalization.autoEmailOnCloseCounter:
            "E-mel Auto pada Penutupan Kaunter",
        Globalization.invalidEmail: "Alamat E-mel Tidak Sah",

        //Menu Design Page
        Globalization.menuHeader: "Tajuk Menu",
        Globalization.menuDetail: "Butiran Menu",
        Globalization.showMenuByDefault: "Papar Menu Secara Lalai",
        Globalization.menuHdrRows: "Baris Tajuk Menu",
        Globalization.menuDtlColumns: "Lajur Butiran Menu",
        Globalization.confirmRemoveSelectedItem:
            "Adakah anda pasti ingin menghapuskan item yang dipilih?",
        Globalization.menuTextSize: "Saiz Huruf Menu",

        Globalization.newItem: "Item Baru",
        Globalization.editItem: "Edit Item",
        Globalization.deleteItem: "Padam Item",
        Globalization.reorderItem: "Susun Semula Item",
        Globalization.weightItem: "Barang Timbang",

        //Payment Method Page
        Globalization.paymentMenu: "Menu Bayaran",
        Globalization.paymentMenuSetting: "Tetapan Menu Pembayaran",
        Globalization.checkoutDelay: "Penangguhan Selepas Pembayaran",
        Globalization.maxPaymentMethod: "Kaedah Pembayaran Maksimum",
        Globalization.paymentMenuColumns: "Lajur Menu Pembayaran",
        Globalization.confirmRemovePaymentMethod:
            "Adakah anda pasti ingin padamkan kaedah pembayaran yang dipilih?",

        //Payment Method Page - Add / Edit
        Globalization.newPaymentMethod: "Kaedah Bayaran Baharu",
        Globalization.paymentCode: "Kod Bayaran",
        Globalization.paymentDescription: "Penerangan Bayaran",
        Globalization.paymentType: "Jenis Bayara",
        Globalization.cash: "Tunai",
        Globalization.qrPayment: "Pembayaran QR",
        Globalization.paymentTerminal: "Terminal Bayaran",
        Globalization.revenueMonster: "Revenue Monster",
        Globalization.others: "Lain-lain",
        Globalization.openCashDrawer: "Buka Laci Tunai",
        Globalization.requireReference: "Memerlukan Rujukan",
        Globalization.addPayment: "Tambah Bayaran",
        Globalization.editPaymentMethod: "Edit Kaedah Bayaran",
        Globalization.saveChanges: "Simpan Perubahan",

        //Company Profile Page
        Globalization.companyInfo: "Maklumat Syarikat",
        Globalization.companyName: "Nama Syarikat",
        Globalization.companyROC: "No. Pendaftaran Syarikat",
        Globalization.address: "Alamat",
        Globalization.address1: "Alamat 1",
        Globalization.address2: "Alamat 2",
        Globalization.address3: "Alamat 3",
        Globalization.address4: "Alamat 4",
        Globalization.contactInfo: "Maklumat Hubungi",
        Globalization.contactNo: "No. Hubungi",
        Globalization.updateProfile: "Kemaskini Profil",

        Globalization.taxNo: "No. Cukai",
        Globalization.email: "Emel",
        Globalization.tinNo: "No. Pendaftaran Cukai",

        //Weight Scale Setting Page
        Globalization.connectDigitalWeightMachine:
            "Sambung kepada Mesin Penimbang Digital",

        //Maintain Item
        Globalization.itemDetails: "Butiran Barang",
        Globalization.itemImage: "Gambar Barang",
        Globalization.itemCode: "Kod Barang",
        Globalization.itemDescription: "Penerangan Barang",
        Globalization.additionalDescription: "Penerangan Tambahan",
        Globalization.addUom: "Tambah Skala Ukuran",
        Globalization.baseUom: "Ukuran Asas",
        Globalization.itemUom: "Ukuran Barang",
        Globalization.uomCode: "Kod Ukuran",
        Globalization.uomRate: "Kuantiti Ukuran",
        Globalization.altBarcode: "Kod Bar Alternatif",
        Globalization.saveRecord: "Simpan Rekod",
        Globalization.itemType: "Jenis Barang",
        Globalization.classification: "Klasifikasi",
        Globalization.taxCode: "Kod Cukai",
        Globalization.tariff: "Kod Tarif",

        //Reports Page
        Globalization.fromDate: "Dari Tarikh",
        Globalization.toDate: "Sehingga Tarikh",
        Globalization.reportType: "Jenis Laporan",
        Globalization.apply: "Sahkan",
        Globalization.docDate: "Tarikh Dokumen",
        Globalization.docNo: "No. Dokumen",
        Globalization.shiftNo: "No. Syif",
        Globalization.docTotal: "Jumlah Dokumen",
        Globalization.counterOpenTime: "Masa Buka Kaunter",
        Globalization.openBy: "Dibuka Oleh",
        Globalization.counterCloseTime: "Masa Tutup Kaunter",
        Globalization.closeBy: "Ditutup Oleh",
        Globalization.totalIn: "Jumlah Masuk Tunai",
        Globalization.totalOut: "Jumlah Keluar Tunai",
        Globalization.warehouse: "Gudang",
        Globalization.counter: "Kaunter",
        Globalization.shift: "Syif",
        Globalization.openingCash: "Tunai Pembukaan",
        Globalization.sales: "Jualan",
        Globalization.salesReturn: "Pulangan Jualan",
        Globalization.confirmCloseCounter:
            "Adakah anda pasti ingin menutup kaunter?",
        Globalization.closeCounterClearHoldBill:
            "Sila kosongkan semua bil tertahan sebelum menutup kaunter.\nAdakah anda ingin mengosongkannya sekarang?",
        Globalization.confirmUploadPendingData:
            "Terdapat dokumen tertunda yang belum dimuat naik ke pelayan.\nAdakah anda ingin memuat naiknya sekarang?",
        Globalization.counterInfo: "Maklumat Kaunter",
        Globalization.loadReport: "Muat Laporan",

        //Sync Log Page
        Globalization.docType: "Jenis Dokumen",
        Globalization.syncTime: "Tarikh Penyegerakan",
        Globalization.status: "Status",
        Globalization.clearAllPendingRecords:
            "Kosongkan Semua Rekod Belum Selesai",

        //Sales Document Listing
        Globalization.salesDocument: "Dokumen Jualan",
        Globalization.salesDocumentListing: "Senarai Dokumen Jualan",
        Globalization.returnDocumentListing: "Senarai Dokumen Pulangan",
        Globalization.salesDocumentDetails: "Butiran Dokumen Jualan",
        Globalization.returnDocumentDetails: "Butiran Dokumen Pulangan",
        Globalization.salesPaymentDetails: "Butiran Bayaran Jualan",
        Globalization.refundPaymentDetails: "Butiran Bayaran Pulangan",

        //Shift Listing
        Globalization.shiftListing: "Senarai Syif",

        //Cash In/Out By Shift
        Globalization.cashIOListing: "Senarai Masuk/Keluar Tunai",

        //Item Sales Summary
        Globalization.itemSalesSummary: "Ringkasan Barang Jualan",

        //Payment Page
        Globalization.invalidAmt: "Jumlah Tidak Sah",
        Globalization.invalidPaymentMethod: "Kaedah Bayaran Tidak Sah",
        Globalization.confirmRemovePayment:
            "Adakah anda pasti ingin membuang pembayaran ini?",
        Globalization.insufficientAmount: "Baki Tidak Mencukupi",
        Globalization.saving: "Sedang Menyimpan",
        Globalization.paidAmt: "Jumlah Telah Dibayar",
        Globalization.confirmClearAllPayment:
            "Diskaun perlu dibuat sebelum pembayaran. Ini akan padamkan semua pembayaran. \nAnda pasti ingin teruskan?",
        Globalization.changeAmt: "Jumlah Baki",
        Globalization.balanceAmt: "Baki",
        Globalization.totalPaidAmt: "Jumlah Keseluruhan Dibayar",
        Globalization.totalRefundAmt: "Jumlah Keseluruhan Dikembalikan",
        Globalization.checkOut: "Bayar",
        Globalization.refund: "Bayaran Balik",
        Globalization.grandTotal: "Jumlah Keseluruhan",
        Globalization.confirmCancelPayment:
            "Adakah anda pasti ingin membatalkan pembayaran?",
        Globalization.only: "Hanya",
        Globalization.paymentMethodAllowed: "kaedah bayaran yang dibenarkan",
        Globalization.currentPaymentMethodNotAllow:
            "Kaedah pembayaran ini tidak dibenarkan",
        Globalization.balanceNotEnoughToPay:
            "Baki anda tidak mencukupi untuk membayar",
        Globalization.amountIsFullyPaid: "Jumlah dibayar sepenuhnya",
        Globalization.ezypointCannotBeRemove:
            "EZYPOINT tidak boleh dialih keluar",
        Globalization.ezypointCannotBeEdit: "EZYPOINT tidak boleh diedit",

        //Customer Info
        Globalization.customerName: "Nama Pelanggan",
        Globalization.customerName2: "Nama Pelanggan2",
        Globalization.rocIcPassport: "Pendaftaran Sykt./Kad Pengenalan/Pasport",
        Globalization.tinNumber: "No. Pendaftaran Cukai",
        Globalization.emailAddress: "Emel",

        //Price Checker Page
        Globalization.findItemWithQuickScan:
            "Cari harga item dengan imbasan pantas",

        //Welcome Page
        Globalization.welcome: "Selamat Datang",
        Globalization.choosingEzyRetailProAndBegin:
            "Terima kasih kerana memilih EzyRetail Pro. Ia merupakan suatu kegembiraan bagi kami untuk membantu anda dengan produk kami.\nMari pilih pilihan anda untuk memulakan.",
        Globalization.activate: "Aktifkan",
        Globalization.licenseAlreadyActivateInDevice:
            "Saya sudah memiliki lesen saya dan ingin mengaktifkan peranti ini",
        Globalization.registerTrial: "Daftar percubaan",
        Globalization.interestedTrialPeriodToTest:
            "Saya berminat dengan ciri-cirinya dan ingin menanyakan tempoh percubaan untuk cuba",
        Globalization.trySampleData: "Cuba dengan data sampel",
        Globalization.interestedSampleData:
            "Saya berminat untuk bereksperimen dengan data sampel untuk memahami fungsinya",
        Globalization.confirmCancelSetupUnableLoginUntilComplete:
            "Pembatalan tetapan persediaan akan menyebabkan anda tidak dapat log masuk sehingga tetapan selesai.\nAnda ingin teruskan?",
        Globalization.connectingToHost: "Menyambung ke Pelayan",

        //Change App Ver Page
        Globalization.changeEdition: "Tukar Edisi",
        Globalization.warningBeforeChangeEdition:
            "Sebelum anda mula, sila ambil perhatian bahawa penukaran edisi mungkin perlu menetapkan semula pangkalan data anda. Sila sandarkan sebelum anda melakukan sebarang tindakan. Marilah pilih pilihan anda untuk mula.",
        Globalization.directToServerPage:
            "Bawa saya ke halaman tetapan pelayan.",
        Globalization.generateNewEzyLinkToolsEdition:
            "Hasilkan Edisi Baharu EzyLink Tools",
        Globalization.generateCloudEdition: "Hasilkan Edisi Cloud baharu",
        Globalization.generateEmptyStandaloneEdition:
            "Hasilkan edisi berdiri sendiri yang kosong",
        Globalization.restoreOwnBackupEdition: "Pulihkan sandaran saya",
        Globalization.generateStandaloneWithSample:
            "Hasilkan berdiri sendiri dengan data sampel",
        Globalization.generateDatabase: "Hasilkan Pangkalan Data",
        Globalization.generateSampleDatabase: "Hasilkan Pangkalan Data Sampel",
        Globalization.invalidBackupFile: "Fail Backup Tidak Sah",
        Globalization.advanceOptions: "Pilihan Lanjutan",
        Globalization.confirmResetCreateNewDb:
            "Proses ini akan menetapkan semula pangkalan data dan mencipta pangkalan data baharu.\nAnda ingin teruskan?",

        //Version Option Page
        Globalization.standalone: "Berdiri Sendiri",
        Globalization.operateIndependently:
            "POS saya beroperasi secara diri sendiri, tidak disambungkan kepada mana-mana pelayan data.",
        Globalization.connectedToEzyLinkToolsServer:
            "POS saya disambungkan ke EzyLink tools, semua data induk saya berasal dari pelayan aplikasi",
        Globalization.dealerUse: "Penggunaan Pengedar",
        Globalization.forInternalUseOnly: "Hanya untuk kegunaan dalaman",
        Globalization.loadSettings: "Muat Tetapan",
        Globalization.choosePosEdition: "Pilih edisi POS anda",

        //User Maintenance Page
        Globalization.userDetails: "Butiran Pengguna",
        Globalization.accessLevel: "Tahap Akses",
        Globalization.administrator: "Pentadbir",
        Globalization.allowAccessAllOptions:
            "(Benarkan akses semua pilihan dalam sistem)",
        Globalization.supervisor: "Supervisor",
        Globalization.allowAccessMostOptionAcceptDelete:
            "(Benarkan akses kebanyakan pilihan selain daripada memadam)",
        Globalization.systemUser: "Pengguna Sistem",
        Globalization.allowAccessBasicFunction:
            "(Benarkan akses fungsi asas sistem)",
        Globalization.userIdExists: "ID Pengguna sudah wujud",
        Globalization.fastLoginPinExists: "PIN Log Masuk sudah wujud",
        Globalization.confirmDeleteSelectedUser:
            "Adakah anda pasti mahu memadam Pengguna yang dipilih?",
        Globalization.selectedUserOperationExistDelete:
            "Pengguna yang dipilih telah menjalankan operasi sebelum ini, pemadaman tidak dibenarkan",

        //Stock Item Page
        Globalization.itemIsUsedNotAllowedDelete:
            "Pemadaman gagal. Item ini telah digunakan dalam sistem",
        Globalization.confirmToDeleteSelectedItem:
            "Adakah anda pasti mahu memadam item yang dipilih?",

        //Last Bill Page
        Globalization.invoiceList: "Senarai Invois",
        Globalization.confirmReturnSelectedItem:
            "Adakah anda mengesahkan untuk memulangkan item yang dipilih?",
        Globalization.invoiceDetails: "Butiran Invois",
        Globalization.paymentDetails: "Butiran Pembayaran",
        Globalization.confirmCreateSalesReturn:
            "Adakah anda pasti mahu memulakan pemulangan jualan?",
        Globalization.previousReturned: "Pemulangan Sebelumnya",
        Globalization.currentReturn: "Pemulangan Semasa",
        Globalization.allItemsReturned: "Semua barangan telah buat pemulangan",
        Globalization.confirmReturnAllDiscountedItem:
            "Anda hanya dibenarkan memulangkan semua item untuk item diskaun. Adakah anda mahu meneruskan?",
        Globalization.invalidReturnQty: "Kuantiti pemulangan tidak sah",
        Globalization.itemReturnedOnSelectedDoc:
            "Terdapat item telah buat pemulangan dalam dokumen terpilih.\nPemulangan jualan tidak dibenarkan.",

        //Signup Page
        Globalization.businessInfo: "Maklumat Perniagaan",
        Globalization.infoUseOnPrinting:
            "Maklumat ini akan digunakan untuk mencetak resit",
        Globalization.postCode: "Poskod",
        Globalization.state: "Negeri ",
        Globalization.city: "Bandar",
        Globalization.fullname: "Nama Penuh",
        Globalization.recordOwnerApplication:
            "Ini untuk merekodkan pemilik aplikasi ini",
        Globalization.contactNumber: "Nombor Telefon",
        Globalization.emptyCompName: "Nama Syarikat tidak boleh kosong",
        Globalization.emptyAddress: "Alamat tidak boleh kosong",
        Globalization.emptyFullName: "Nama Penuh tidak boleh kosong",
        Globalization.emptyContactNumber: "Nombor Telefon tidak boleh kosong ",
        Globalization.emptyEmail: "Emel tidak boleh kosong",

        //Member / Customer
        Globalization.expiredDate: "Tarikh Tamat Tempoh",
        Globalization.noMemberServer: "Tiada Pelayan Ahli",
        Globalization.noConnectAnyMemberSvr:
            "Tidak bersambung dengan mana-mana pelayan ahli",
        Globalization.ezyMemberServerSetting: "Tetapan Pelayan EzyMember",
        Globalization.connectedEzyMemberSvr:
            "Bersambung dengan pelayan EzyMember",
        Globalization.enableEzyMember: "Aktifkan EzyMember",
        Globalization.connectionErrorCheckSetting:
            "Ralat sambungan, sila semak tetapan sambungan anda",
      };
}
