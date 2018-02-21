//
//  SVEVkModelTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 18/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//


#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVEVkModel.h"
#import "SVECoreDataService.h"
#import "SVEParseHelper.h"

@interface SVEVkModel (Tests)


@property (nonatomic, strong) SVECoreDataService *coreDataService;


@end

@interface SVEVkModelTests : XCTestCase

@property (nonatomic, strong) SVEVkModel *model;

@end

@implementation SVEVkModelTests

- (void)setUp {
    [super setUp];
    self.model = OCMPartialMock([SVEVkModel new]);
}

- (void)tearDown {
    self.model = nil;
    [super tearDown];
}

- (void)testCountOfVkFriends
{
    self.model.vkFriends = @[];
    NSUInteger count = [self.model countOfVkFriends];
    expect(count).to.equal(0);
}

- (void)testConfigureModelWithDataNotNil
{
    id coreDatamock = OCMClassMock([SVECoreDataService class]);
    id parser = OCMClassMock([SVEParseHelper class]);
    OCMStub([coreDatamock new]).andReturn(coreDatamock);
    OCMStub([coreDatamock saveFriends]);
    OCMStub([parser parseVkFriendsFromData:[OCMArg any]]).andReturn(@[@"1"]);
    [self.model configureModelWithData:nil];
    expect([self.model.vkFriends count]).to.equal(1);
    expect([self.model.vkFriends firstObject]).to.equal(@"1");
    [parser stopMocking];
    [coreDatamock stopMocking];
}

- (void)testConfigureModelWithDataNil
{
    id parser = OCMClassMock([SVEParseHelper class]);
    id coreDatamock = OCMClassMock([SVECoreDataService class]);
    OCMStub([coreDatamock new]).andReturn(coreDatamock);
    OCMStub([parser parseVkFriendsFromData:[OCMArg any]]).andReturn(nil);
    OCMStub([coreDatamock friendsFromCoreData]).andReturn(nil);
    [self.model configureModelWithData:nil];
    expect([self.model vkFriends]).to.equal(nil);
}

@end

