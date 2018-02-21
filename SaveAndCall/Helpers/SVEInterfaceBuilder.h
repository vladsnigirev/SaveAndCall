//
//  SVEInterfaceBuilder.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 04/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UIViewController;

@interface SVEInterfaceBuilder : NSObject


+ (UIViewController *)buildMainController;
+ (UIViewController *)buildAuthorizationController;


@end
