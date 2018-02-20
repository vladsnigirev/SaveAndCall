//
//  SVECoreDataService.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 13/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVECoreDataService.h"
#import "AppDelegate.h"
#import "SVEFriendRepresentation.h"
#import "SVECoreDataFriendModel+CoreDataClass.h"


@interface SVECoreDataService ()


@property (nonatomic, strong) NSManagedObjectContext *context;


@end


@implementation SVECoreDataService


#pragma mark - Custom Accessors

- (NSManagedObjectContext *)context
{
    if (_context)
    {
        return _context;
    }
    NSManagedObjectContext *context;
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer* container = ((AppDelegate *)(application.delegate)).persistentContainer;
    context = container.viewContext;
    return context;
}


#pragma mark - Public

- (void)saveFriends;
{
    [self clearCoreData];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    for (SVEFriendRepresentation *friend in appDelegate.vkModel.vkFriends)
    {
                SVECoreDataFriendModel *coreDataFriend = [NSEntityDescription insertNewObjectForEntityForName:@"SVECoreDataFriendModel"
                                                                                       inManagedObjectContext:self.context];
                coreDataFriend.firstName = friend.firstNameString;
                coreDataFriend.lastName = friend.lastNameString;
                coreDataFriend.phoneNumber = friend.phoneNumberString;
                [self.context save:nil];
    }
}

- (NSArray *)friendsFromCoreData
{
    NSArray *result = [self.context executeFetchRequest:[SVECoreDataFriendModel fetchRequest] error:nil];
    NSMutableArray *friendArray = [NSMutableArray array];
    for (SVECoreDataFriendModel *coreDataFriend in result)
    {
        SVEFriendRepresentation *friend = [[SVEFriendRepresentation alloc] initWithCoreData:coreDataFriend];
        [friendArray addObject:friend];
    }
    return [friendArray copy];
}


#pragma mark - Private

- (void)clearCoreData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"SVECoreDataFriendModel"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    [self.context.persistentStoreCoordinator executeRequest:delete withContext:self.context error:nil];
}

@end
