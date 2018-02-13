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
#import "AppDelegate.h"

static NSString *reuseIdentifier = @"VkTableCell";
static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";

@interface SVEVkTableViewController () <SVENetworkServiceProtocol, SVEFillSharedDataProtocol>

@property (nonatomic, strong) UIBarButtonItem *logoutButton;
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) SVENetworkService *networkService;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, weak) SVETokenService *tokenService;

@end

@implementation SVEVkTableViewController
@dynamic refreshControl;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtons];
    [self setupTableView];
    [self setupNetworkService];
    [self setupRefreshControl];
    [self.refreshControl beginRefreshing];
    AppDelegate *a = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    a.tokenService.delegate = self;
    self.tokenService = a.tokenService;
    [self.networkService getFriends];
}

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshFriends) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
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

- (void)refreshFriends
{
    self.friendsArray = nil;
    [self.tableView reloadData];
    [self.networkService getFriends];
}

- (void)logout
{
    [self.tokenService clearUserDefaults];
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
    
    if (!cell)
    {
        cell = [[SVEVkTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    SVEFriendModel *friend = self.friendsArray[indexPath.row];
    
    cell = [cell configureCell:cell withFriend:friend];
    [cell updateConstraints];
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
    __block UIImage *image;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) , ^{
        for (SVEFriendModel *friend in self.friendsArray)
        {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:friend.photo_100_Url]];
            friend.photo_100_image = image;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView performBatchUpdates:^{
                for (NSUInteger i = 0; i < self.friendsArray.count; i++)
                {
                    @autoreleasepool
                    {
                        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    }
                }
                [self.refreshControl endRefreshing];
            } completion:nil];
        });
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
