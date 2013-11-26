//
//  SFCoreDatabaseTests.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCoreDatabaseTests.h"
#import "SFCore.h"

#if DEBUG
const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
const int ddLogLevel = LOG_LEVEL_INFO;
#endif

@interface SFCoreDatabaseTestObject1 : NSObject

@property (strong,nonatomic) NSArray* test1;
@property (strong,nonatomic) NSString* _id;
@property (strong,nonatomic) NSArray* test2;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSArray* test3;
@property (nonatomic) NSInteger age;
@property (strong,nonatomic) NSArray* test4;
@property (nonatomic) double salary;
@property (strong,nonatomic) NSArray* test5;

@end

@implementation SFCoreDatabaseTestObject1

@end

@interface SFCoreDatabaseTestObject2 : NSObject

@property (strong,nonatomic) NSString* _id;
@property (strong,nonatomic) NSString* name;

@end

@implementation SFCoreDatabaseTestObject2

@end

@interface CSVDelegate : NSObject<CHCSVParserDelegate>

@end

@implementation CSVDelegate

- (void)parserDidBeginDocument:(CHCSVParser *)parser;
{
    NSLog(@"Parse Begin");
}
- (void)parserDidEndDocument:(CHCSVParser *)parser
{
    NSLog(@"Parse End");
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    NSLog(@"Begin Line:%d",recordNumber);
}
- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber
{
    NSLog(@"End Line:%d",recordNumber);
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    NSLog(@"Read Field:%@ index:%d",field,fieldIndex);
}
- (void)parser:(CHCSVParser *)parser didReadComment:(NSString *)comment
{
    NSLog(@"Read Comment:%@",comment);
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Error");
}

@end

@implementation SFCoreDatabaseTests

+ (void)initialize
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [SFCore initialize];
}

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCSV
{
    NSString* csvString = @"line11,line12\nline21,line22\n";
    CHCSVParser* parser = [[CHCSVParser alloc]initWithCSVString:csvString];
    CSVDelegate* delegate = [[CSVDelegate alloc]init];
    parser.delegate = delegate;
    [parser parse];
}

- (void)testEscapeString
{
    NSString* str = @"\\t季\\\\\\成\\r\\n\\n";
    NSString* escapedStr = [str escapeString];
    NSLog(@"%@",escapedStr);
}

