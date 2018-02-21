//
//  SVENetworkServiceTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 18/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVENetworkService.h"
#import "SVENetworkServiceProtocol.h"


@interface SVENetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;

@end

@interface SVENetworkServiceTests : XCTestCase

@property (nonatomic, strong) SVENetworkService *networkService;

@end

@implementation SVENetworkServiceTests

- (void)setUp {
    [super setUp];
    self.networkService = OCMPartialMock([SVENetworkService new]);
    
}

- (void)tearDown {
    self.networkService = nil;
    [super tearDown];
}

- (void)testGetFriendsNoSession
{
    id mySession = OCMPartialMock([NSURLSession new]);
    id session = OCMClassMock([NSURLSession class]);
    id protocolMock = OCMProtocolMock(@protocol(SVENetworkServiceProtocol));
    OCMStub([self.networkService urlSession]).andReturn(mySession);
    OCMStub(!mySession).andReturn(YES);
    OCMStub([session sessionWithConfiguration:[OCMArg any]]).andReturn(mySession);
    OCMStub([protocolMock loadingIsDoneWithDataReceived:[OCMArg any]]);
    OCMExpect([mySession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]);
    [self.networkService getFriends];
    OCMVerify([mySession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]);
}

- (void)testGetFriendsWithSession
{
    id mySession = OCMPartialMock([NSURLSession new]);
    id protocolMock = OCMProtocolMock(@protocol(SVENetworkServiceProtocol));
    OCMStub([self.networkService urlSession]).andReturn(mySession);
    OCMStub([mySession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]);
    OCMStub([self.networkService delegate]).andReturn(protocolMock);
    [self.networkService getFriends];

}

@end

