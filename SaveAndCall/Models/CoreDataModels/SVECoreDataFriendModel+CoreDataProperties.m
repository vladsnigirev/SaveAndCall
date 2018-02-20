//
//  SVECoreDataFriendModel+CoreDataProperties.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 13/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//
//

#import "SVECoreDataFriendModel+CoreDataProperties.h"

@implementation SVECoreDataFriendModel (CoreDataProperties)


+ (NSFetchRequest<SVECoreDataFriendModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SVECoreDataFriendModel"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic phoneNumber;


@end
