#import "DeviceID.h"
#import <Security/Security.h>

@implementation DeviceID

+ (void)getDeviceID:(void (^ _Nonnull)(NSString * _Nonnull deviceID))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *key = @"com.deviceid.deviceid";

        NSString *existingDeviceID = [self getKeychainValueForKey:key];
        if (existingDeviceID) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(existingDeviceID);
                }
            });
            return;
        }

        NSString *newDeviceID = [[NSUUID UUID] UUIDString];
        [self saveKeychainValue:newDeviceID forKey:key];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(newDeviceID);
            }
        });
    });
}

+ (void)saveKeychainValue:(NSString *)value forKey:(NSString *)key {
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: key,
        (__bridge id)kSecValueData: valueData
    };
    SecItemDelete((__bridge CFDictionaryRef)query);
    SecItemAdd((__bridge CFDictionaryRef)query, NULL);
}

+ (NSString *)getKeychainValueForKey:(NSString *)key {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: key,
        (__bridge id)kSecReturnData: @YES,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
    };

    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status == errSecSuccess && result) {
        NSData *data = (__bridge_transfer NSData *)result;
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
