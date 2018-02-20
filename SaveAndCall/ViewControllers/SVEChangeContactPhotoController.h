//
//  SVEChangeContactPhotoController.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 02/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVEContactModel;
@interface SVEChangeContactPhotoController : UIViewController

@property (nonatomic, weak) NSArray <SVEContactModel *> *contactsArray;
@property (nonatomic, assign) NSUInteger index;

@end