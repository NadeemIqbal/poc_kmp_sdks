#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(KmpSharedSdkRn, NSObject)

RCT_EXTERN_METHOD(initialize:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getUsers:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getUserById:(NSString *)userId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(searchUsers:(NSString *)query
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getProducts:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getProductById:(NSString *)productId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(searchProducts:(NSString *)query
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getProductsByPriceRange:(double)minPrice
                 maxPrice:(double)maxPrice
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(navigateToUserDetails:(NSString *)userId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(navigateToProductDetails:(NSString *)productId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(navigateBack:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(showMessage:(NSString *)message
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getPlatformInfo:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end