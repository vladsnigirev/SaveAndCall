//
//  SVERouter.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVERouterProtocol.h"


//Router отвечает за смену root controller
@class UIViewController;
@interface SVERouter : NSObject<SVERouterProtocol>


- (UIViewController *)defineViewController;
- (void)setDefinedViewController;


@end
