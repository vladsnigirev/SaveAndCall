//
//  SVERouter.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVERouter.h"
#import "SVEInterfaceBuilder.h"
#import <UIKit/UIKit.h>
#import "SVEModelCleanerProtocol.h"
#import "AppDelegate.h"


static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";
static NSString *const SVEContinueWithoutLogIn = @"SVEContinueWithoutLogIn";


//Перечисление - состояние класса, зависит от того авторизован ли пользователь с помощью ВК.
typedef NS_ENUM(NSUInteger,SVECurrentRouterState)
{
    SVEAuthorizedState,
    SVENotAuthorizedState
};


@interface SVERouter () <SVEModelCleanerProtocol>


@property (nonatomic, assign) NSUInteger routerState;


@end

@implementation SVERouter


#pragma mark - Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(switchAuthorizationControllerToMain)
                                              name:SVEContinueWithoutLogIn object:nil];
    }
    return self;
}


#pragma mark - Public

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
    [UIView transitionWithView:window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
        window.rootViewController = [self defineViewController];
    } completion:nil];
}


#pragma mark - SVERouterProtocol

// Замена контроллеров.
- (void)switchAuthorizationControllerToMain
{
    self.routerState = SVEAuthorizedState;
    [self clearModels];
    [self setDefinedViewController];
}
// Замена контроллеров.
- (void)switchMainControllerToAuthorization
{
    self.routerState = SVENotAuthorizedState;
    [self clearModels];
    [self setDefinedViewController];
}


#pragma mark - SVEModelCleanerProtocol

- (void)clearModels
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.vkModel.vkFriends = nil;
    appDelegate.contactsModel.contacts = nil;
}


@end
