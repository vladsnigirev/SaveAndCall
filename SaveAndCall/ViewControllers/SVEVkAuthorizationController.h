//
//  SVEVkAuthorizationController.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 27/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>
#import "SVELogoutProtocol.h"


@interface SVEVkAuthorizationController : UIViewController <SFSafariViewControllerDelegate, SVELogoutProtocol>


@end
