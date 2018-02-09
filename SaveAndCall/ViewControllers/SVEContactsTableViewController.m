//
//  SVEContactsTableViewController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 29/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactsTableViewController.h"
#import "SVEContactsService.h"
#import "SVEContactsTableCell.h"
#import "SVEContactsProtocol.h"
#import "SVEContactModel.h"
#import "SVEParseHelper.h"
#import "SVEChangePhotoView.h"
#import "SVEChangeContactPhotoController.h"
#import "SVESharedDataProtocol.h"
#import "SVESharedData.h"

static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";
static NSString *reuseIdentifier = @"SVEContactTableViewCell";

@interface SVEContactsTableViewController () <SVEContactsProtocol, SVEFillSharedDataProtocol>

@property (nonatomic, strong) UIBarButtonItem *logoutButton;
@property (nonatomic, strong) UIBarButtonItem *sychronizeButton;
@property (nonatomic, strong) NSArray <SVEContactModel *> *contactsArray;
@property (nonatomic, strong) SVEContactsService *contactService;

@end

@implementation SVEContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtonItems];
    [self setupTableView];
    [self setupContactService];
    [self.contactService getContacts];
}

- (void)setupTableView
{
    [self.tableView registerClass:[SVEContactsTableCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupBarButtonItems
{
    self.logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.sychronizeButton = [[UIBarButtonItem alloc] initWithTitle:@"Sychronize" style:UIBarButtonItemStylePlain target:self action:@selector(synchronizeWithSharedData)];
    [self.navigationItem setRightBarButtonItems:@[self.sychronizeButton]];
    [self.navigationItem setLeftBarButtonItems:@[self.logoutButton]];
}

- (void)setupContactService
{
    self.contactService = [[SVEContactsService alloc] init];
    self.contactService.delegate = self;
}

- (void)logout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SVELogoutFromVk object:nil];
}

- (void)synchronizeWithSharedData
{
    /*self.contactsArray = [SVESharedData sharedData].contacts;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView performBatchUpdates:^{
        for (NSUInteger i = 0; i < self.contactsArray.count; i++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
    } completion:nil];
    });*/
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEContactsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    SVEContactModel *contact = self.contactsArray[indexPath.row];
    
    cell.firstNameLabel.text = contact.firstNameString;
    cell.lastNameLabel.text = contact.lastNameString;
    cell.profilePhotoImageView.image = [UIImage imageWithData:contact.imageData];
    [cell updateConstraints];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEChangeContactPhotoController *vc = [[SVEChangeContactPhotoController alloc] init];
    vc.contactsArray = self.contactsArray;
    vc.index = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SVEContactsProtocol
//Приходит массив контактов - SVEParseHelper разбирает его и присваевает contactsArray равным массиву моделей
- (void)gotContactsWithArray:(NSArray *)contactsArray
{
    self.contactsArray = [SVEParseHelper parseContactsArray:contactsArray];
    [self fillSharedDataWithContactsArray:self.contactsArray];
}


#pragma mark - Shared Data Protocol

- (void)fillSharedDataWithContactsArray:(NSArray *)contactsArray
{
    [SVESharedData sharedData].contacts = contactsArray;
}

@end
