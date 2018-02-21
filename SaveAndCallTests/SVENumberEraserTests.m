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
}

- (void)tearDown {
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

@end
