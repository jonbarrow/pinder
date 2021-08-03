import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

final InAppPurchase _inAppPurchase = InAppPurchase.instance;
late StreamSubscription<List<PurchaseDetails>> _subscription;
List<ProductDetails> _products = [];

const _productIds = { 'no_ads' };

bool disableAds = false;

void init() {
  final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;

  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    _listenToPurchaseUpdated(purchaseDetailsList);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    // handle error here.
  });

  initStoreInfo();
}

void cancel() {
  _subscription.cancel();
}

void purchase(productDetails) {
  final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
  _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
}

Future restore() async {
  await _inAppPurchase.restorePurchases();
}

List<ProductDetails> getProducts() {
  return _products;
}

_listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    switch (purchaseDetails.status) {
      case PurchaseStatus.error:
        // Do something
        break;
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored:
        disableAds = true;
        break;
      default:
        // Do something
    }
  });
}

Future<void> initStoreInfo() async {
  final bool isAvailable = await _inAppPurchase.isAvailable();
  if (!isAvailable) {
    print('fail 1');
    return;
  }

  ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_productIds.toSet());
  if (productDetailResponse.error != null) {
    print('fail 2');
    return;
  }

  if (productDetailResponse.productDetails.isEmpty) {
    print('fail 3');
    return;
  }

  _products = productDetailResponse.productDetails;
}