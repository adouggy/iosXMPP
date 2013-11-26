//
//  SFCInteger.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-26.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCInteger : NSObject

@property (nonatomic) int value;

- (id)initWithInt:(int)value;
+ (SFCInteger*)integerWrapperWithInt:(int)value;

@end
