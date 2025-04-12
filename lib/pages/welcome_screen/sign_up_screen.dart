import 'dart:convert';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/helpers/ezy_smtp_server.dart';
import 'package:ezyretail/helpers/network_helper.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/custom_text_button.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../globals.dart';
import '../../language/globalization.dart';
import '../../models/company_profile_model.dart';
import '../../models/state_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPINLogin = false;
  bool invalidName = false;
  bool invalidPassword = false;
  bool sec = true;
  bool isBusy = false;
  String busyMessage = "";

  var companyNameController = TextEditingController();
  var add1NameController = TextEditingController();
  var add2NameController = TextEditingController();
  var add3NameController = TextEditingController();
  var add4NameController = TextEditingController();
  var postCodeController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var nameController = TextEditingController();
  var contactController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();

  String selectedCountry = "60";

  Country _selectedDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('60');

  List<String> malaysianStates = [
    "Johor",
    "Kedah",
    "Kelantan",
    "Melacca",
    "Negeri Sembilan",
    "Pahang",
    "Perak",
    "Perlis",
    "Pulau Penang",
    "Sarawak",
    "Selangor",
    "Terengganu",
    "Kuala Lumpur",
    "Labuan",
    "Sabah",
    "Putrajaya",
    "Others"
  ];

  String selectedStateOld = "Kuala Lumpur";
  String selectedState = "17";

  int formPage = 1;

  List<StateModel> allPostcodes = [];

  @override
  void initState() {
    super.initState();
    isPINLogin = usePinLogin;
    getAllPostcode();
  }

  Future<void> getAllPostcode() async {
    final jsonString = await rootBundle.loadString('assets/allPostcode.json');
    allPostcodes.clear();

    final List<dynamic> jsonData = jsonDecode(jsonString);

    allPostcodes = jsonData.map((item) => StateModel.fromJson(item)).toList();
  }

  FocusNode postcodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return portraitLayout();
            } else {
              return landscapeLayout();
            }
          },
        ),
        Visibility(
          visible: isBusy,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: LoadingIndicator(
              message: busyMessage,
            ),
          ),
        ),
      ],
    );
  }

  Widget portraitLayout() {
    return Scaffold(
      backgroundColor: ColorHelper.myWhite,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              color: ColorHelper.myDefaultBackColor,
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2 * 0.7,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset("assets/images/signup.png"),
                ),
              ),
            ),
            Container(
              color: ColorHelper.myWhite,
              constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: pageOptions(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landscapeLayout() {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: ColorHelper.myDefaultBackColor,
                child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset("assets/images/signup.png")),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: ColorHelper.myWhite,
                child: Center(
                  child: Container(
                    constraints:
                    const BoxConstraints(minWidth: 300, maxWidth: 400),
                    width: MediaQuery.of(context).size.width / 2 * 0.9,
                    child: pageOptions(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageOptions() {
    switch (formPage) {
      case 1:
        return companyInfoWidget();
      case 2:
        return contactInfoWidget();
      default:
        return companyInfoWidget();
    }
  }

  Widget companyInfoWidget() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: MediaQuery.of(context).orientation == Orientation.landscape
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          Globalization.businessInfo.tr,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        Text(
          Globalization.businessInfo.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        Text(
          Globalization.companyName.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: companyNameController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(10),
        Text(
          Globalization.address.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: add1NameController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(5),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: add2NameController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(5),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: add3NameController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(5),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: add4NameController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(10),
        MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
          children: [
            postcodeTextField(),
            const Gap(10),
            cityTextField(),
            const Gap(10),
            stateTextField(),
            const Gap(10),
            countryTextField(),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: postcodeTextField(),
                ),
                const Gap(10),
                Expanded(
                  child: cityTextField(),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: stateTextField(),
                ),
                const Gap(10),
                Expanded(
                  child: countryTextField(),
                ),
              ],
            ),
          ],
        ),
        const Gap(30),
        Row(
          children: [
            Expanded(
              child: CustomTextButtonWidget(
                text: Globalization.cancel.tr,
                baseColor: ColorHelper.myRed,
                onTap: () {
                  Get.back();
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: CustomTextButtonWidget(
                text: Globalization.next.tr,
                baseColor: ColorHelper.myDominantColor,
                onTap: () {
                  setState(() {
                    formPage = 2;
                  });
                },
              ),
            ),
          ],
        ),
        const Gap(10),
      ],
    );
  }

  Widget contactInfoWidget() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: MediaQuery.of(context).orientation == Orientation.landscape
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          Globalization.contactInfo.tr,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        Text(
          Globalization.recordOwnerApplication.tr,
          //"This is to record the owner of this application",
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        Text(
          Globalization.fullname.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: nameController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(10),
        Text(
          Globalization.contactNumber.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ZoomTapAnimation(
                end: 0.98,
                onTap: () {
                  _openCountryPickerDialog();
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      const Gap(10),
                      CountryPickerUtils.getDefaultFlagImage(
                          _selectedDialogCountry),
                      const Gap(10),
                      Text(
                        "+${_selectedDialogCountry.phoneCode}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ColorHelper.myBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: TextField(
                  controller: contactController,
                  cursorColor: ColorHelper.myDominantColor,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    filled: true,
                    fillColor: ColorHelper.myWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide.none,
                    ),
                    errorText: null,
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    color: ColorHelper.myBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        Text(
          Globalization.emailAddress.tr, //"Email Address",
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: emailController,
            cursorColor: ColorHelper.myDominantColor,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(30),
        Row(
          children: [
            Expanded(
              child: CustomTextButtonWidget(
                text: Globalization.back.tr,
                baseColor: ColorHelper.myDominantColor,
                onTap: () {
                  setState(() {
                    formPage = 1;
                  });
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: CustomTextButtonWidget(
                text: Globalization.confirm.tr,
                baseColor: ColorHelper.myLightBlue,
                onTap: () {
                  registerTrial();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget postcodeTextField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Globalization.postCode.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Row(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorHelper.myWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: RawAutocomplete<StateModel>(
                  focusNode: postcodeFocusNode,
                  textEditingController: postCodeController,
                  displayStringForOption: (StateModel option) =>
                  option.postcode,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<StateModel>.empty();
                    }
                    return allPostcodes.where((StateModel option) {
                      return option.postcode.startsWith(textEditingValue.text);
                    });
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      enabled: true,
                      obscureText: false,
                      focusNode: focusNode,
                      controller: controller,
                      cursorColor: ColorHelper.myDominantColor,
                      maxLines: 1,
                      maxLength: 100,
                      textInputAction: TextInputAction.none,
                      keyboardType: TextInputType.number, // Numeric keyboard
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Only digits allowed
                      ],
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: ColorHelper.myWhite,
                        contentPadding: EdgeInsets.only(
                            top: 2, bottom: 2, left: 10, right: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Postcode",
                        hintStyle: TextStyle(
                          color: ColorHelper.myDisable1,
                          fontStyle: FontStyle.italic,
                        ),
                        counterText: "",
                      ),
                    );
                  },
                  onSelected: (StateModel selection) {
                    cityController.text = selection.city;

                    setState(() {
                      selectedState = selection.code;
                      selectedStateOld = selection.stateName;
                      countryController.text = "Malaysia";
                    });
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final StateModel option =
                              options.elementAt(index);
                              return ListTile(
                                title:
                                Text('${option.city} (${option.postcode})'),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cityTextField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Globalization.city.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorHelper.myWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: RawAutocomplete<StateModel>(
                  focusNode: cityFocusNode,
                  textEditingController: cityController,
                  displayStringForOption: (StateModel option) => option.city,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<StateModel>.empty();
                    }
                    return allPostcodes.where((StateModel option) {
                      return option.city
                          .toLowerCase()
                          .startsWith(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      enabled: true,
                      obscureText: false,
                      focusNode: focusNode,
                      controller: controller,
                      cursorColor: ColorHelper.myDominantColor,
                      maxLines: 1,
                      maxLength: 100,
                      textInputAction: TextInputAction.none,
                      inputFormatters: [
                        // Allow letters, numbers, spaces, and underscores
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9 _]')),
                      ],
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: ColorHelper.myWhite,
                        contentPadding: EdgeInsets.only(
                            top: 2, bottom: 2, left: 10, right: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "City",
                        hintStyle: TextStyle(
                          color: ColorHelper.myDisable1,
                          fontStyle: FontStyle.italic,
                        ),
                        counterText: "",
                      ),
                    );
                  },
                  onSelected: (StateModel selection) {
                    if (postCodeController.text.isEmpty) {
                      postCodeController.text = selection.postcode;
                    }

                    setState(() {
                      selectedState = selection.code;
                      selectedStateOld = selection.stateName;
                      countryController.text = "Malaysia";
                    });
                    /*print(
                                    'Selected: ${selection.city}, Postcode: ${selection.postcode}');*/
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final StateModel option =
                              options.elementAt(index);
                              return ListTile(
                                title:
                                Text('${option.city} (${option.postcode})'),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget stateTextField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Globalization.state.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: ColorHelper.myWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  underline: const SizedBox(),
                  value: selectedStateOld,
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStateOld = newValue!;
                    });
                  },
                  items: malaysianStates.map((state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget countryTextField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Globalization.country.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: ColorHelper.myWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: countryController,
                  cursorColor: ColorHelper.myDominantColor,
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    filled: true,
                    fillColor: ColorHelper.myWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide.none,
                    ),
                    errorText: null,
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    color: ColorHelper.myBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> registerTrial() async {
    if (companyNameController.text.trim().isEmpty) {
      setState(() {
        formPage = 1;
      });

      await Get.dialog(WarningDialog(content: Globalization.emptyCompName.tr),
          barrierDismissible: false);
      return;
    }

    if (add1NameController.text.trim().isEmpty) {
      setState(() {
        formPage = 1;
      });

      await Get.dialog(WarningDialog(content: Globalization.emptyAddress.tr),
          barrierDismissible: false);
      return;
    }

    if (nameController.text.trim().isEmpty) {
      await Get.dialog(WarningDialog(content: Globalization.emptyFullName.tr),
          barrierDismissible: false);
      return;
    }

    if (contactController.text.trim().isEmpty) {
      await Get.dialog(
          WarningDialog(content: Globalization.emptyContactNumber.tr),
          barrierDismissible: false);
      return;
    }

    if (emailController.text.trim().isEmpty) {
      await Get.dialog(WarningDialog(content: Globalization.emptyEmail.tr),
          barrierDismissible: false);
      return;
    }

    CompanyRegisterModel companyModel = CompanyRegisterModel(
        appId: appId,
        companyName: companyNameController.text.trim(),
        customerName: nameController.text.trim(),
        email: emailController.text.trim(),
        contactNumber:
        "$selectedCountry${int.parse(contactController.text.trim()).toString()}",
        roc: '',
        address1: add1NameController.text.trim(),
        address2: add2NameController.text.trim(),
        address3: add3NameController.text.trim(),
        address4: add4NameController.text.trim(),
        postcode: postCodeController.text.trim(),
        city: cityController.text.trim(),
        state: selectedStateOld,
        country: countryController.text.trim());

    final conn = NetWorkHelper();

    setState(() {
      isBusy = true;
    });

    String result = await conn.registerTrial(companyModel);

    if (result.toString().toLowerCase() == "success") {
      sendWelcomeMail(emailController.text.trim());
    } else {
      await Get.dialog(WarningDialog(content: result),
          barrierDismissible: false);

      setState(() {
        isBusy = false;
      });
    }
  }

  Future<void> sendWelcomeMail(String email) async {
    await sendWelcomeMsg(email);

    await Get.dialog(
        const InformationDialog(
            title: "Welcome",
            content:
            "Your default login credential:\nUser ID : Admin\nPassword : Admin"),
        barrierDismissible: false);

    setState(() {
      isBusy = false;
    });

    Get.offAll(() => const LoginScreen());
  }

  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
      child: CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: ColorHelper.myMainBlue,
        searchInputDecoration: const InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: const Text('Select phone code'),
        onValuePicked: (Country country) {
          setState(() => _selectedDialogCountry = country);
        },
        itemBuilder: _buildDialogItem,
      ),
    ),
  );

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      const SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      const SizedBox(width: 8.0),
      Flexible(child: Text(country.name))
    ],
  );
}
