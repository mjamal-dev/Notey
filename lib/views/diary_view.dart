import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:local_auth/local_auth.dart';
import 'package:notey/components/note_card.dart';
import 'package:notey/models/note_model.dart';
import 'package:notey/repository/data_repository.dart';
import 'package:notey/views/detail_view.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({Key? key}) : super(key: key);

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _authorizedOrNot = false;

  Future<void> checkAuth() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
          localizedReason: 'Please authenticate to access secured diary',
          options: const AuthenticationOptions(biometricOnly: true));
    } catch (e) {
      print("Some error has occurred in authenticating fp $e");
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? true : false;
    });
  }

  @override
  void initState() {
// Initialize LocalAuthentication and checking whether device is supported or not
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => checkAuth());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: _authorizedOrNot
          ? FloatingActionButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => CardDetailPage(
                            note: NoteModel(),
                            secured: true,
                          )),
                    ));
              }),
              child: const Icon(
                Icons.add,
                color: AppColors.scaffoldBackground,
              ),
            )
          : FloatingActionButton(
              onPressed: (() {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Please authenicate first'),
                  action: SnackBarAction(
                    label: 'Re-auth',
                    onPressed: (() => checkAuth()),
                  ),
                ));
              }),
              child: const Icon(Icons.lock),
            ),
      body: _authorizedOrNot
          ? StreamBuilder<List<NoteModel>>(
              stream: DataRepository.readNotes(secure: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Some error has occurred ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<NoteModel>? notes = snapshot.data;

                  return ListView.builder(
                      itemCount: notes!.length,
                      itemBuilder: ((context, index) {
                        return FadeInLeft(
                          duration: Duration(milliseconds: index * 350),
                          child: NoteCard(
                            note: notes[index],
                            secured: true,
                          ),
                        );
                      }));
                }
              })
          : Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: size.width * 0.1),
                child: Column(
                  children: [
                    const Text(
                      'Access denied! Please re-auth again',
                      style: TextStyle(fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.orange),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextButton(
                          onPressed: (() {
                            checkAuth();
                          }),
                          child: Text(
                            'Re-auth',
                            style: TextStyle(color: AppColors.orange),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
