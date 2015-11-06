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

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getEmployeeInformation];
    
    delegate = [[UIApplication sharedApplication] delegate];
    employeeArray = [NSMutableArray new];
    
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
            NSLog(@"Data saved");
            NSError* error;
            employeeData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            employeeArray = [employeeData valueForKey:@"members"];
            [self saveData];
        }
        
    }];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)saveData {
    NSLog(@"Data Dictionary: %@", employeeData.description);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (int i = 0 ; i < [employeeArray count]; i++) {
        NSLog(@"Employee: %@", [[employeeArray objectAtIndex:i] description]);
        
    }
    for (int i = 0 ; i < [employeeArray count]; i++) {
        NSLog(@"Name: %@", [[employeeArray objectAtIndex:i] objectForKey:@"name"]);
        
    }
    // Create a new managed object
    NSManagedObject *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    // [newEmployee setValue:value forKey:@"name"];
    
//    [employeeData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//
//        [newEmployee setValue:[key objectForKey:@"name"] forKey:@"username"];
//    }];
    
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
