//
//  SVEContactsNavigationController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 29/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactsNavigationController.h"


@implementation SVEContactsNavigationController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"Contacts";
    self.tabBarItem.image = [UIImage imageNamed:@"contacts"];
}


@end
