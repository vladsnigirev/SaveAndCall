//
//  SVEUserDefaultsHelper.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEUserDefaultsHelper.h"
#import "SVEParseHelper.h"

static NSString *const SVEAppGotInformationAfterAutorization = @"SVEAppGotInformationAfterAutorization";
static NSString *const SVEAppIsAuthorized = @"SVEAppIsAuthorized";
static NSString *const SVEAppIsNotAuthorized = @"SVEAppIsNotAuthorized";

@interface SVEUserDefaultsHelper ()

@end

@implementation SVEUserDefaultsHelper

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
        [[NSNotificationCenter defaultCenter] postNotificationName:SVEAppIsNotAuthorized object:nil];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:SVEAppIsAuthorized object:nil];
}

+ (BOOL)isLogged
{
    NSDate *now = [NSDate date];
    NSDate *expiresIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_in"];
    if (([now compare:expiresIn] == NSOrderedDescending) || (!expiresIn))
    {
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
}

@end
