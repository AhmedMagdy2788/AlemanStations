// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:aleman_stations/models/switch_theme_mode_widget.dart';
import 'package:aleman_stations/theme/app_themes.dart';
import 'package:aleman_stations/utilities/storage_API/storage_handler.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

import '../providers/customers_provider.dart';
import '../models/customer.dart';

class CustomersScreen extends StatefulWidget {
  @override
  CustomersScreenState createState() => CustomersScreenState();

  const CustomersScreen({Key? key}) : super(key: key);
}

class CustomersScreenState extends State<CustomersScreen> {
  static const String ID = 'No.';
  static const String CUSTOMER_NAME = 'Cust. Name';
  static const String INIT_DEPT = 'init. Dept';
  late StorageHandler storageHandler;
  late CustomersProvider cstProvider;
  bool didCustomersInit = false;
  List<String> tblHeaders = [ID.tr(), CUSTOMER_NAME.tr(), INIT_DEPT.tr()];
  List<Customer> customers = [];
  List<bool> rowsSelectionState = [];
  int? selectedColumn;
  bool isAscending = true;
  bool isCellsSelectable = false;
  bool isCellsEditable = false;

  @override
  void initState() {
    storageHandler = Provider.of<StorageHandler>(context, listen: false);
    // log("storage handler init. state: ${storageHandler.isInit}");
    cstProvider = Provider.of<CustomersProvider>(context, listen: false);
    // Future.delayed(Duration.zero).then((value) async {
    //   storageHandler = Provider.of<StorageHandler>(context, listen: false);

    //   customers = await Provider.of<CustomersProvider>(context, listen: false)
    //       .initCustomer(storageHandler);
    //   setState(() {
    //     didCustomersInit = true;
    //   });
    // });
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {});
  // }

  List<DataColumn> custTableColumn() {
    return List<DataColumn>.generate(
      tblHeaders.length,
      (index) => DataColumn(
        label: Text(
          tblHeaders[index],
          style: Theme.of(context).textTheme.headline6,
        ),
        onSort: sortColumn,
      ),
    );
  }

