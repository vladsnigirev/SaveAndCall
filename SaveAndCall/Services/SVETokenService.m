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

@interface SVETokenService ()

@end

@implementation SVETokenService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillUserDefaults:) name:SVEAppGotInformationAfterAutorization object:nil];
    }
    return self;
}

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
    NSDate *interval = [NSDate dateWithTimeIntervalSinceNow:([expiresInString doubleValue] - 1)];
    [[NSUserDefaults standardUserDefaults] setObject:interval forKey:@"expires_in"];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    [[NSUserDefaults standardUserDefaults] setObject:[accessTokenDictionary objectForKey:@"access_token"] forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.router switchAuthorizationControllerToMain];
}

- (BOOL)isLogged
{
    NSDate *now = [NSDate date];
    NSDate *expiresIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_in"];
    if (([now compare:expiresIn] == NSOrderedDescending) || !(expiresIn))
    {
        [self clearUserDefaults];
        return NO;
    }
    else
        return YES;
}

- (void)clearUserDefaults
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"expires_in"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.router switchMainControllerToAuthorization];
}

- (void)continueWithoutAuthorization
{
    [self.router switchAuthorizationControllerToMain];
}



@end
