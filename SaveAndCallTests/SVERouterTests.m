//
//  SVERouterTests.m
//  SaveAndCallTests
//
//  Created by Влад Снигирев on 18/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SVERouter.h"
#import <OCMock.h>
#import <Expecta.h>
#import "SVEInterfaceBuilder.h"
#include "AppDelegate.h"
#import "SVEVkModel.h"
#import "SVEContactsModel.h"

@interface SVERouter ()


@property (nonatomic, assign) NSUInteger routerState;

- (void)clearModels;


@end

@interface SVERouterTests : XCTestCase

@property (nonatomic, strong) SVERouter *router;

@end

@implementation SVERouterTests

- (void)setUp {
    [super setUp];
    self.router = OCMPartialMock([[SVERouter alloc] init]);
}

- (void)tearDown {
    self.router = nil;
    [super tearDown];
}

- (void)testDefineViewControllerAuthorized
{
    id builder = OCMClassMock([SVEInterfaceBuilder class]);
    OCMStub([builder buildMainController]).andReturn([UIViewController class]);
    OCMStub([self.router routerState]).andReturn(0);
    OCMExpect([builder buildMainController]);
    id controller = [self.router defineViewController];
    expect([controller class]).to.equal([UIViewController class]);
    OCMVerify([builder buildMainController]);
}

- (void)testDefineViewControllerNotAuthorized
{
    id builder = OCMClassMock([SVEInterfaceBuilder class]);
    OCMStub([builder buildAuthorizationController]).andReturn([UIViewController class]);
    OCMStub([self.router routerState]).andReturn(1);
    OCMExpect([builder buildAuthorizationController]);
    id controller = [self.router defineViewController];
    expect([controller class]).to.equal([UIViewController class]);
    OCMVerify([builder buildAuthorizationController]);
}

- (void)testSetDefinedViewController
{
    id app = OCMClassMock([UIApplication class]);
    id window = OCMPartialMock([UIWindow new]);
    id view = OCMPartialMock([UIView new]);
    OCMStub([self.router defineViewController]).andReturn(nil);
    OCMStub([app sharedApplication]);
    OCMStub([app windows]).andReturn([window class]);
    OCMExpect([app sharedApplication]);
    OCMExpect([view transitionWithView:window
                                        duration:0.5
                                        options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:[OCMArg any] completion:[OCMArg any]]);
    [self.router setDefinedViewController];
    expect([app windows]).to.equal([window class]);
    OCMVerify([app sharedApplication]);
    OCMVerify(OCMExpect([view transitionWithView:window
                                        duration:0.5
                                         options:UIViewAnimationOptionTransitionFlipFromLeft
                                      animations:[OCMArg any] completion:[OCMArg any]]));
    
}

- (void)testSwitchAuthorizationControllerToMain
{
    self.router.routerState = 1;
    OCMStub([self.router clearModels]);
    OCMStub([self.router defineViewController]).andReturn(nil);
    OCMExpect([self.router clearModels]);
    OCMExpect([self.router defineViewController]).andReturn(nil);
    [self.router switchAuthorizationControllerToMain];
    expect([self.router routerState]).to.equal(0);
    OCMVerify([self.router clearModels]);
    OCMVerify([self.router defineViewController]);
}

- (void)testSwitchMainControllerToAuthorization
{
    self.router.routerState = 0;
    OCMStub([self.router clearModels]);
    OCMStub([self.router defineViewController]).andReturn(nil);
    OCMExpect([self.router clearModels]);
    OCMExpect([self.router defineViewController]).andReturn(nil);
    [self.router switchMainControllerToAuthorization];
    expect([self.router routerState]).to.equal(1);
    OCMVerify([self.router clearModels]);
    OCMVerify([self.router defineViewController]);
}

- (void)testClearModels
{
    id app = OCMPartialMock([UIApplication sharedApplication]);
    OCMExpect([app delegate]);
    [self.router clearModels];
    OCMVerify([app delegate]);
}

@end

