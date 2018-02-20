//
//  SVENumberEraserTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 20/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+SVENumberEraser.h"
#import <OCMock.h>
#import <Expecta.h>

@interface SVENumberEraserTests : XCTestCase

@end

@implementation SVENumberEraserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testsve_cutOffFirstDigitNilString
{
    NSString *string = nil;
    string = [string sve_cutOffFirstDigit:nil];
    expect(string).to.equal(nil);
}

- (void)testsve_cutOffFirstDigitNoChanging
{
    NSString *string = @"123";
    string = [string sve_cutOffFirstDigit:string];
    expect(string).to.equal(@"123");
}

- (void)testsve_cutOffFirstDigitChangeing
{
    NSString *string = @"12345678901";
    string = [string sve_cutOffFirstDigit:string];
    expect(string).to.equal(@"2345678901");
}

//- (NSString *)sve_cutOffFirstDigit:(NSString *)number
//{
//    if (number.length == 11)
//    {
//        number = [number substringFromIndex:1];
//    }
//    return number;
//}

@end
