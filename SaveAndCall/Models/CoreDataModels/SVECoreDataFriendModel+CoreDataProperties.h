//
//  SVECoreDataFriendModel+CoreDataProperties.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 13/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//
//

#import "SVECoreDataFriendModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SVECoreDataFriendModel (CoreDataProperties)

+ (NSFetchRequest<SVECoreDataFriendModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *phoneNumber;

@end

NS_ASSUME_NONNULL_END
