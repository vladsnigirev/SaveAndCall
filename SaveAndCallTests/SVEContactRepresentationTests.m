//
//  SVEContactRepresentationTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 17/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import <Contacts/Contacts.h>
#import "SVEContactRepresentation.h"
#import "SVEFriendRepresentation.h"

@interface SVEContactRepresentationTests : XCTestCase

@end

@implementation SVEContactRepresentationTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWithContactNil
{
    id myContact = OCMPartialMock([SVEContactRepresentation new]);
    [myContact initWithContact:nil];
    expect([myContact firstNameString]).to.beNil();
    expect([myContact lastNameString]).to.beNil();
    expect([myContact imageData]).notTo.beNil();
    expect([myContact phonesArray]).to.beNil();
}

- (void)testInitWithContact
{
    id myContact = OCMPartialMock([SVEContactRepresentation new]);
    id contact = OCMClassMock([CNContact class]);
    OCMStub([contact givenName]).andReturn(@"1");
    OCMStub([contact familyName]).andReturn(@"2");
    OCMStub([contact imageData]).andReturn(nil);
    OCMStub([[[contact phoneNumbers] valueForKey:@"value"] valueForKey:@"digits"]).andReturn(@[]);
    
    [myContact initWithContact:contact];
    expect([myContact firstNameString]).to.equal(@"1");
    expect([myContact lastNameString]).to.equal(@"2");
    expect([myContact imageData]).notTo.beNil();
    expect([myContact phonesArray]).to.equal(@[]);
}

- (void)testInitWithFriendNil
{
    id myContact = OCMPartialMock([SVEContactRepresentation new]);
    [myContact initWithFriend:nil];
    expect([myContact class]).to.equal([SVEContactRepresentation class]);
    expect([myContact firstNameString]).to.beNil();
    expect([myContact lastNameString]).to.beNil();
    expect([myContact imageData]).toNot.beNil();
    expect([myContact phonesArray]).to.beNil();
}

- (void)testInitWithFriendData
{
    id friend = OCMPartialMock([SVEFriendRepresentation new]);
    OCMStub([friend firstNameString]).andReturn(@"1");
    OCMStub([friend lastNameString]).andReturn(@"2");
    OCMStub([friend phoneNumberString]).andReturn(@"3");
    OCMStub([friend photo_100_image]).andReturn(nil);
    id myContact = OCMPartialMock([SVEContactRepresentation new]);
    [myContact initWithFriend:friend];
    expect([myContact class]).to.equal([SVEContactRepresentation class]);
    expect([myContact firstNameString]).to.equal(@"1");
    expect([myContact lastNameString]).to.equal(@"2");
    expect([myContact imageData]).toNot.beNil();
    expect([[myContact phonesArray] count]).to.equal(1);
    expect([[myContact phonesArray] firstObject]).to.equal(@"3");
}


@end
