//
//  SVEVkTableViewController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 29/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkTableViewController.h"
#import "SVEVkTableCell.h"
#import "SVENetworkServiceProtocol.h"
#import "SVENetworkService.h"
#import "SVEParseHelper.h"
#import "SVEFriendModel.h"
#import "SVESharedDataProtocol.h"
#import "SVESharedData.h"

static NSString *reuseIdentifier = @"VkTableCell";
static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";

@interface SVEVkTableViewController () <SVENetworkServiceProtocol,SVEFillSharedDataProtocol>

@property (nonatomic, strong) UIBarButtonItem *logoutButton;
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) SVENetworkService *networkService;


@end

@implementation SVEVkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtons];
    [self setupTableView];
    [self setupNetworkService];
    [self.networkService getFriends];
}

- (void)setupTableView
{
    [self.tableView registerClass:[SVEVkTableCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupBarButtons
{
    self.logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    [self.navigationItem setLeftBarButtonItems:@[self.logoutButton]];
}

- (void)logout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SVELogoutFromVk object:nil];
}

-(void) setupNetworkService
{
    self.networkService = [[SVENetworkService alloc] init];
    self.networkService.delegate = self;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsArray.count;
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEVkTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    SVEFriendModel *friend = self.friendsArray[indexPath.row];
    
    cell.firstNameLabel.text = friend.firstNameString;
    cell.lastNameLabel.text = friend.lastNameString;
    
    __block UIImage *image;
    [cell updateConstraints];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:friend.photo_100_Url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.profilePhotoImageView.image = image;
        });
    });
    return cell;
}


#pragma mark - Network Service Protocol

- (void)loadingIsDoneWithDataReceived:(NSData *)data
{
    if (!data)
    {
        //что-то пошло не так. Вызвать функцию заполняющаю таблицу друзей из кордаты.
        return;
    }
    self.friendsArray = [SVEParseHelper parseVkFriendsFromData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView performBatchUpdates:^{
            for (NSUInteger i = 0; i < self.friendsArray.count; i++)
            {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        } completion:nil];
    });
    [self fillSharedDataWithFriendsArray:self.friendsArray];
}


#pragma mark - Shared Data Protocol

- (void)fillSharedDataWithFriendsArray:(NSArray *)friendsArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (SVEFriendModel *friend in friendsArray)
    {
        if (friend.telNumberString)
        {
            if (friend.telNumberString.length == 10 || friend.telNumberString.length == 11)
            {
                friend.telNumberString = [[friend.telNumberString componentsSeparatedByCharactersInSet:
                                       [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                      componentsJoinedByString:@""];
                [tempArray addObject:friend];
            }
        }
    }
    [SVESharedData sharedData].vkFriendsWithTels = [tempArray copy];
}

@end
