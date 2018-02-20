//
//  SVEContactsModelTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 18/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVEContactsModel.h"
#import "SVEParseHelper.h"


@interface SVEContactsModelTests : XCTestCase

@property (nonatomic, strong) SVEContactsModel *model;

@end

@implementation SVEContactsModelTests

- (void)setUp {
    [super setUp];
    self.model = OCMPartialMock([SVEContactsModel new]);
}

- (void)tearDown {
    self.model = nil;
    [super tearDown];
}

- (void)testCountOfContacts
{
    self.model.contacts = @[@"1"];
    [self.model countOfContacts];
    expect([self.model.contacts count]).to.equal(1);
    expect([self.model.contacts firstObject]).to.equal(@"1");
}

- (void)testConfigureModelWithContactsArrayNil
{
    [self.model configureModelWithContactsArray:nil];
    expect(self.model.contacts).to.beNil();
}

- (void)testConfigureModelWithContactsArrayWithData
{
    id parser = OCMClassMock([SVEParseHelper class]);
    OCMStub([parser parseContactsArray:[OCMArg any]]).andReturn(@[@"2"]);
    [self.model configureModelWithContactsArray:[OCMArg any]];
    expect([self.model.contacts count]).to.equal(1);
    expect([self.model.contacts firstObject]).to.equal(@"2");
}


//- (void)configureModelWithContactsArray:(NSArray *)contactsArray
//{
//    self.contacts = [SVEParseHelper parseContactsArray:contactsArray];
//}


@end
