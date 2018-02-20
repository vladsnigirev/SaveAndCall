//
//  SVETokenServiceTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 17/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVETokenService.h"
#import "SVEParseHelper.h"
#import "SVERouter.h"

@interface SVETokenService ()

@property (nonatomic, assign) NSUInteger currentState;
- (void)fillUserDefaults:(NSNotification *)notification;

@end
@interface SVETokenServiceTests : XCTestCase

@property (nonatomic, strong) SVETokenService *tokenService;

@end

@implementation SVETokenServiceTests

- (void)setUp {
    [super setUp];
    self.tokenService = OCMPartialMock([SVETokenService new]);
    OCMStub([self.tokenService router]);
}

- (void)tearDown {
    self.tokenService = nil;
    [super tearDown];
}

- (void)testFillUserDefaultsUserInfoError
{
    id notification = OCMClassMock([NSNotification class]);
    id parser = OCMClassMock([SVEParseHelper class]);
    id router = OCMClassMock([SVERouter class]);
    OCMStub([self.tokenService router]).andReturn(router);
    OCMStub([router switchAuthorizationControllerToMain]);
    OCMStub([router switchMainControllerToAuthorization]);
    OCMStub([parser parseAuthorizationUrl:[OCMArg any]]).andReturn(nil);
    OCMExpect([self.tokenService clearUserDefaults]);
    OCMExpect([[self.tokenService router] switchMainControllerToAuthorization]);
    [self.tokenService fillUserDefaults:notification];
    OCMVerify([self.tokenService clearUserDefaults]);
    OCMVerify([[self.tokenService router] switchMainControllerToAuthorization]);
}

- (void)testFillUserDefaultsUserInfoOk
{
    id dictionary = OCMClassMock([NSDictionary class]);
    id notification = OCMClassMock([NSNotification class]);
    id parser = OCMClassMock([SVEParseHelper class]);
    id router = OCMClassMock([SVERouter class]);
    OCMStub([self.tokenService router]).andReturn(router);
    OCMStub([router switchAuthorizationControllerToMain]);
    OCMStub([router switchMainControllerToAuthorization]);
    OCMExpect([self.tokenService.router switchAuthorizationControllerToMain]);
    OCMStub([parser parseAuthorizationUrl:[OCMArg any]]).andReturn(dictionary);
    OCMExpect([[self.tokenService router] switchAuthorizationControllerToMain]);
    [self.tokenService fillUserDefaults:notification];
    OCMVerify([[self.tokenService router] switchAuthorizationControllerToMain]);
}

- (void)testIsLoggedExpiresInNil
{
    id userDefaults = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaults standardUserDefaults]).andReturn(nil);
    OCMExpect([self.tokenService currentState]);
    BOOL value = NO;
    value = [self.tokenService isLogged];
    expect(value).to.equal(YES);
    OCMVerify([self.tokenService currentState]);
}

- (void)testIsLoggedExpiresInIsBad
{
    id userDefaults = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaults standardUserDefaults]).andReturn(nil);
    id date = OCMClassMock([NSDate class]);
    id mockDate = OCMPartialMock([NSDate new]);
    OCMStub([date date]).andReturn(mockDate);
    OCMStub([mockDate compare:[OCMArg any]]).andReturn(NSOrderedDescending);
    OCMStub([self.tokenService clearUserDefaults]);
    OCMExpect([self.tokenService clearUserDefaults]);
    BOOL value = YES;
    value = [self.tokenService isLogged];
    expect(value).to.equal(NO);
    OCMVerify([self.tokenService clearUserDefaults]);
}

- (void)testIsLoggedExpiresInIsOK
{
    id userDefaults = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaults standardUserDefaults]).andReturn(nil);
    id date = OCMClassMock([NSDate class]);
    id mockDate = OCMPartialMock([NSDate new]);
    OCMStub([date date]).andReturn(mockDate);
    OCMStub([mockDate compare:[OCMArg any]]).andReturn(NSOrderedAscending);
    OCMStub([self.tokenService currentState]).andReturn(0);
    OCMStub([self.tokenService clearUserDefaults]);
    OCMExpect([self.tokenService clearUserDefaults]);
    BOOL value = NO;
    value = [self.tokenService isLogged];
    expect(value).to.equal(YES);
}

- (void)testClearUserDefaults
{
    id router = OCMClassMock([SVERouter class]);
    OCMStub([self.tokenService router]).andReturn(router);
    OCMStub([router switchMainControllerToAuthorization]);
    OCMExpect([self.tokenService.router switchMainControllerToAuthorization]);
    [self.tokenService clearUserDefaults];
    OCMVerify([self.tokenService.router switchMainControllerToAuthorization]);
}

- (void)testContinueWithoutAuthorization
{
    id router = OCMClassMock([SVERouter class]);
    OCMStub([self.tokenService router]).andReturn(router);
    OCMStub([router switchAuthorizationControllerToMain]);
    OCMExpect([self.tokenService.router switchAuthorizationControllerToMain]);
    [self.tokenService continueWithoutAuthorization];
    OCMVerify([self.tokenService.router switchAuthorizationControllerToMain]);
}

@end