  List<DataRow> custTableRows() {
    return List<DataRow>.generate(
      customers.length,
      (index) {
        rowsSelectionState.add(false);
        // String username = customers[index].name;
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // All rows will have the same selected color.
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
            }
            // Even rows will have a grey color.
            if (index.isEven) {
              return Colors.grey.withOpacity(0.3);
            }
            return null; // Use default value for other states and odd rows.
          }),
          cells: [
            DataCell(Text('${index + 1}')),
            DataCell(
              // CustomersSearchableField(
              //     customers: customers, username: username),
              // CustomersDropdownButton(customers: customers, username: username),
              Text(customers[index].name),
              showEditIcon: isCellsEditable,
              onTap: () {},
            ),
            DataCell(
              Text(customers[index].initDept.toString() + ' ج.م'),
              showEditIcon: isCellsEditable,
              onTap: () {},
            ),
          ],
          selected: rowsSelectionState[index],
          onSelectChanged: (isSelected) {
            setState(() {
              rowsSelectionState[index] = isSelected!;
            });
          },
        );
      },
    );
    // List<DataRow> rows = [];
    // for (Customer customer in customers) {
    //   rows.add(DataRow(
    //     cells: [
    //       DataCell(Text(customer.name)),
    //       DataCell(Text(customer.initDept.toString() + ' ج.م')),
    //     ],
    //   ));
    // }
    // return rows;
  }

  void mySortColumn(int columnIndex, bool ascending) {
    for (var i = 0; i < customers.length - 1; i++) {
      for (var j = 1; j < customers.length - i; j++) {
        int compResult;
        switch (columnIndex) {
          case 1:
            compResult = ascending
                ? customers[j - 1].name.compareTo(customers[j].name)
                : customers[j].name.compareTo(customers[j - 1].name);
            break;
          case 2:
            compResult = ascending
                ? customers[j - 1].initDept.compareTo(customers[j].initDept)
                : customers[j].initDept.compareTo(customers[j - 1].initDept);
            break;
          default:
            compResult = ascending
                ? customers[j - 1].id.compareTo(customers[j].id)
                : customers[j].id.compareTo(customers[j - 1].id);
        }
        if (compResult > 0) {
          Customer tem = customers[j - 1];
          customers[j - 1] = customers[j];
          customers[j] = tem;
        }
      }
    }
  }

  void sortColumn(int columnIndex, bool ascending) {
    setState(() {
      selectedColumn = columnIndex;
      isAscending = ascending;
      // mySortColumn(columnIndex, ascending);
      customers.sort((cust1, cust2) {
        int compResult;
        switch (columnIndex) {
          case 1:
            compResult = ascending
                ? cust1.name.compareTo(cust2.name)
                : cust2.name.compareTo(cust1.name);
            break;
          case 2:
            compResult = ascending
                ? cust1.initDept.compareTo(cust2.initDept)
                : cust2.initDept.compareTo(cust1.initDept);
            break;
          default:
            compResult = ascending
                ? cust1.id.compareTo(cust2.id)
                : cust2.id.compareTo(cust1.id);
        }
        return compResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final text =
        Provider.of<ThemeProvider>(context).isDarkMode ? 'Dark' : 'Light';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("custScreenTitle".tr()),
        actions: [
          Center(child: Text(text)),
          const SwitchThemeModeWidget(),
          IconButton(
              onPressed: () {
                setState(() {
                  isCellsEditable = !isCellsEditable;
                });
              },
              icon: const Icon(
                Icons.edit,
                size: 25,
              )),
          const SizedBox(
            width: 18,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  isCellsSelectable = !isCellsSelectable;
                });
              },
              icon: const Icon(
                Icons.select_all,
                size: 25,
              )),
          const SizedBox(
            width: 18,
          ),
          OutlinedButton(
            onPressed: () {
              translator.setNewLanguage(
                context,
                newLanguage:
                    translator.activeLanguageCode == 'ar' ? 'en' : 'ar',
                remember: true,
                restart: true,
              );
            },
            child: Text(
              'buttonTitle'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: cstProvider.initCustomer(storageHandler),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            customers = snapshot.data as List<Customer>;
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: custTableColumn(),
                    // [
                    //   DataColumn(
                    //     label: Text(
                    //       'No.'.tr(),
                    //       style: Theme.of(context).textTheme.headline1,
                    //     ),
                    //     // onSort: sortColumn,
                    //   ),
                    //   DataColumn(
                    //     label: Text('tblCustName'.tr(),
                    //         style: Theme.of(context).textTheme.headline1),
                    //     onSort: sortColumn,
                    //   ),
                    //   DataColumn(
                    //     label: Text(
                    //       'tblCustIntiDept'.tr(),
                    //       style: Theme.of(context).textTheme.headline1,
                    //     ),
                    //     onSort: sortColumn,
                    //     numeric: true,
                    //   ),
                    // ],
                    rows: custTableRows(),
                    sortColumnIndex: selectedColumn,
                    sortAscending: isAscending,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomersSearchableField extends StatefulWidget {
  const CustomersSearchableField({
    Key? key,
    required this.customers,
    required this.username,
  }) : super(key: key);

  final List<Customer> customers;
  final String username;

  @override
  State<CustomersSearchableField> createState() =>
      _CustomersSearchableFieldState();
}

class _CustomersSearchableFieldState extends State<CustomersSearchableField> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return SearchField<String>(
      hint: 'Cust. name'.tr(),
      // searchInputDecoration: InputDecoration(
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: Colors.blueGrey.shade200,
      //       width: 1,
      //     ),
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: Colors.blue.withOpacity(0.8),
      //       width: 2,
      //     ),
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      // ),
      itemHeight: 50,
      maxSuggestionsInViewPort: 5,
      suggestionsDecoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: (selectedValue) {
        setState(() {
          _selectedValue = selectedValue.item;
        });
      },
      suggestions: List<SearchFieldListItem<String>>.generate(
        widget.customers.length,
        (innerIndex) => SearchFieldListItem<String>(
            widget.customers[innerIndex].name,
            item: widget.customers[innerIndex].name),
      ),
    );
  }
}

class CustomersDropdownButton extends StatefulWidget {
  CustomersDropdownButton({
    Key? key,
    required this.customers,
    required this.username,
  }) : super(key: key);

  final List<Customer> customers;
  String username;

  @override
  State<CustomersDropdownButton> createState() =>
      _CustomersDropdownButtonState();
}

class _CustomersDropdownButtonState extends State<CustomersDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: List<DropdownMenuItem<String>>.generate(
        widget.customers.length,
        (innerIndex) => DropdownMenuItem<String>(
          child: Text(widget.customers[innerIndex].name),
          value: widget.customers[innerIndex].name,
        ),
      ),
      value: widget.username,
      onChanged: (String? value) {
        setState(() {
          widget.username = value!;
        });
      },
    );
  }
}
