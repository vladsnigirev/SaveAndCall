//
//  SVEInterfaceBuilder.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 04/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SVEInterfaceBuilder.h"
#import "SVEVkAuthorizationController.h"
#import "SVEVkFriendsNavigationController.h"
#import "SVEVkTableViewController.h"
#import "SVEContactsNavigationController.h"
#import "SVEContactsTableViewController.h"
#import "SVETabBarController.h"


/*Класс для сборки интерфейсa в зависимости от ситуации.*/
@implementation SVEInterfaceBuilder


#pragma mark - Public

+ (UIViewController *)buildMainController
{
     SVEVkFriendsNavigationController *sveVkFriendsViewController = [[SVEVkFriendsNavigationController alloc]
                                                                     initWithRootViewController:[[SVEVkTableViewController alloc]
                                                                                                 init]];
     
     SVEContactsNavigationController *sveContactsNavigationController = [[SVEContactsNavigationController alloc]
                                                                         initWithRootViewController:[[SVEContactsTableViewController alloc]
                                                                                                     initWithStyle:UITableViewStyleGrouped]];
     
     SVETabBarController *sveTabBarViewController =[[SVETabBarController alloc] init];
     
     sveTabBarViewController.viewControllers = @[sveVkFriendsViewController, sveContactsNavigationController];
    
    return sveTabBarViewController;
}

+ (UIViewController *)buildAuthorizationController
{
    SVEVkAuthorizationController *sveVkAuthorizationController = [[SVEVkAuthorizationController alloc] init];
    return sveVkAuthorizationController;
}


@end