- (void)testBase64
{
    NSString* base64String = @"\n\nZnVuY3Rpb24gcG9zdChpZCxvcHRpb24pCnsKICAgIHZhciBjb21tZW50cyA9IHJlcXVpcmUoJ2Jhc2UnKS4kKCJEZXNjcmlwdGlvbiIpLnZhbHVlOwogICAgdmFyIGRhdGEgPSAneyJwdXNoSWQiIDogIicgKyBpZCArICciICwgImlzQWdyZWUiIDoiJyArIG9wdGlvbiArICciLCAibm90ZSIgOiInICsgY29tbWVudHMgKyAnIn0nOwogICAgdmFyIHN1Y2Nlc3NTcWwgPSAidXBkYXRlIG1fYXIgc2V0IHN0YXR1cz0yIHdoZXJlIF9pZD0nIiArIGlkICsgIiciOwogICAgdmFyIGZhaWx1cmVTcWwgPSAidXBkYXRlIG1fYXIgc2V0IHN0YXR1cz0zIHdoZXJlIF9pZD0nIiArIGlkICsgIiciOwogICAgcmVxdWlyZSgnb3BlcmF0aW9uJykucG9zdERhdGEoaWQsImh0dHA6Ly8xOTIuMTY4LjAuMjAwOjcwODAvbW9hL3Jlc291cmNlcy9kZXZpY2Uvc3VibWl0IixkYXRhLCJzdGF0dXNDaGFuZ2VkIiwnWyInICsgc3VjY2Vzc1NxbCArICciXScsJ1siJyArIGZhaWx1cmVTcWwgKyAnIl0nKTsKfQoKZnVuY3Rpb24gdXBkYXRlRGF0YWJhc2UoKQp7CiAgICB2YXIgZGF0YWJhc2UgPSByZXF1aXJlKCdkYXRhYmFzZScpOwogICAgdmFyIHNxbCA9ICJ1cGRhdGUgbV9hciBzZXQgc3RhdHVzPTEgd2hlcmUgX2lkPSciICsgaWQgKyAiJyI7CiAgICBkYXRhYmFzZS5leGVjdXRlU3FsKHNxbCwiIiwiIik7Cn0KCmZ1bmN0aW9uIHN0YXR1c0NoYW5nZWQoaWQsc3RhdHVzKQp7CiAgICBpZiAoc3RhdHVzID09IDEpCiAgICB7CiAgICAgICAgc2V0VGltZW91dCgidXBkYXRlRGF0YWJhc2UoKSIsIDApOwogICAgfQogICAgdXBkYXRlU3RhdHVzKHN0YXR1cyk7Cn0KCmZ1bmN0aW9uIHVwZGF0ZVN0YXR1cyhzdGF0dXMpCnsKICAgIHZhciBiYXNlID0gcmVxdWlyZSgnYmFzZScpOwogICAgYmFzZS4kKCJBcHByb3ZlZEJ0biIpLmRpc2FibGVkPXRydWU7CiAgICBiYXNlLiQoIlJlamVjdGVkQnRuIikuZGlzYWJsZWQ9dHJ1ZTsKICAgIHN3aXRjaChzdGF0dXMpCiAgICB7CiAgICAgICAgY2FzZSAwOgogICAgICAgICAgICBiYXNlLiQoImhpbnQiKS5pbm5lckhUTUw9IiI7CiAgICAgICAgICAgIGJhc2UuJCgiQXBwcm92ZWRCdG4iKS5kaXNhYmxlZD1mYWxzZTsKICAgICAgICAgICAgYmFzZS4kKCJSZWplY3RlZEJ0biIpLmRpc2FibGVkPWZhbHNlOwogICAgICAgICAgICBicmVhazsKICAgICAgICBjYXNlIDE6CiAgICAgICAgICAgIGJhc2UuJCgiaGludCIpLmlubmVySFRNTD0i5aSE55CG5LitIjsKICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgY2FzZSAyOgogICAgICAgICAgICBiYXNlLiQoImhpbnQiKS5pbm5lckhUTUw9IuaPkOS6pOaIkOWKnyI7CiAgICAgICAgICAgIGJyZWFrOwogICAgICAgIGNhc2UgMzoKICAgICAgICAgICAgYmFzZS4kKCJoaW50IikuaW5uZXJIVE1MPSLmj5DkuqTlpLHotKUiOwogICAgICAgICAgICBiYXNlLiQoIkFwcHJvdmVkQnRuIikuZGlzYWJsZWQ9ZmFsc2U7CiAgICAgICAgICAgIGJhc2UuJCgiUmVqZWN0ZWRCdG4iKS5kaXNhYmxlZD1mYWxzZTsKICAgICAgICAgICAgYnJlYWs7CiAgICB9Cn0KCmZ1bmN0aW9uIGluaXQoKQp7CiAgICB2YXIgc3RhdHVzID0gcGFyc2VJbnQocmVxdWlyZSgnYmFzZScpLiQoInN0YXR1cyIpLnZhbHVlKTsKICAgIHVwZGF0ZVN0YXR1cyhzdGF0dXMpOwp9";
    NSLog(@"%@",[[NSString alloc]initWithData:[NSData dataFromBase64String:base64String] encoding:NSUTF8StringEncoding]);
}

- (void)testKeyChain
{
    KeychainItemWrapper* testItem = [[KeychainItemWrapper alloc]initWithIdentifier:@"test" accessGroup:nil];
    {
        [testItem setObject:@"test" forKey:(__bridge id)kSecAttrService];
        [testItem setObject:@"test_username" forKey:(__bridge id)(kSecAttrAccount)];
        [testItem setObject:@"test_password1" forKey:(__bridge id)(kSecValueData)];
        NSString* testPassword = [testItem objectForKey:(__bridge id)(kSecValueData)];
        NSString* testUsername = [testItem objectForKey:(__bridge id)(kSecAttrAccount)];
        STAssertEqualObjects(testPassword, @"test_password1", @"");
        STAssertEqualObjects(testUsername, @"test_username", @"");
    }
    
    {
        [testItem setObject:@"test_password" forKey:(__bridge id)(kSecValueData)];
        NSString* testPassword = [testItem objectForKey:(__bridge id)(kSecValueData)];
        STAssertEqualObjects(testPassword, @"test_password", @"");
    }
    
    {
        [testItem resetKeychainItem];
        NSString* testPassword = [testItem objectForKey:(__bridge id)(kSecValueData)];
        STAssertFalse([testPassword isEqualToString:@"test_password"], @"");
    }
}

