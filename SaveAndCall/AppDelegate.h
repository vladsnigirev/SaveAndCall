//
//  AppDelegate.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 27/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SVETokenService.h"
#import "SVEVkModel.h"
#import "SVEContactsModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) SVETokenService *tokenService;

@property (nonatomic, strong) SVEVkModel * vkModel;

@property (nonatomic, strong) SVEContactsModel* contactsModel;

- (void)saveContext;


@end

