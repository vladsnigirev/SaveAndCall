//
//  SVEContactModel.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVEContactModel : NSObject

@property (nonatomic, strong) NSString *firstNameString;
@property (nonatomic, strong) NSString *lastNameString;
@property (nonatomic, strong) NSArray *phonesArray;
@property (nonatomic, strong) NSData *imageData;

@end
