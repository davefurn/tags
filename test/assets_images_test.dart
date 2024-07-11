import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tags/src/core/resources/resources.dart';

void main() {
  test('assets_images assets test', () {
    expect(File(AssetsImages.apple).existsSync(), isTrue);
    expect(File(AssetsImages.jbl).existsSync(), isTrue);
    expect(File(AssetsImages.nokia).existsSync(), isTrue);
    expect(File(AssetsImages.oraimo).existsSync(), isTrue);
    expect(File(AssetsImages.samsung).existsSync(), isTrue);
    expect(File(AssetsImages.sony).existsSync(), isTrue);
    expect(File(AssetsImages.tecno).existsSync(), isTrue);
    expect(File(AssetsImages.xiaomi).existsSync(), isTrue);
    expect(File(AssetsImages.airConditionerDeal).existsSync(), isTrue);
    expect(File(AssetsImages.airpods).existsSync(), isTrue);
    expect(File(AssetsImages.background).existsSync(), isTrue);
    expect(File(AssetsImages.blackFridaySales).existsSync(), isTrue);
    expect(File(AssetsImages.buyerImage).existsSync(), isTrue);
    expect(File(AssetsImages.cameraPhoto).existsSync(), isTrue);
    expect(File(AssetsImages.carParts).existsSync(), isTrue);
    expect(File(AssetsImages.carsCategory).existsSync(), isTrue);
    expect(File(AssetsImages.carsDeal).existsSync(), isTrue);
    expect(File(AssetsImages.creamDeal).existsSync(), isTrue);
    expect(File(AssetsImages.desktop).existsSync(), isTrue);
    expect(File(AssetsImages.diamondRing).existsSync(), isTrue);
    expect(File(AssetsImages.electronicsCategory).existsSync(), isTrue);
    expect(File(AssetsImages.emptySearchHistory).existsSync(), isTrue);
    expect(File(AssetsImages.filterIcon).existsSync(), isTrue);
    expect(File(AssetsImages.firstPage).existsSync(), isTrue);
    expect(File(AssetsImages.headset).existsSync(), isTrue);
    expect(File(AssetsImages.laptops).existsSync(), isTrue);
    expect(File(AssetsImages.listviewIcon).existsSync(), isTrue);
    expect(File(AssetsImages.mouse).existsSync(), isTrue);
    expect(File(AssetsImages.noMessage).existsSync(), isTrue);
    expect(File(AssetsImages.noResults).existsSync(), isTrue);
    expect(File(AssetsImages.phoneCategory).existsSync(), isTrue);
    expect(File(AssetsImages.phonesDeal).existsSync(), isTrue);
    expect(File(AssetsImages.searchEmpty).existsSync(), isTrue);
    expect(File(AssetsImages.second).existsSync(), isTrue);
    expect(File(AssetsImages.sellerIcon).existsSync(), isTrue);
    expect(File(AssetsImages.sellerPage).existsSync(), isTrue);
    expect(File(AssetsImages.smartTvDeal).existsSync(), isTrue);
    expect(File(AssetsImages.successCreate).existsSync(), isTrue);
    expect(File(AssetsImages.tagLogo).existsSync(), isTrue);
    expect(File(AssetsImages.toolsEquipment).existsSync(), isTrue);
    expect(File(AssetsImages.tvEntertain).existsSync(), isTrue);
  });
}
