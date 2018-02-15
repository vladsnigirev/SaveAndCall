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
#import "SVEContactRepresentation.h"
#import "SVEChangePhotoView.h"
#import "SVEChangeContactPhotoController.h"
#import "SVEContactsModel.h"
#import "AppDelegate.h"
#import "SVESynchronizationService.h"

static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";
static NSString *reuseIdentifier = @"SVEContactTableViewCell";
static CGFloat SVERefreshContactsTime = 1;

@interface SVEContactsTableViewController () <SVEContactsProtocol>

@property (nonatomic, strong) UIBarButtonItem *sychronizeButton;
@property (nonatomic, strong) NSArray <SVEContactRepresentation *> *contactsArray;
@property (nonatomic, strong) SVEContactsService *contactService;
@property (nonatomic, strong) SVEContactsModel *model;
@property (nonatomic, strong) SVESynchronizationService *synchronizedService;

@end

@implementation SVEContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtonItems];
    [self setupTableView];
    [self setupContactService];
    AppDelegate *a = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.model = a.contactsModel;
//    self.synchronizedService = [[SVESynchronizationService alloc] init];
    [self.contactService getContacts];
}

- (void)setupTableView
{
    [self.tableView registerClass:[SVEContactsTableCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupBarButtonItems
{
    self.sychronizeButton = [[UIBarButtonItem alloc] initWithTitle:@"Sychronize" style:UIBarButtonItemStylePlain target:self action:@selector(synchronize)];
    [self.navigationItem setRightBarButtonItems:@[self.sychronizeButton]];
}

- (void)setupContactService
{
    self.contactService = [[SVEContactsService alloc] init];
    self.contactService.delegate = self;
}

- (void)synchronize
{
    self.synchronizedService = [[SVESynchronizationService alloc] init];
    [self.synchronizedService synchronizeContactsWithfriends];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
    dispatch_time_t refreshTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)SVERefreshContactsTime * NSEC_PER_SEC);
    dispatch_after(refreshTime, dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
        {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEContactsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[SVEContactsTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    SVEContactRepresentation *contact = self.model.contacts[indexPath.row];
    cell = [cell configureCell:cell withContact:contact];
    [cell updateConstraints];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Your Contacts"];
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
    [self.model configureModelWithContactsArray:contactsArray];
}



@end
