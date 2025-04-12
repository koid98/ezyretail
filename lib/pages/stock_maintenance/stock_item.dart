import 'dart:async';

import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/models/item_barcode_model.dart';
import 'package:ezyretail/models/item_master_model.dart';
import 'package:flutter/material.dart';

class StockItem extends StatefulWidget {
  const StockItem({super.key});

  @override
  State<StockItem> createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
  List<ItemMasterModel> itemList = [];
  List<ItemUom> itemUomList = [];
  List<ItemBarcodeModel> itemBarcodeList = [];

  final scrollController = ScrollController();
  int page = 0;
  int itemLimit = 500;
  bool hasMore = true;
  bool isLoading = false;

  ItemMasterModel? tmpItem;

  final TextEditingController _filter = TextEditingController();
  var itemCodeController = TextEditingController();
  var itemDescController = TextEditingController();
  var itemDesc2Controller = TextEditingController();
  var baseUomController = TextEditingController();
  var unitPriceController = TextEditingController();

  var itemTypeController = TextEditingController();
  var classificationController = TextEditingController();
  var taxCodeController = TextEditingController();
  var tariffController = TextEditingController();

  Timer? _debounce;
  Timer? _displayTimer;

  bool isBusy = false;
  String busyMessage = "";

  // change debouce duration accordingly
  final Duration _debouceDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    getData("");

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getData(_filter.text);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _displayTimer?.cancel();
    scrollController.dispose();
    imageCache.clear();
    super.dispose();
  }

  Future<void> getData(String query) async {
    if (isLoading) return;
    isLoading = true;

    imageCache.clear();
    List tempList = await DatabaseHelper.instance
        .getItemsListingSingle(query, page, itemLimit);

    if (tempList.isNotEmpty) {
      setState(() {
        page++;
        if (tempList.length < itemLimit) {
          hasMore = false;
        }
        itemList.addAll(
            tempList.map((json) => ItemMasterModel.fromDB(json)).toList());
      });
    }

    isLoading = false;

    if (page == 0) {
      if (tempList.isEmpty) {
        setState(() {
          hasMore = false;
          itemList = [];
        });
      }
    } else {
      setState(() {
        hasMore = false;
      });
    }

    imageCache.clear();
  }

  _onSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debouceDuration, () async {
      page = 0;
      itemList.clear();
      await getData(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
