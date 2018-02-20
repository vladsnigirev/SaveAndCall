//
//  SVEFriendRepresentationTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 17/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SVECoreDataFriendModel+CoreDataClass.h"
#import "SVEFriendRepresentation.h"
#import <OCMock.h>
#import <Expecta.h>

@interface SVEFriendRepresentationTests : XCTestCase

@property (nonatomic, strong) SVEFriendRepresentation *friend;

@end

@implementation SVEFriendRepresentationTests

- (void)setUp {
    [super setUp];
    self.friend = OCMPartialMock([SVEFriendRepresentation new]);
}

- (void)tearDown {
    self.friend = nil;
    [super tearDown];
}

- (void)testInitWithDictionaryNil
{
    [self.friend initWithDictionary:nil];
    expect(self.friend.firstNameString).to.equal(nil);
    expect(self.friend.lastNameString).to.equal(nil);
    expect(self.friend.phoneNumberString).to.equal(nil);
    expect(self.friend.photo_100_Url).to.equal(nil);
    expect(self.friend.photo_200_Url).to.equal(nil);
}

- (void)testInitWithDictionaryEmpty
{
    SVEFriendRepresentation *friend;
    NSDictionary *dictionaryEmpty = [NSDictionary new];
    [friend initWithDictionary:dictionaryEmpty];
    expect(friend.firstNameString).to.equal(nil);
    expect(friend.lastNameString).to.equal(nil);
    expect(friend.phoneNumberString).to.equal(nil);
    expect(friend.photo_100_Url).to.equal(nil);
    expect(friend.photo_200_Url).to.equal(nil);
}

- (void)testInitWithDictionaryData
{
    SVEFriendRepresentation *friend = OCMPartialMock([SVEFriendRepresentation new]);
    id dictionary = OCMPartialMock([NSDictionary new]);
    OCMStub([dictionary objectForKey:@"first_name"]).andReturn(@"1");
    OCMStub([dictionary objectForKey:@"last_name"]).andReturn(@"2");
    OCMStub([dictionary objectForKey:@"mobile_phone"]).andReturn(@"3");
    OCMStub([dictionary objectForKey:@"photo_200_orig"]).andReturn(@"4");
    OCMStub([dictionary objectForKey:@"photo_100"]).andReturn(@"5");
    [friend initWithDictionary:dictionary];
    expect(friend.firstNameString).to.equal(@"1");
    expect(friend.lastNameString).to.equal(@"2");
    expect(friend.phoneNumberString).to.equal(@"3");
    expect(friend.photo_100_Url).to.equal([NSURL URLWithString:@"5"]);
    expect(friend.photo_200_Url).to.equal([NSURL URLWithString:@"4"]);
    [dictionary stopMocking];
}

- (void)testInitWithDictionaryPhoneEmpty
{
    SVEFriendRepresentation *friend = OCMPartialMock([SVEFriendRepresentation new]);
    id dictionaryNoPhone = OCMPartialMock([NSDictionary new]);
    OCMStub([dictionaryNoPhone objectForKey:@"first_name"]).andReturn(@"1");
    OCMStub([dictionaryNoPhone objectForKey:@"last_name"]).andReturn(@"2");
    OCMStub([dictionaryNoPhone objectForKey:@"mobile_phone"]).andReturn(@"");
    OCMStub([dictionaryNoPhone objectForKey:@"photo_200_orig"]).andReturn(@"4");
    OCMStub([dictionaryNoPhone objectForKey:@"photo_100"]).andReturn(@"5");
    [friend initWithDictionary:dictionaryNoPhone];
    expect(friend.firstNameString).to.equal(@"1");
    expect(friend.lastNameString).to.equal(@"2");
    expect(friend.phoneNumberString).to.equal(nil);
    expect(friend.photo_100_Url).to.equal([NSURL URLWithString:@"5"]);
    expect(friend.photo_200_Url).to.equal([NSURL URLWithString:@"4"]);
}

- (void)testInitWithCoreDataNil
{
    SVEFriendRepresentation *friend = OCMPartialMock([SVEFriendRepresentation new]);
    [friend initWithCoreData:nil];
    expect(friend.firstNameString).to.equal(nil);
    expect(friend.lastNameString).to.equal(nil);
    expect(friend.phoneNumberString).to.equal(nil);
    expect(friend.photo_100_Url).to.equal(nil);
    expect(friend.photo_200_Url).to.equal(nil);
}

- (void)testInitWithCoreDataWithData
{
    SVEFriendRepresentation *friend = OCMPartialMock([SVEFriendRepresentation new]);
    SVECoreDataFriendModel *coreDataFriend = OCMPartialMock([SVECoreDataFriendModel new]);
    OCMStub([coreDataFriend firstName]).andReturn(@"1");
    OCMStub([coreDataFriend lastName]).andReturn(@"2");
    OCMStub([coreDataFriend phoneNumber]).andReturn(@"3");
    [friend initWithCoreData:coreDataFriend];
    expect(friend.firstNameString).to.equal(@"1");
    expect(friend.lastNameString).to.equal(@"2");
    expect(friend.phoneNumberString).to.equal(@"3");
    expect(friend.photo_100_Url).to.equal(nil);
    expect(friend.photo_200_Url).to.equal(nil);
}
//EqualTo??
- (void)testIsEqualNil
{
    SVEFriendRepresentation *friend =  [SVEFriendRepresentation new];
    BOOL value = [friend isEqualTo:nil];
    expect(value).to.equal(NO);
}

- (void)testIsEqualWithFriend
{
    SVEFriendRepresentation *friend1 = OCMPartialMock([SVEFriendRepresentation new]);
    SVEFriendRepresentation *friend2 = OCMPartialMock([SVEFriendRepresentation new]);
    OCMStub([friend1 firstNameString]).andReturn(@"1");
    OCMStub([friend1 lastNameString]).andReturn(@"2");
    OCMStub([friend1 photo_100_Url]).andReturn([NSURL URLWithString:@"3"]);
    OCMStub([friend1 photo_200_Url]).andReturn([NSURL URLWithString:@"4"]);

    OCMStub([friend2 firstNameString]).andReturn(@"1");
    OCMStub([friend2 lastNameString]).andReturn(@"2");
    OCMStub([friend2 photo_100_Url]).andReturn([NSURL URLWithString:@"3"]);
    OCMStub([friend2 photo_200_Url]).andReturn([NSURL URLWithString:@"4"]);
    BOOL value = [friend1 isEqualTo:friend2];
    expect(value).to.equal(YES);
}

- (void)testIsEqualWithFriendFromCoreData
{
    SVEFriendRepresentation *friend1 = OCMPartialMock([SVEFriendRepresentation new]);
    SVEFriendRepresentation *friend2 = OCMPartialMock([SVEFriendRepresentation new]);
    OCMStub([friend1 firstNameString]).andReturn(@"1");
    OCMStub([friend1 lastNameString]).andReturn(@"2");
    OCMStub([friend1 photo_100_Url]).andReturn(nil);
    OCMStub([friend1 photo_200_Url]).andReturn(nil);

    OCMStub([friend2 firstNameString]).andReturn(@"1");
    OCMStub([friend2 lastNameString]).andReturn(@"2");
    OCMStub([friend2 photo_100_Url]).andReturn(nil);
    OCMStub([friend2 photo_200_Url]).andReturn(nil);
    BOOL value = [friend1 isEqualTo:friend2];
    expect(value).to.equal(YES);
}

@end

