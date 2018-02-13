//
//  SVEContactModel.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CNContact;
@interface SVEContactModel : NSObject

@property (nonatomic, readonly) NSString *firstNameString;
@property (nonatomic, readonly) NSString *lastNameString;
@property (nonatomic, readonly) NSArray *phonesArray;
@property (nonatomic, strong) NSData *imageData;

- (instancetype)initWithContact:(CNContact *)contact;

@end
