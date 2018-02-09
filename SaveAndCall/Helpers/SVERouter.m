//
//  SVERouter.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVERouter.h"
#import "SVEInterfaceBuilder.h"
#import "SVEUserDefaultsHelper.h"
#import <UIKit/UIKit.h>

static NSString *const SVEAppIsAuthorized = @"SVEAppIsAuthorized";
static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";
static NSString *const SVEContinueWithoutLogIn = @"SVEContinueWithoutLogIn";
static NSString *const SVEAppIsNotAuthorized = @"SVEAppIsNotAuthorized";

//Перечисление - состояние класса, зависит от того авторизован ли пользователь с помощью ВК.
typedef NS_ENUM(NSUInteger,SVECurrentRouterState)
{
    SVEAuthorizedState,
    SVENotAuthorizedState
};

@interface SVERouter ()

@property (nonatomic, assign) NSUInteger routerState;
@property (nonatomic, strong) SVEUserDefaultsHelper *userDefaultsHelper;

@end

@implementation SVERouter

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogged"] boolValue])
        {
            _routerState = SVENotAuthorizedState;
        }
        else
        {
            _routerState = SVEAuthorizedState;
        }
        _userDefaultsHelper = [[SVEUserDefaultsHelper alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(switchAuthorizationControllerToMain)
                                                     name:SVEAppIsAuthorized object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(switchMainControllerToAuthorization) name:SVEAppIsNotAuthorized object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(switchMainControllerToAuthorization) name:SVELogoutFromVk object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(switchAuthorizationControllerToMain) name:SVEContinueWithoutLogIn object:nil];
    }
    return self;
}
// Функция определения root контроллера. Если пользователь не авторизован, экран авторизации,
// иначе главный экран.
- (UIViewController *)defineViewController
{
    if (self.routerState == SVENotAuthorizedState)
    {
        return [SVEInterfaceBuilder buildAuthorizationController];
    }
    else
    {
        return [SVEInterfaceBuilder buildMainController];
    }
}

//Установка root контроллера
- (void)setDefinedViewController
{
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = [app windows].firstObject;
    window.rootViewController = [self defineViewController];
}

// Замена контроллеров. Происходит по нотификациям.
- (void)switchAuthorizationControllerToMain
{
    self.routerState = SVEAuthorizedState;
    [self setDefinedViewController];
}
// Замена контроллеров. Происходит по нотификациям.
- (void)switchMainControllerToAuthorization
{
    if ([SVEUserDefaultsHelper isLogged])
    {
        [self.userDefaultsHelper clearUserDefaults];
    }
    self.routerState = SVENotAuthorizedState;
    [self setDefinedViewController];
}


@end
