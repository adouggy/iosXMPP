#import <Foundation/Foundation.h>
#import "SFCDef.h"

SFC_FIX_CATEGORY_BUG_INTERFACE(NSData_XMPP)

@interface NSData (XMPP)

- (NSData *)md5Digest;

- (NSData *)sha1Digest;

- (NSString *)hexStringValue;

- (NSString *)base64Encoded;
- (NSData *)base64Decoded;

@end
