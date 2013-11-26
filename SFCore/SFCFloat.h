//
//  SFCFloat.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-26.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCFloat : NSObject

@property (nonatomic) double value;

- (id)initWithDouble:(double)value;
+ (SFCFloat*)floatWrapperWithDouble:(double)value;

@end
