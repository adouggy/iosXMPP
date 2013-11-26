#import <Foundation/Foundation.h>
#import <libxml/tree.h>
#import "SFCDef.h"

SFC_FIX_CATEGORY_BUG_INTERFACE(NSString_DDXML)

@interface NSString (DDXML)

/**
 * xmlChar - A basic replacement for char, a byte in a UTF-8 encoded string.
**/
- (const xmlChar *)xmlChar;

- (NSString *)stringByTrimming;

@end
