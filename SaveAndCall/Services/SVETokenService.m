//
//  SVEUserDefaultsHelper.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVETokenService.h"
#import "SVEParseHelper.h"


static NSString *const SVEAppGotInformationAfterAutorization = @"SVEAppGotInformationAfterAutorization";


typedef NS_ENUM(NSUInteger,SVEUserAuthorization)
{
    SVEUserWithAuthorization,
    SVEUserWithoutAuthorization
};


@interface SVETokenService ()


@property (nonatomic, assign) NSUInteger currentState;


@end

@implementation SVETokenService


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(fillUserDefaults:)
                                              name:SVEAppGotInformationAfterAutorization
                                              object:nil];
        _currentState = SVEUserWithoutAuthorization;
    }
    return self;
}


#pragma mark - Private

- (void)fillUserDefaults:(NSNotification *)notification
{
    NSDictionary *accessTokenDictionary = [SVEParseHelper parseAuthorizationUrl:[notification.userInfo objectForKey:@"Url"]];
    
    if (!accessTokenDictionary)
    {
        [self clearUserDefaults];
        [self.router switchMainControllerToAuthorization];
        return;
    }
        
    [[NSUserDefaults standardUserDefaults] setObject:[accessTokenDictionary objectForKey:@"user_id"] forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    NSString *expiresInString = [accessTokenDictionary objectForKey:@"expires_in"];
    NSDate *interval = [NSDate dateWithTimeIntervalSinceNow:([expiresInString doubleValue])];
    [[NSUserDefaults standardUserDefaults] setObject:interval forKey:@"expires_in"];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    [[NSUserDefaults standardUserDefaults] setObject:[accessTokenDictionary objectForKey:@"access_token"] forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.currentState = SVEUserWithAuthorization;
    [self.router switchAuthorizationControllerToMain];
}


#pragma mark - Public

- (BOOL)isLogged
{
    NSDate *now = [NSDate date];
    NSDate *expiresIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_in"];
    if (([now compare:expiresIn] == NSOrderedDescending))
    {
        [self clearUserDefaults];
        return NO;
    }
    else if (self.currentState == SVEUserWithoutAuthorization)
    {
        return YES;
    }
    return YES;
}

- (void)clearUserDefaults
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"expires_in"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.router switchMainControllerToAuthorization];
}

- (void)continueWithoutAuthorization
{
    [self.router switchAuthorizationControllerToMain];
}


@end
