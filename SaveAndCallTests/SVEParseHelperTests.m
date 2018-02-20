//
//  SVEParseHelperTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 17/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SVEParseHelper.h"
#import <OCMock.h>
#import <Expecta.h>
#import "SVEContactRepresentation.h"
#import <Contacts/Contacts.h>

@interface SVEParseHelperTests : XCTestCase

@property (nonatomic, strong) SVEParseHelper *parseHelper;

@end

@implementation SVEParseHelperTests

- (void)setUp {
    [super setUp];
    self.parseHelper = OCMClassMock([SVEParseHelper class]);
}

- (void)tearDown {
    self.parseHelper = nil;
    [super tearDown];
}

- (void)testParseContactsArrayNil
{
    NSMutableArray *mutableArray = OCMClassMock([NSMutableArray class]);
    OCMStub([mutableArray count]).andReturn(0);
    NSArray *result = [SVEParseHelper parseContactsArray:nil];
    expect(result.count).to.equal(0);
}

- (void)testParseContactsArrayEmpty
{
    NSMutableArray *mutableArray = OCMClassMock([NSMutableArray class]);
    OCMStub([mutableArray count]).andReturn(0);
    NSArray *result = [SVEParseHelper parseContactsArray:nil];
    expect(result.count).to.equal(0);
}

@end


