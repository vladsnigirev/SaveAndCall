//
//  SVEVkFriendsNavigationController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 29/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkFriendsNavigationController.h"


@implementation SVEVkFriendsNavigationController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"VK";
    self.tabBarItem.image = [UIImage imageNamed:@"vk"];
}


@end
