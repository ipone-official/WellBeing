import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wellbeing/src/Pages/models/history_runner.dart';
import 'package:wellbeing/src/bloc/history/history_bloc.dart';
import 'package:wellbeing/src/bloc/history/history_event.dart';
import 'package:wellbeing/src/bloc/history/history_state.dart';
import 'package:wellbeing/src/constants/asset.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/network_api.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController _editingController = TextEditingController();
  var items = <HistoryRunner>[];
  var _filterSearchResults = <HistoryRunner>[];
  String msgShow = "กำลังโหลด ...";
  String? employeeId;
  
  @override
  void initState() {
    getStorage();
    super.initState();
  }
  void getStorage() async {
    final prefs = await SharedPreferences.getInstance();
     employeeId = prefs.getString(NetworkAPI.token);
     context.read<HistoryBloc>().add(HistoryEventFetch(employeeId));
  }

  void filterSearchResults(String query) {
    if (query == "") {
      setState(() {
        _filterSearchResults = items;
      });
    } else {
      setState(() {
        _filterSearchResults = items
            .where((item) => item.recordDate.contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 127, 196, 100),
      appBar: AppBar(
        title: Text('Runner',
            //  style: TextStyle(color: Color.fromRGBO(0, 127, 196, 100),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => {Navigator.of(context).pop()}),
      ),
      body: SafeArea(
        child: _ContentHistory(),
      ),
    );
  }

  Widget _ContentHistory() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 3),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    Text(
                      'ประวัติ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.019),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ค้นหา',
                    focusColor: Colors.green,
                    suffixIcon: _editingController.text != ""
                        ? IconButton(
                            // Icon to
                            icon: Icon(Icons.clear), // clear text
                            onPressed: () => {
                                  setState(() {
                                    _editingController.text = "";
                                    filterSearchResults(
                                        _editingController.text);
                                  })
                                })
                        : SizedBox(),
                  ),
                  controller: _editingController,
                  onTap: () {
                    _pickDateDialog();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("วันที่บันทึก"), Text("ระยะทาง (Km.)")],
                ),
              ),
              Container(child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  items = state.history;
                  return RefreshIndicator(
                      onRefresh: () async => context
                          .read<HistoryBloc>()
                          .add(HistoryEventFetch(employeeId)),
                      child: state.status == FetchStatusHistory.fetching
                          ? 
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: _loading(),) 
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: _buildContentHistory(
                                  _filterSearchResults.length == 0
                                      ? items
                                      : _filterSearchResults)));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
  Widget _loading() {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: Color.fromRGBO(
          0,
          127,
          196,
          1,
        ),
        rightDotColor: Color.fromRGBO(248, 200, 73, 1),
        size: 100,
      ),
    );
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      String todayDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        _editingController.text = todayDate;
        filterSearchResults(todayDate);
      });
    });
  }

  Widget _buildHistoryRunner() {
    return Container(
      margin: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.043,
              decoration: BoxDecoration(
                color: Color.fromRGBO(248, 200, 73, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ประวัติ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.022),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: (value) {
          //       filterSearchResults(value);
          //     },
          //     controller: editingController,
          //     decoration: InputDecoration(
          //         labelText: "ค้นหา",
          //         hintText: "ค้นหา",
          //         prefixIcon: Icon(Icons.search),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("วันที่บันทึก"), Text("ระยะทาง (Km.)")],
            ),
          ),
          Container(child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              items = state.history;
              return RefreshIndicator(
                  onRefresh: () async => context
                      .read<HistoryBloc>()
                      .add(HistoryEventFetch('003796')),
                  child: state.status == FetchStatusHistory.fetching
                      ? _buildLoadingView()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: _buildContentHistory(
                              _filterSearchResults.length == 0
                                  ? items
                                  : _filterSearchResults)));
            },
          )),
        ]),
      ),
    );
  }

  _buildLoadingView() => Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.70,
      height: MediaQuery.of(context).size.height * 0.70,
      color: Colors.white,
      child: Text("${msgShow}"));

  Widget _buildContentHistory(List<HistoryRunner> historyRunner) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: historyRunner.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.015,
                  ),
                  height: MediaQuery.of(context).size.height * 0.035,
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Asset.RunnerImage4,
                          height: MediaQuery.of(context).size.height * 0.035,
                          width: MediaQuery.of(context).size.width * 0.035,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.035,
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${historyRunner[index].recordDate}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018)),
                      Text('${historyRunner[index].record}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
