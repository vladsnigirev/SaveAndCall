//
//  SVEVkAuthorizationService.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 28/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkAuthorizationService.h"
#import "SVEVkAuthorizationController.h"

static NSString *const SVEVkAuthorizationStringViaVkApp = @"vkauthorize://authorize";
static NSString *const SVEAppId = @"6337307";
static NSString *const SVEVkAuthorizationStringViaSafari = @"https://oauth.vk.com/authorize?client_id=6337307&revoke=1&scope=friends%2Cphotos&redirect_uri=vk6337307%3A%2F%2Fauthorize&response_type=token";

@implementation SVEVkAuthorizationService

//Проверака наличия приложения вк на устройстве
- (BOOL) vkAppExists
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:SVEVkAuthorizationStringViaVkApp]];
}
//Функция авторизации пользователя. Проверяет доступность приложения ВК на устройстве и авторизовывает пользователя.
//При отсутствии доступа к приложению авторизация через Safari.
- (void) authorize
{
    if ([self vkAppExists])
    {
        UIApplication *application = [UIApplication sharedApplication];
        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly: @NO};
        NSURL *url = [NSURL URLWithString:SVEVkAuthorizationStringViaVkApp];
        [application openURL:url options:options completionHandler:^(BOOL success) {
            if (!success)
            {
                NSLog(@"Vk authorization");
            }
        }];
    }
    else
    {
        NSURL *url = [NSURL URLWithString:SVEVkAuthorizationStringViaSafari];
        SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:url];
        [self.SVEVkAuthorizationController presentViewController:safariController animated:YES completion:nil];
    }
}

@end