- (void)testCategories
{
    NSMutableArray* stack = [[NSMutableArray alloc]init];
    [stack push:@"test"];
    STAssertEqualObjects([stack top], @"test", @"");
    STAssertEqualObjects([stack pop], @"test", @"");
    STAssertEquals(stack.count, (NSUInteger)0, @"");
}

- (void)testXml
{
    NSMutableString* configString = [[NSMutableString alloc]init];
    [configString appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
    [configString appendString:@"<GraphGroup>\n"];
    [configString appendString:@"<Graph barType=\"vertical\" xAxis=\"所属部门\" ref=\"test\" type=\"axis\">\n"];
    [configString appendString:@"<Background titleText=\"年度部门签约额报表\" borderType=\"Rect\"/>\n"];
    [configString appendString:@"<Axis unitText=\"(万)\"/>\n"];
    [configString appendString:@"<Column columnName=\"合同金额\" type=\"barStyle2\"/>\n"];
    [configString appendString:@"</Graph>\n"];
    [configString appendString:@"</GraphGroup>\n"];
    DDXMLDocument* doc = [[DDXMLDocument alloc]initWithXMLString:configString options:0 error:nil];
    STAssertEqualObjects(@"GraphGroup", [[doc rootElement] name], @"");
    DDXMLElement* element = [doc.rootElement elementForName:@"Graph"];
    DDXMLDocument* nDoc = [[DDXMLDocument alloc]initWithXMLString:element.XMLString options:0 error:nil];
    NSLog(@"%@",nDoc.XMLString);
}

- (void)testExample
{
    NSMutableArray* entities = [[NSMutableArray alloc]init];
    [entities addObject:[SFCoreDatabaseTestObject1 class]];
    [entities addObject:[SFCoreDatabaseTestObject2 class]];
    NSArray* createTableSqls = [SFCDBUtil createTableSqls:entities];
    STAssertEqualObjects(createTableSqls[0], @"create table SFCoreDatabaseTestObject1(_id text primary key,name text,age int,salary double)", @"");
    STAssertEqualObjects(createTableSqls[1], @"create table SFCoreDatabaseTestObject2(_id text primary key,name text)", @"");
    NSString* dbFilePath = [[SFCFUUtil tempDirForName:@"db"] stringByAppendingPathComponent:@"test.db"];
    if ([SFCFUUtil fileExistsAtPath:dbFilePath])
    {
        [SFCFUUtil removeFileAtPath:dbFilePath];
    }
    SFCDBSqlite* db = [[SFCDBSqlite alloc]initWithPath:dbFilePath];
    [db open:nil];
    [db executeSqls:createTableSqls];
    SFCoreDatabaseTestObject1* obj1 = [[SFCoreDatabaseTestObject1 alloc]init];
    obj1._id = @"test";
    obj1.name = @"test_name";
    obj1.age = 28;
    obj1.salary = 3999.99;
    [db save:obj1];
    NSArray* findResults = [db findAll:[SFCoreDatabaseTestObject1 class]];
    for (SFCoreDatabaseTestObject1* resultObj in findResults)
    {
        STAssertEqualObjects(resultObj._id, obj1._id, @"");
        STAssertEqualObjects(resultObj.name, obj1.name, @"");
        STAssertEquals(resultObj.age, obj1.age, @"");
        STAssertEquals(resultObj.salary, obj1.salary, @"");
    }
    obj1.age = 29;
    [db update:obj1];
    findResults = [db findAll:[SFCoreDatabaseTestObject1 class]];
    STAssertEquals(((SFCoreDatabaseTestObject1*)findResults[0]).age, 29, @"");
    [db delete:obj1];
    findResults = [db findAll:[SFCoreDatabaseTestObject1 class]];
    STAssertEquals(findResults.count, (NSUInteger)0, @"");
    [db close];
    [SFCFUUtil removeFileAtPath:dbFilePath];
}

@end
