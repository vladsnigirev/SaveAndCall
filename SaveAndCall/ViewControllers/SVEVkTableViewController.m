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
#import "SVEFriendRepresentation.h"
#import "AppDelegate.h"
#import "SVECoreDataService.h"
#import "SVEVkModel.h"

static NSString *reuseIdentifier = @"VkTableCell";
static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";

@interface SVEVkTableViewController () <SVENetworkServiceProtocol>

@property (nonatomic, strong) UIBarButtonItem *logoutButton;
@property (nonatomic, strong) SVENetworkService *networkService;
@property (nonatomic, strong) SVECoreDataService *coreDataService;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) SVETokenService *tokenService;
@property (nonatomic, strong) SVEVkModel *model;

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
    self.coreDataService = [[SVECoreDataService alloc] init];
    [self setupRefreshControl];
    [self.refreshControl beginRefreshing];
    AppDelegate *a = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    a.tokenService.delegate = self;
    self.model = a.vkModel;
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
    self.model.vkFriends = nil;
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
    return [self.model countOfVkFriends];
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEVkTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[SVEVkTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    SVEFriendRepresentation *friend = self.model.vkFriends[indexPath.row];
    cell = [cell configureCell:cell withFriend:friend];
    [cell updateConstraints];
    return cell;
}


#pragma mark - Network Service Protocol

- (void)loadingIsDoneWithDataReceived:(NSData *)data
{
    [self.model configureModelWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (SVEFriendRepresentation *friend in self.model.vkFriends)
            {
                friend.photo_100_image = [self.networkService downloadImageByURL:friend.photo_100_Url];
            }
        });
        [self.tableView performBatchUpdates:^{
            for (NSUInteger i = 0; i < [self.model countOfVkFriends]; i++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            [self.refreshControl endRefreshing];
        } completion:nil];
    });
}

@end
