//
//  SVEVkAuthorizationService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 28/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVEVkAuthorizationController;
@interface SVEVkAuthorizationService : NSObject
//мбпротокол
@property (nonatomic, weak) SVEVkAuthorizationController *SVEVkAuthorizationController;

- (void)authorize;

@end
