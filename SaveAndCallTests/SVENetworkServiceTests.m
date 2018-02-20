////
////  SVENetworkServiceTests.m
////  SaveAndCallTests
////
////  Created by Влад Снигирев on 18/02/2018.
////  Copyright © 2018 Vlad Snigiryov. All rights reserved.
////
//
//#import <XCTest/XCTest.h>
//#import <OCMock.h>
//#import <Expecta.h>
//#import "SVENetworkService.h"
//#import "SVENetworkServiceProtocol.h"
//
//
//@interface SVENetworkService ()
//
//@property (nonatomic, strong) NSURLSession *urlSession;
//
//@end
//
//@interface SVENetworkServiceTests : XCTestCase
//
//@property (nonatomic, strong) SVENetworkService *networkService;
//
//@end
//
//@implementation SVENetworkServiceTests
//
//- (void)setUp {
//    [super setUp];
//    self.networkService = OCMPartialMock([SVENetworkService new]);
//    
//}
//
//- (void)tearDown {
//    self.networkService = nil;
//    [super tearDown];
//}
//
//- (void)testGetFriendsNoSession
//{
//    id mySession = OCMPartialMock([NSURLSession new]);
//    id session = OCMClassMock([NSURLSession class]);
//    id protocolMock = OCMProtocolMock(@protocol(SVENetworkServiceProtocol));
//    OCMStub([self.networkService urlSession]).andReturn(mySession);
//    OCMStub(!mySession).andReturn(YES);
//   // OCMStub(mySession).andReturn(YES);
//    OCMStub([session sessionWithConfiguration:[OCMArg any]]).andReturn(mySession);
////    OCMStub([self.networkService urlSession]).andReturn(mySession);
////    OCMStub([self.networkService delegate]).andReturn(protocolMock);
////    OCMStub([protocolMock loadingIsDoneWithDataReceived:[OCMArg any]]);
////    OCMVerify([session sessionWithConfiguration:[OCMArg any]]);
//    OCMStub([protocolMock loadingIsDoneWithDataReceived:[OCMArg any]]);
//    OCMVerify([mySession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]);
//    [self.networkService getFriends];
////    OCMExpect([session sessionWithConfiguration:[OCMArg any]]);
////    OCMExpect([[self.networkService delegate] loadingIsDoneWithDataReceived:[OCMArg any]]);
//    OCMExpect([mySession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]);
//}
//
//- (void)testGetFriendsWithSession
//{
//    id mySession = OCMPartialMock([NSURLSession new]);
//    id protocolMock = OCMProtocolMock(@protocol(SVENetworkServiceProtocol));
//    OCMStub([self.networkService urlSession]).andReturn(mySession);
//    OCMStub([mySession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]);
//    OCMStub([self.networkService delegate]).andReturn(protocolMock);
//    [self.networkService getFriends];
//
//}
//
////- (void) getFriends
////{
////    if (!self.urlSession)
////    {
////        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
////        self.urlSession = session;
////    }
////    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
////    NSString *urlString =  [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?order=name&access_token=%@&offset=0&fields=contacts%%2Cphoto_100%%2Cphoto_200_orig&name_case=nom",access_token];
////
////    NSMutableURLRequest *friendsRequest = [[NSMutableURLRequest alloc] init];
////    [friendsRequest  setURL:[NSURL URLWithString:urlString]];
////    [friendsRequest setHTTPMethod:@"GET"];
////    [friendsRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
////    [friendsRequest setTimeoutInterval:10];
////
////    NSURLSessionDataTask *requestTask = [self.urlSession dataTaskWithRequest:friendsRequest completionHandler:
////                                         ^(NSData * _Nullable data,
////                                           NSURLResponse * _Nullable response,
////                                           NSError * _Nullable error) {
////                                             [self.delegate loadingIsDoneWithDataReceived:data];
////                                         }];
////    [requestTask resume];
////
////}
//@end

