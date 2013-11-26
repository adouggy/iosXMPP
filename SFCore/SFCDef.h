//
//  SFCDef.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#ifndef SFCore_SFCDef_h
#define SFCore_SFCDef_h

#define SFC_DB_ERROR_DOMAIN @"SfcDbErrorDomain"

#define SFC_FIX_CATEGORY_BUG_INTERFACE(name) @interface SFC_FIX_CATEGORY_BUG_##name : NSObject\
@end
#define SFC_FIX_CATEGORY_BUG_IMPLEMENTATION(name) @implementation SFC_FIX_CATEGORY_BUG_##name \
@end

#define SFC_FIX_CATEGORY_BUG_CALL(name) [SFC_FIX_CATEGORY_BUG_##name initialize];

#endif
