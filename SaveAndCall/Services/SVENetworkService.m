//
//  SVENetworkService.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVENetworkService.h"
#import <UIKit/UIKit.h>

@interface SVENetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation SVENetworkService

- (void) getFriends
{
    if (!self.urlSession)
    {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.urlSession = session;
    }
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *urlString =  [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?order=name&access_token=%@&offset=0&fields=contacts%%2Cphoto_100%%2Cphoto_200_orig&name_case=nom",access_token];
    
    NSMutableURLRequest *friendsRequest = [[NSMutableURLRequest alloc] init];
    [friendsRequest  setURL:[NSURL URLWithString:urlString]];
    [friendsRequest setHTTPMethod:@"GET"];
    [friendsRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [friendsRequest setTimeoutInterval:10];
    
    NSURLSessionDataTask *requestTask = [self.urlSession dataTaskWithRequest:friendsRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self.delegate loadingIsDoneWithDataReceived:data];
    }];
    [requestTask resume];
    
}

- (UIImage *)downloadImageByURL:(NSURL *)url
{
    if (!self.urlSession)
    {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.urlSession = session;
    }
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return image;
}

@end
