import 'package:cloud_firestore/cloud_firestore.dart';

initFireStore() async {
  final Firestore firestore = Firestore();
  await firestore.settings(timestampsInSnapshotsEnabled: true);

}


