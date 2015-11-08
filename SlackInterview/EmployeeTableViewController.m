//
//  EmployeeTableViewController.m
//  SlackInterview
//
//  Created by Ember Baker on 11/5/15.
//  Copyright (c) 2015 Ember Baker. All rights reserved.
//

#import "EmployeeTableViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface EmployeeTableViewController ()

@end

@implementation EmployeeTableViewController{
    NSString *token;
    AppDelegate *delegate;
    NSArray *fetchedEmployees;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    delegate = [[UIApplication sharedApplication] delegate];

    [self fetchEmployees];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(fetchEmployees)
                  forControlEvents:UIControlEventValueChanged];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [fetchedEmployees count];
}

-(void)fetchEmployees {
    [self.tableView reloadData];

    NSError *error;
    NSManagedObjectContext *context = [delegate managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    fetchedEmployees = fetchedObjects;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"employeeResuableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.clipsToBounds = NO;
    cell.imageView.image = [UIImage imageWithData:[[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"thumbnail"]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"username"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    
    [detailViewController setName:[[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"realName"]];
    [detailViewController setProfile:[UIImage imageWithData:[[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"thumbnail"]]];
    [detailViewController setTitleString:[[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"title"]];
    [detailViewController setPhone:[[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"phone"]];
    [detailViewController setSkype:[[fetchedEmployees objectAtIndex:indexPath.row] valueForKey:@"skype"]];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}
*/

@end
