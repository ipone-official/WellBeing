import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wellbeing/src/Pages/models/contact.dart';
import 'package:wellbeing/src/bloc/contact/contact_bloc.dart';
import 'package:wellbeing/src/bloc/contact/contact_event.dart';
import 'package:wellbeing/src/bloc/contact/contact_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var items = <Contact>[];

  @override
  void initState() {
    context.read<ContactBloc>().add(ContactEventFetch('Runner'));
    super.initState();
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
        child: _ContentContact(),
      ),
    );
  }

  Widget _ContentContact() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                children: [
                  Text(
                    'ติดต่อ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.019),
                  ),
                ],
              ),
            ),
            Container(child: BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                items = state.contact;
                return RefreshIndicator(
                    onRefresh: () async => context
                        .read<ContactBloc>()
                        .add(ContactEventFetch('Runner')),
                    child: state.status == FetchStatusContact.fetching
                        ? Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.width * 1.6,
                            child: _loading())
                        : Container(
                            height: MediaQuery.of(context).size.width * 1.6,
                            child: Container(child: _buildContentHeader(items),
                            
                          ),
                          ));
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("สามารถติดต่อวัน จันทร์ - ศุกร์ เวลาทำการ 08:00 - 17:00 น.",
              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width *
                                    0.034))],)
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
        height: MediaQuery.of(context).size.height * 0.95,
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
        size: 50,
      ),
    );
  }

  Widget _buildContentHeader(List<Contact> contact) {
    return ListView.separated(
      itemCount: contact.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            child: Row(
          children: [
            // Center(
            //   child: Image.network(
            //     'https://webapps.ip-one.com/news/profile.png',
            //     errorBuilder: (context, error, stackTrace) {
            //       return Container(
            //           alignment: Alignment.center,
            //           width: MediaQuery.of(context).size.width * 0.12,
            //           height: MediaQuery.of(context).size.height * 0.1,
            //           child: Text("ไม่พบรูปภาพ"));
            //     },
            //     width: MediaQuery.of(context).size.width * 0.12,
            //     height: MediaQuery.of(context).size.height * 0.1,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.06,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.person,
                            color: Color.fromRGBO(0, 127, 196, 100),
                          ),
                          onPressed: () {
                            //
                          },
                        ),
                        Text('${contact[index].name}',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: MediaQuery.of(context).size.width *
                                    0.045)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.mail,
                            color: Color.fromRGBO(0, 127, 196, 100),
                          ),
                          onPressed: () {
                            openDialEmail(contact[index].email);
                          },
                        ),
                        Text('${contact[index].email}',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: MediaQuery.of(context).size.width *
                                    0.040)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.phone,
                            color: Color.fromRGBO(0, 127, 196, 100),
                          ),
                          onPressed: () {
                            openDialPad(contact[index].telephone);
                          },
                        ),
                        Text(
                            '${contact[index].telephone} ต่อ ${contact[index].extension}',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: MediaQuery.of(context).size.width *
                                    0.040)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color.fromRGBO(0, 127, 196, 100),
      ),
    );
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

  openDialEmail(String txtMail) async {
    final Email email = Email(
      body: 'เนื้อหา',
      subject: 'หัวข้อ',
      recipients: [txtMail],
      // cc: ['cc@example.com'],
      bcc: ['it@ip-one.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
