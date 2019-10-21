//
//  project2Tests.m
//  project2Tests
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "GoodGameplay.h"

@interface project2Tests : XCTestCase

@property GoodGameplay *ggp;

@end

@implementation project2Tests

@synthesize ggp = _ggp;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _ggp = [[GoodGameplay alloc] init];
    XCTAssertNotNil(_ggp, @"Cannot create instance of GoodGameplay");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testMatchChar
{
    // - (int) matchChar: (char) ch withTargetWord: (NSString*) stargetword;
    
    XCTAssertTrue([_ggp matchChar:'A' withTargetWord: @"BALL"] == 1, @"Char not is found in BALL");
}

-(void) testRandomNumber
{
    
    int n = [_ggp getrandomnumber: 5];
    
    XCTAssertTrue(n >= 0 && n <= 5, @"Randon number (5) not in range: %d", n);
    
    NSLog(@"Value of n = %d", n);
    
    // try negative nubers in random functio or max_int
    
}

-(void) testnguessed
{

    // - (int) getnguessed;
    
    int ng = [_ggp getnguessed];
    
    XCTAssertTrue(ng >= 0 && ng <= 26, @"nguessed %d not within range: 0 to 26", ng);
    
    NSLog(@"Value of ng = %d", ng);
    
}

-(void) testMatch
{
    
    // - (int) matchChar: (char) ch withTargetWord: (NSString*) stargetword;
    
    int n = [_ggp matchChar:'E' withTargetWord: @"DEER"];
    
    NSLog(@"Value of n match char = %d", n);
    
    // - (void) updateDict: (NSString*) string;
    
    [_ggp updateDict:@"E"];
    
    // - (NSString*) displayDict;
    
    NSLog(@"Dict = %@", [_ggp displayDict]);
    
    // - (NSString*) match: (int) nmatched withTargetWord: (NSString*)stargetword;
    
    XCTAssertTrue([[_ggp match: n withTargetWord:@"DEER"] isEqualToString: @"-EE-"], @"Does not match: %d", n);
    
    NSLog(@"Result from match = %@", [_ggp match: n withTargetWord:@"DEER"]);

}

// - (void) eqclassforwords: (NSMutableArray*) temp forChar: (char) ch;
// - (void) addwordtoeqclass: (NSMutableArray*) temp forChar: (char) ch;
// - (void) largesteqclass;

// - (id) getcomplementlargesteqclass;

@end
