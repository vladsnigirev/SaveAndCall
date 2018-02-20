//
//  SVESynchronizationServiceTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 19/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVESynchronizationService.h"
#import "SVEFriendRepresentation.h"
#import "NSString+SVENumberEraser.h"
#import "SVEContactRepresentation.h"
#import "AppDelegate.h"


@interface SVEFriendRepresentation (Test)


@property (nonatomic, strong) NSString *phoneNumberString;


@end

@interface SVEContactRepresentation ()


@property (nonatomic, strong) NSArray *phonesArray;


@end

@interface SVESynchronizationService (Test)


@property (nonatomic, copy) NSArray *friendsArray;
@property (nonatomic, copy) NSArray *contactsArray;

- (NSArray *)updateModel:(NSArray *)additionalFriends;
- (NSArray *)findfriendsWithPhones;
- (NSArray *)customizeContactsPhones;
- (void)friendsToContacts:(NSArray *)array;


@end

@interface SVESynchronizationServiceTests : XCTestCase

@property (nonatomic, strong) SVESynchronizationService *service;

@end

@implementation SVESynchronizationServiceTests

- (void)setUp {
    [super setUp];
    self.service = OCMPartialMock([SVESynchronizationService new]);
}

- (void)tearDown {
    self.service = nil;
    [super tearDown];
}

- (void)testUpdateModelArgNilAndFriendsNil
{
    self.service.friendsArray = nil;
    NSArray *result = [self.service updateModel:nil];
    expect([result count]).to.equal(0);
}

- (void)testUpdateModelArgNilAndFriendsNotNil
{
    self.service.friendsArray = @[@"1"];
    NSArray *result = [self.service updateModel:nil];
    expect([result count]).to.equal(0);
}

- (void)testUpdateModelArgNotNilAndFriendsNil
{
    self.service.friendsArray = nil;
    NSArray *result = [self.service updateModel:@[@1]];
    expect([result count]).to.equal(0);
}

- (void)testUpdateModelArgNotNilAndFriendsNotNil
{
    id friend = OCMClassMock([SVEFriendRepresentation class]);
    OCMStub([friend alloc]).andReturn(friend);
    OCMStub([friend phoneNumberString]).andReturn(@"1");
    self.service.friendsArray = @[friend];
    NSArray *result = [self.service updateModel:@[@"1"]];
    expect([result count]).to.equal(1);
    expect([[result firstObject] class]).to.equal([friend class]);
    [friend stopMocking];
}

- (void)testFindFriendsWithPhonesFriendsNil
{
    self.service.friendsArray = nil;
    NSArray *result = [self.service findfriendsWithPhones];
    expect(result).to.beNil();
}

- (void)testFindFriendsWithPhonesFriendsWrongData
{
    id friend = OCMClassMock([SVEFriendRepresentation class]);
    OCMStub([friend alloc]).andReturn(friend);
    OCMStub([friend phoneNumberString]).andReturn(nil);
    self.service.friendsArray = @[friend];
    NSArray *result = [self.service findfriendsWithPhones];
    expect([result count]).to.equal(0);
    [friend stopMocking];
}

- (void)testFindFriendsWithPhonesFriendsData
{
    id friend = OCMPartialMock([SVEFriendRepresentation new]);
    id string = OCMClassMock([NSString class]);
    id array = OCMPartialMock([NSArray new]);
    OCMStub([friend alloc]).andReturn(friend);
    OCMStub([friend phoneNumberString]).andReturn(string);
    OCMStub([string componentsSeparatedByCharactersInSet:[OCMArg any]]).andReturn(array);
    OCMStub([array componentsJoinedByString:[OCMArg any]]).andReturn(@"1234567890");
    OCMStub([string sve_cutOffFirstDigit:[OCMArg any]]).andReturn(@"234567890");
    OCMStub([string length]).andReturn(10);
    self.service.friendsArray = @[friend];
    NSArray *result = [self.service findfriendsWithPhones];
    expect([result count]).to.equal(1);
    expect([result firstObject]).to.equal(friend);
    [array stopMocking];
    [friend stopMocking];
    [string stopMocking];
}

- (void)testFindFriendsWithPhonesFriendsTest
{
    id friend = OCMPartialMock([SVEFriendRepresentation new]);
    id string = OCMClassMock([NSString class]);
    id array = OCMPartialMock([NSArray new]);
    OCMStub([friend new]).andReturn(friend);
    OCMStub([friend phoneNumberString]).andReturn(string);
    OCMStub([string componentsSeparatedByCharactersInSet:[OCMArg any]]).andReturn(array);
    OCMStub([array componentsJoinedByString:[OCMArg any]]).andReturn(@"1234567890");
    OCMStub([string sve_cutOffFirstDigit:[OCMArg any]]).andReturn(@"234567890");
    OCMStub([string length]).andReturn(13);
    self.service.friendsArray = @[friend];
    NSArray *result = [self.service findfriendsWithPhones];
    expect([result count]).to.equal(0);
}

- (void)testCustomizeContactPhonesNoContacts
{
    self.service.contactsArray = nil;
    NSArray *result = [self.service customizeContactsPhones];
    expect(result).notTo.beNil();
    expect([result count]).to.equal(0);
}

- (void)testCustomizeContactPhonesNoPhonesArray
{
    id contact = OCMPartialMock([SVEContactRepresentation new]);
    OCMStub([contact alloc]).andReturn(contact);
    OCMStub([contact phonesArray]).andReturn(nil);
    self.service.contactsArray = @[contact];
    NSArray *result = [self.service customizeContactsPhones];
    expect([result count]).to.equal(0);
    [contact stopMocking];
}

- (void)testCustomizeContactPhonesOkData
{
    id contact = OCMPartialMock([SVEContactRepresentation new]);
    id array = OCMPartialMock([NSArray new]);
    id string = OCMClassMock([NSString class]);
    OCMStub([contact alloc]).andReturn(contact);
    OCMStub([contact phonesArray]).andReturn(@[string]);
    OCMStub([string componentsSeparatedByCharactersInSet:[OCMArg any]]).andReturn(array);
    OCMStub([array componentsJoinedByString:[OCMArg any]]).andReturn(string);
    OCMStub([string sve_cutOffFirstDigit:[OCMArg any]]).andReturn(@"12345678999");
    self.service.contactsArray = @[contact];
    NSArray *result = [self.service customizeContactsPhones];
    expect([result count]).to.equal(1);
    expect([result firstObject]).to.equal(@"12345678999");
    [contact stopMocking];
    [array stopMocking];
    [string stopMocking];
}

@end

