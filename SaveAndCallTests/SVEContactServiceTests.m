//
//  SVEContactServiceTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 19/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVEContactsService.h"
#import <Contacts/Contacts.h>
#import "SVEContactsProtocol.h"

@interface SVEContactServiceTests : XCTestCase

@property (nonatomic, strong) SVEContactsService *service;

@end

@implementation SVEContactServiceTests

- (void)setUp {
    [super setUp];
    self.service = OCMPartialMock([SVEContactsService new]);
}

- (void)tearDown {
    self.service = nil;
    [super tearDown];
}

- (void)testGetContacts
{
    id contactStore = OCMClassMock([CNContactStore class]);
    OCMStub([contactStore alloc]).andReturn(contactStore);
    OCMExpect([contactStore enumerateContactsWithFetchRequest:[OCMArg any] error:nil usingBlock:[OCMArg any]]);
    [self.service getContacts];
    OCMVerify([contactStore enumerateContactsWithFetchRequest:[OCMArg any] error:nil usingBlock:[OCMArg any]]);
}


@end
