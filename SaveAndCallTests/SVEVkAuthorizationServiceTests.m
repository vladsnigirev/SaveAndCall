//
//  SVEVkAuthorizationServiceTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 17/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SVEVkAuthorizationService.h"
#import <SafariServices/SafariServices.h>
#import "SVEVkAuthorizationController.h"


@interface SVEVkAuthorizationService ()

- (BOOL) vkAppExists;

@end

@interface SVEVkAuthorizationServiceTests : XCTestCase

@property (nonatomic, strong) SVEVkAuthorizationService *authService;

@end

@implementation SVEVkAuthorizationServiceTests

- (void)setUp {
    [super setUp];
    self.authService = OCMPartialMock([SVEVkAuthorizationService new]);
    OCMStub([self.authService SVEVkAuthorizationController]).andReturn(nil);
}

- (void)tearDown {
    self.authService = nil;
    [super tearDown];
}

- (void)testVkAppExistsYES
{
    id app = OCMPartialMock([UIApplication sharedApplication]);
    OCMStub([app canOpenURL:[OCMArg any]]).andReturn(YES);
    OCMExpect([app canOpenURL:[OCMArg any]]);
    BOOL value = NO;
    value = [self.authService vkAppExists];
    OCMVerify([app canOpenURL:[OCMArg any]]);
    expect(value).to.equal(YES);
}

- (void)testVkAppExistsNO
{
    id app = OCMPartialMock([UIApplication sharedApplication]);
    OCMStub([app canOpenURL:[OCMArg any]]).andReturn(NO);
    OCMExpect([app canOpenURL:[OCMArg any]]);
    BOOL value = YES;
    value = [self.authService vkAppExists];
    OCMVerify([app canOpenURL:[OCMArg any]]);
    expect(value).to.equal(NO);
}

- (void)testAuthorizeViaVkApp
{
    id app = OCMPartialMock([UIApplication sharedApplication]);
    OCMStub([self.authService vkAppExists]).andReturn(YES);
    OCMExpect([app openURL:[OCMArg any] options:[OCMArg any] completionHandler:[OCMArg any]]);
    [self.authService authorize];
    OCMVerify([app openURL:[OCMArg any] options:[OCMArg any] completionHandler:[OCMArg any]]);
}

- (void)testAuthorizeViaSafari
{
    id safari = OCMClassMock([SFSafariViewController class]);
    OCMExpect([[self.authService SVEVkAuthorizationController] presentViewController:safari animated:YES completion:nil]);
    [self.authService authorize];
    OCMVerify([[self.authService SVEVkAuthorizationController] presentViewController:safari animated:YES completion:nil]);

}

@end

