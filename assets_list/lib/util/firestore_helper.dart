import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/asset.dart';

class FirestoreHelper {
  final CollectionReference _assetCollection =
  FirebaseFirestore.instance.collection('assets');

  Future<List<Asset>> getAssets() async {
    final QuerySnapshot snapshot = await _assetCollection.get();
    return snapshot.docs
        .map((doc) => Asset.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
  }

  Stream<List<Asset>> streamAssets() {
    return _assetCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Asset.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
  }

  Future<void> insertAsset(Asset asset) async {
    await _assetCollection.add(asset.toMap());
  }

  Future<void> updateAsset(Asset asset) async {
    await _assetCollection.doc(asset.id).update(asset.toMap());
  }

  Future<void> deleteAsset(String id) async {
    await _assetCollection.doc(id).delete();
  }
}