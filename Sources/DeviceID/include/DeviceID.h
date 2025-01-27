#import <Foundation/Foundation.h>

@interface DeviceID : NSObject

+ (void)getDeviceID:(void (^ _Nonnull)(NSString * _Nonnull deviceID))completion NS_SWIFT_NAME(getDeviceID(completion:));

@end
