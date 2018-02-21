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
static NSString *SVEUserIdKey = @"user_id";
static NSString *SVEExpiresInKey = @"expires_in";
static NSString *SVEAccessTokenKey = @"access_token";
static NSString *SVEIsLoggedKey = @"isLogged";


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
        
    [[NSUserDefaults standardUserDefaults] setObject:[accessTokenDictionary objectForKey:SVEUserIdKey] forKey:SVEUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    NSString *expiresInString = [accessTokenDictionary objectForKey:SVEExpiresInKey];
    NSDate *interval = [NSDate dateWithTimeIntervalSinceNow:([expiresInString doubleValue])];
    [[NSUserDefaults standardUserDefaults] setObject:interval forKey:SVEExpiresInKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    [[NSUserDefaults standardUserDefaults] setObject:[accessTokenDictionary objectForKey:SVEAccessTokenKey] forKey:SVEAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SVEIsLoggedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.currentState = SVEUserWithAuthorization;
    [self.router switchAuthorizationControllerToMain];
}


#pragma mark - Public

- (BOOL)isLogged
{
    NSDate *now = [NSDate date];
    NSDate *expiresIn = [[NSUserDefaults standardUserDefaults] objectForKey:SVEExpiresInKey];
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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SVEUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SVEExpiresInKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SVEAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SVEIsLoggedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.router switchMainControllerToAuthorization];
}

- (void)continueWithoutAuthorization
{
    [self.router switchAuthorizationControllerToMain];
}


@end
