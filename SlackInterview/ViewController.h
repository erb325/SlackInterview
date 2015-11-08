//
//  ViewController.h
//  SlackInterview
//
//  Created by Ember Baker on 11/5/15.
//  Copyright (c) 2015 Ember Baker. All rights reserved.
//

#import "EmployeeTableViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSString *nameString;
    NSString *titleString;
    NSString *phoneString;
    NSString *skypeString;
    UIImage *profileImage;
}

@property (nonatomic, strong) NSMutableArray *employee;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *skypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;


-(void)setName:(NSString *)text;
-(void)setTitleString:(NSString *)text;
-(void)setPhone:(NSString *)text;
-(void)setSkype:(NSString *)text;
-(void)setProfile:(UIImage *)image;



@end

