import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tags/src/core/resources/resources.dart';

void main() {
  test('assets assets test', () {
    expect(File(Assets.addPro).existsSync(), isTrue);
    expect(File(Assets.addProducts).existsSync(), isTrue);
    expect(File(Assets.address).existsSync(), isTrue);
    expect(File(Assets.ads).existsSync(), isTrue);
    expect(File(Assets.boost).existsSync(), isTrue);
    expect(File(Assets.businessDetails).existsSync(), isTrue);
    expect(File(Assets.categories).existsSync(), isTrue);
    expect(File(Assets.delivery).existsSync(), isTrue);
    expect(File(Assets.documentUpload).existsSync(), isTrue);
    expect(File(Assets.drafts).existsSync(), isTrue);
    expect(File(Assets.effortSell).existsSync(), isTrue);
    expect(File(Assets.galleryAdd).existsSync(), isTrue);
    expect(File(Assets.help).existsSync(), isTrue);
    expect(File(Assets.home).existsSync(), isTrue);
    expect(File(Assets.idFace).existsSync(), isTrue);
    expect(File(Assets.imageAdd).existsSync(), isTrue);
    expect(File(Assets.language).existsSync(), isTrue);
    expect(File(Assets.location).existsSync(), isTrue);
    expect(File(Assets.logout).existsSync(), isTrue);
    expect(File(Assets.me).existsSync(), isTrue);
    expect(File(Assets.message).existsSync(), isTrue);
    expect(File(Assets.noProducts).existsSync(), isTrue);
    expect(File(Assets.order).existsSync(), isTrue);
    expect(File(Assets.password).existsSync(), isTrue);
    expect(File(Assets.payment).existsSync(), isTrue);
    expect(File(Assets.payments).existsSync(), isTrue);
    expect(File(Assets.personalcard).existsSync(), isTrue);
    expect(File(Assets.rateUs).existsSync(), isTrue);
    expect(File(Assets.search).existsSync(), isTrue);
    expect(File(Assets.sell).existsSync(), isTrue);
    expect(File(Assets.setting).existsSync(), isTrue);
    expect(File(Assets.sharePro).existsSync(), isTrue);
    expect(File(Assets.shipping).existsSync(), isTrue);
    expect(File(Assets.store).existsSync(), isTrue);
    expect(File(Assets.subscribe).existsSync(), isTrue);
    expect(File(Assets.success).existsSync(), isTrue);
    expect(File(Assets.tagLogo).existsSync(), isTrue);
    expect(File(Assets.tagzz).existsSync(), isTrue);
    expect(File(Assets.uploadId).existsSync(), isTrue);
    expect(File(Assets.verify).existsSync(), isTrue);
    expect(File(Assets.verifyId).existsSync(), isTrue);
    expect(File(Assets.wishlist).existsSync(), isTrue);
  });
}
