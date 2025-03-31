import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/Pages/home/components/home_header.dart';
import 'package:wellbeing/src/Pages/models/rank_runner.dart';
import 'package:wellbeing/src/bloc/auth/auth_bloc.dart';
import 'package:wellbeing/src/bloc/me_recode/record_me_bloc.dart';
import 'package:wellbeing/src/bloc/record/record_bloc.dart';
import 'package:wellbeing/src/bloc/record/record_event.dart';
import 'package:wellbeing/src/bloc/record/record_state.dart';
import 'package:wellbeing/src/bloc/record_runner/record_runner.state.dart';
import 'package:wellbeing/src/bloc/record_runner/record_runner_bloc.dart';
import 'package:wellbeing/src/bloc/record_runner/record_runner_event.dart';
import 'package:wellbeing/src/constants/asset.dart';
import 'package:wellbeing/src/constants/network_api.dart';
import 'package:wellbeing/src/widgets/custom_flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/me_recode/record_me_event.dart';
import '../../bloc/me_recode/record_me_state.dart';
import '../models/rank_me_runner .dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  File? _imageFile;
  final _picker = ImagePicker();
  final TextEditingController _Recode = TextEditingController();
  TextEditingController editingController = TextEditingController();
  String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool _showContent = false;
  int currentPageIndex = 1;
  final List<String> Coin = <String>[
    Asset.rank1,
    Asset.rank2,
    Asset.rank3,
    Asset.other,
    Asset.other,
  ];
  final List<String> _titleOther = <String>[
    // 'ข้อมูลส่วนตัว',
    'ประวัติ',
    'ติดต่อ'
  ];
  final List<String> _imageOther = <String>[
    Asset.profile,
    Asset.history,
    Asset.contact
  ];
  String? employeeId;
  @override
  void initState() {
    getStorage();
    context.read<RecordBloc>().add(RecordEventFetch());
    super.initState();
  }

  void getStorage() async {
    final prefs = await SharedPreferences.getInstance();
    employeeId = prefs.getString(NetworkAPI.token);
    context.read<RecordMeBloc>().add(MeRunnerEventFetch(employeeId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 127, 196, 100),
      appBar: AppBar(
        title: Text('I.P. ONE RUNNING CLUB',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (index == 0) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.home, (route) => false);
            }
          });
        },
        indicatorColor: Color.fromRGBO(248, 200, 73, 1),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'หน้าแรก',
          ),
          NavigationDestination(
            icon: Icon(Icons.save),
            // Badge(child: Icon(Icons.save)),
            label: 'บันทึก',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            // Badge(child: Icon(Icons.history)),
            label: 'เพิ่มเติม',
          ),
        ],
      ),
      body: SafeArea(
          child: currentPageIndex == 1
              ? _buildContentRunner()
              : _buildOtherContent()),
    );
  }

  Widget _buildOtherContent() {
    return Container(
        child: Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
      HomeHeader(),
      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
      Container(
        child: _buildOther(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 3),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.19, // ปรับขนาด
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.020),
      InkWell(
        onTap: () {
          context.read<AuthBloc>().add(AuthEventLogout());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width * 0.15,
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.015,
                  ),
                  height: MediaQuery.of(context).size.height * 0.060,
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Asset.logout,
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.06,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.010,
                  ),
                  height: MediaQuery.of(context).size.height * 0.040,
                  width: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ออกจากระบบ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.020)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]));
  }

  Widget _buildOther() {
    return ListView.separated(
      itemCount: _titleOther.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.pushNamed(context, AppRoute.history);
            } else if (index == 1) {
              Navigator.pushNamed(context, AppRoute.contact);
            }
          },
          child: Container(
            child: Container(
              child: Row(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.015,
                      ),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _imageOther[index] != ''
                                ? Image.asset(
                                    _imageOther[index],
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.020,
                      ),
                      height: MediaQuery.of(context).size.height * 0.050,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${_titleOther[index]}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.020)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color.fromRGBO(0, 127, 196, 100),
      ),
    );
  }

  Widget _buildTopRankRunner(List<RankRunner> rankRunner) {
    return ListView.separated(
      itemCount: rankRunner.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.015,
                  ),
                  height: MediaQuery.of(context).size.width * 0.16,
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.010,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Coin[index] != ''
                            ? Image.asset(
                                Coin[index],
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.06,
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.16,
                  width: MediaQuery.of(context).size.width * 0.06,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${rankRunner[index].employeeNameTh}',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.032)),
                      Text('รหัสพนักงาน ${rankRunner[index].employeeId}',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.032)),
                      Text('${rankRunner[index].sumRecord} Km.',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.032)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color.fromRGBO(0, 127, 196, 100),
      ),
    );
  }

  _buildLoadingView() => Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.70,
      height: MediaQuery.of(context).size.height * 0.70,
      color: Colors.white,
      child: Text("กำลังโหลด ..."));

  Widget _buildContentRunner() {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.040,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: Row(
              children: [
                Text(
                  'ยินดีต้อนรับชาว สมาชิกชมรม RUNNING CLUB',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.014),
                ),
              ],
            ),
          ),
          HomeHeader(),
          SizedBox(height: MediaQuery.of(context).size.width * 0.013),
          Container(child: BlocBuilder<RecordMeBloc, RecordMeState>(
            builder: (context, state) {
              final rankMeRunners = state.rankMeRunner;
              return RefreshIndicator(
                  onRefresh: () async => context
                      .read<RecordMeBloc>()
                      .add(MeRunnerEventFetch(employeeId)),
                  child: state.status == FetchRecordMeStatus.fetching
                      ? Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width * 0.26,
                          child: _loading())
                      : Container(
                          height: MediaQuery.of(context).size.width * 0.26,
                          child: _buildMeRunner(rankMeRunners)));
            },
          )),
          SizedBox(height: MediaQuery.of(context).size.width * 0.013),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        '5 อันดับแรก',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.040),
                      ),
                    ],
                  ),
                ),
                Container(child: BlocBuilder<RecordBloc, RecordState>(
                  builder: (context, state) {
                    final rankRunners = state.rankRunner;
                    return RefreshIndicator(
                        onRefresh: () async =>
                            context.read<RecordBloc>().add(RecordEventFetch()),
                        child: state.status == FetchStatus.fetching
                            ? Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.44,
                                child: _loading())
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.44,
                                child: _buildTopRankRunner(rankRunners)));
                  },
                )),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.white, spreadRadius: 3),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.95,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Spacer(),
                Text(
                  'วันที่ :  ${todayDate}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.028),
                ),
              ],
            ),
          ),
          _showContent
              ? SizedBox()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromRGBO(
                      0,
                      127,
                      196,
                      100,
                    ),
                    backgroundColor: Color.fromRGBO(248, 200, 73, 1),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    shape: StadiumBorder(),
                    side: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(248, 200, 73, 1),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _showContent = true;
                    });
                  },
                  child: Text(
                    "มาเริ่มวิ่งกันเลย",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: Color.fromRGBO(
          //       0,
          //       127,
          //       196,
          //       100,
          //     ),
          //     backgroundColor: Color.fromRGBO(248, 200, 73, 1),
          //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          //     shape: StadiumBorder(),
          //     side: BorderSide(
          //       width: 2,
          //       color: Color.fromRGBO(248, 200, 73, 1),
          //     ),
          //   ),
          //   onPressed: () {
          //     _loading();
          //   },
          //   child: Text(
          //     "Show",
          //     style: TextStyle(
          //         fontSize: MediaQuery.of(context).size.height * 0.014,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          _showContent ? _content() : SizedBox(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
        ],
      ),
    ));
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

  Widget _buildMeRunner(List<RankMeRunner> rankMeRunner) {
    return ListView.builder(
        itemCount: rankMeRunner.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(
                                MediaQuery.of(context).size.width *
                                    0.060), // Image radius
                            child: Image.asset(
                              Asset.RunnerImage,
                            ))),
                    Text(
                      '${rankMeRunner[index].sumRecord}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.060),
                    ),
                    Text(
                      'ระยะทางรวม (Km.)',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.030),
                    ),
                  ]),
                  VerticalDivider(
                    thickness: 2,
                    width: 20,
                    color: Colors.white,
                  ),
                  Column(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(
                                MediaQuery.of(context).size.width *
                                    0.060), // Image radius
                            child: Image.asset(
                              Asset.RunnerApp4,
                            ))),
                    Text(
                      '${rankMeRunner[index].indexNo}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.060),
                    ),
                    Text(
                      'คุณอยู่ในลำดับที่',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.030),
                    ),
                  ]),
                ],
              ),
            ),
          );
        });
  }

  void _showAlert(String dialogMessage, BuildContext context, String status) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            dialogMessage,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.019),
          ),
          icon: status == 'success'
              ? const Icon(
                  Icons.check_circle,
                  size: 28.0,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.error,
                  size: 28.0,
                  color: Colors.red,
                ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (status == 'success') {
                  setState(() {
                    getStorage();
                    context.read<RecordBloc>().add(RecordEventFetch());
                    _showContent = false;
                    _imageFile = null;
                    _Recode.text = '';
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("ปิด"),
            ),
          ],
        );
      },
    );
  }

  Widget _content() {
    return BlocListener<RecordRunnerBloc, RecordRunnerState>(
        listener: (context, state) {
          if (state.status case SubmitStatus.success) {
            _showAlert(state.dialogMessage, context, 'success');
          } else if (state.status case SubmitStatus.failed) {
            _showAlert(state.dialogMessage, context, 'not success');
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.60,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    Text(
                      'เริ่มบันทึกกันเลย',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.037),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                  ],
                  maxLength: 10,
                  controller: _Recode,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.030),
                  readOnly: false,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: "ระยะทาง (Km.)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              _imageFile == null ? _buildOutletImage() : _buildPreviewImage(),
              Center(
                  child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(0, 127, 196, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: StadiumBorder(),
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      if (_Recode.text == '') {
                        return CustomFlushbar.showWarning(context,
                            message: "ระบุระยะทาง (Km)");
                      } else if (_imageFile == null) {
                        return CustomFlushbar.showWarning(context,
                            message: "กรุณาถ่ายรูป");
                      }
                      context
                          .read<RecordRunnerBloc>()
                          .add(RecordRunnerEventSubmit(
                            employeeId: employeeId,
                            record: _Recode.text,
                            image: _imageFile,
                          ));
                    },
                    child: Text(
                      'บันทึก',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.033),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: StadiumBorder(),
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _showContent = false;
                        _imageFile = null;
                        _Recode.text = '';
                      });
                    },
                    child: Text(
                      'ไม่วิ่งแล้วดีกว่า!',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 127, 196, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.033),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ));
  }

  Widget _buildPreviewImage() {
    if (_imageFile == null) {
      return SizedBox();
    }

    final container = (Widget child) => Container(
          color: Colors.grey[100],
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
          alignment: Alignment.center,
          height: 400,
          child: child,
        );
    if (_imageFile != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Center(
              child: SizedBox(
                height: 320,
                width: 320,
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          _buildDeleteImageButton(),
        ],
      );
    }

    return container(SizedBox());
  }

  Positioned _buildDeleteImageButton() => Positioned(
        right: -10,
        top: 10,
        child: RawMaterialButton(
          onPressed: () => _deleteImage(),
          fillColor: Colors.white,
          child: Icon(
            Icons.clear,
          ),
          shape: CircleBorder(
            side: BorderSide(
                width: 1, color: Colors.grey, style: BorderStyle.solid),
          ),
        ),
      );
  void _deleteImage() {
    setState(() {
      _imageFile = null;
    });
  }

  IconButton _buildPickerImage() => IconButton(
        icon: Icon(Icons.image),
        onPressed: _modalPickerImage,
      );
  void _modalPickerImage() {
    final buildListTile = (
      IconData icon,
      String title,
      ImageSource source,
    ) =>
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.of(context).pop();
            _pickImage(source);
          },
        );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildListTile(
                Icons.photo_camera,
                'เปิดกล้องถ่ายรูป',
                ImageSource.camera,
              ),
              buildListTile(
                Icons.photo_library,
                'เลือกรูปจากอัลบั้ม',
                ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) async {
    _picker
        .pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: 1920,
      maxWidth: 1080,
    )
        .then((file) {
      if (file != null) {
        _cropImage(file.path);
      }
    }).catchError((error) {
      //todo
    });
  }

  void _cropImage(String filePath) async {
    ImageCropper()
        .cropImage(
      sourcePath: filePath,
      compressQuality: 100,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'ยืนยันรูปถ่าย',
            toolbarColor: Color.fromRGBO(0, 127, 196, 100),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'ยืนยันรูปถ่าย',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
      maxWidth: 1920,
      maxHeight: 1080,
      //circleShape: true
    )
        .then((file) {
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
        });
      }
    });
  }

  Widget TxtSpan(txtValue, fontSize, Color) {
    return Center(
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: txtValue,
              style: TextStyle(
                  color: Color,
                  fontSize: MediaQuery.of(context).size.height * fontSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutletImage() {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: _imageFile == null
                        ? Image.asset("assets/images/noimage.jpg")
                        : SizedBox()),
              ),
              InkWell(
                onTap: _modalPickerImage,
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Color.fromRGBO(12, 12, 11, 1)),
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.32,
                      top: MediaQuery.of(context).size.height * 0.25,
                    ),
                    child: Icon(
                      Icons.photo_camera,
                      size: 25,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
