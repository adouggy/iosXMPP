//
//  SFCDBSqlite.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class SFCDBStatment;

@interface SFCDBSqlite : NSObject
{
    sqlite3* m_Db;
    NSString* m_Path;
}

- (id)initWithPath:(NSString*)path;

- (sqlite3*)db;

- (BOOL)open:(NSError**)error;
- (BOOL)close;
- (BOOL)execute:(NSString*)sql error:(NSError**)error;
- (SFCDBStatment*)prepare:(NSString*)sql error:(NSError**)error;
- (BOOL)beginTransaction;
- (BOOL)commit;
- (BOOL)rollback;

- (NSArray*)findAll:(Class)entityClass;
- (NSArray*)findAll:(Class)entityClass byConditionSql:(NSString*)conditionSql;
- (NSArray*)findAll:(Class)entityClass byDict:(NSDictionary*)condition;

- (id)find:(Class)entityClass byConditionSql:(NSString*)conditionSql;
- (id)find:(Class)entityClass byDict:(NSDictionary*)condition;
- (id)find:(Class)entityClass byId:(NSString*)id;

- (BOOL)save:(id)object;
- (BOOL)update:(id)object;
- (BOOL)saveOrUpdate:(id)object;
- (BOOL)delete:(id)object;
- (BOOL)delete:(Class)entityClass byId:(NSString*)id;

- (BOOL)executeSqls:(NSArray*)sqls;

@end
