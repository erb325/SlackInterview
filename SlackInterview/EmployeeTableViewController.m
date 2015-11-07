//
//  EmployeeTableViewController.m
//  SlackInterview
//
//  Created by Ember Baker on 11/5/15.
//  Copyright (c) 2015 Ember Baker. All rights reserved.
//

#import "EmployeeTableViewController.h"
#import "AppDelegate.h"

@interface EmployeeTableViewController ()

@end

@implementation EmployeeTableViewController{
    NSString *token;
    NSDictionary *employeeData;
    AppDelegate *delegate;
    NSMutableArray *employeeArray;
    NSArray *fetchedEmployees;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = [[UIApplication sharedApplication] delegate];
    employeeArray = [NSMutableArray new];
    
    [self getEmployeeInformation];
    
    fetchedEmployees = [self fetchEmployees];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}
-(void)getEmployeeInformation {
    NSString *requestURL = @"https://slack.com/api/users.list?token=xoxp-4698769766-4698769768-4898023905-7a1afa";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            NSError* error;
            employeeData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            employeeArray = [employeeData valueForKey:@"members"];
            [self saveData];
        }
        
    }];
}


-(void)saveData {
    // Create a new managed object
   
    
    NSLog(@"Employee Array  %@", employeeArray);

    for (int i = 0 ; i < [employeeArray count]; i++) {
        NSManagedObjectContext *context = [delegate managedObjectContext];

        NSManagedObject *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
        NSError *error = nil;
        [newEmployee setValue:[[employeeArray objectAtIndex:i] objectForKey:@"name"] forKey:@"username"];
        [newEmployee setValue:[[employeeArray objectAtIndex:i] objectForKey:@"real_name"] forKey:@"realName"];
        [newEmployee setValue:[[[employeeArray objectAtIndex:i] objectForKey:@"profile"] objectForKey:@"title"] forKey:@"title"];
        [newEmployee setValue:[[[employeeArray objectAtIndex:i] objectForKey:@"profile"] objectForKey:@"phone"] forKey:@"phone"];
        [newEmployee setValue:[[[employeeArray objectAtIndex:i] objectForKey:@"profile"]objectForKey:@"skype"] forKey:@"skype"];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[[employeeArray objectAtIndex:i]
                                                                                         objectForKey:@"profile"]objectForKey:@"image_72"]]];
        [newEmployee setValue:imageData forKey:@"thumbnail"];

        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    
    
   
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

-(NSArray *)fetchEmployees {
    NSError *error;
    NSManagedObjectContext *context = [delegate managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
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
