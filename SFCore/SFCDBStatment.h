//
//  SFCDBStatment.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SFCDBDef.h"

@interface SFCDBStatment : NSObject
{
    sqlite3_stmt* m_Statment;
}

- (id)initWithStatment:(sqlite3_stmt*)statment;
- (sqlite3_stmt*)statment;
- (BOOL)hasMoreResults;
- (int)columnCount;
- (SFCDBColumnType)columnType:(int)index;
- (NSString*)columnName:(int)index;
- (BOOL)bindIntParam:(int)param index:(int)index;
- (BOOL)bindDoubleParam:(double)param index:(int)index;
- (BOOL)bindStringParam:(NSString*)param index:(int)index;
- (BOOL)finialize;

- (NSString*)stringValueOfColumn:(NSInteger)column;
- (int)intValueOfColumn:(NSInteger)column;
- (double)doubleValueOfColumn:(NSInteger)column;

@end
