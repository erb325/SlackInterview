//
//  ViewController.m
//  SlackInterview
//
//  Created by Ember Baker on 11/5/15.
//  Copyright (c) 2015 Ember Baker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nameLabel = _nameLabel;
@synthesize titleLabel = _titleLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize skypeLabel = _skypeLabel;
@synthesize profileView = _profileView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _nameLabel.text = nameString;
    _titleLabel.text = titleString;
    _phoneLabel.text = phoneString;
    _skypeLabel.text = skypeString;
    _profileView.image = profileImage;
    
}
-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setName:(NSString *)text {
    nameString = text;
}
-(void)setTitleString:(NSString *)text{
    titleString = text;
}
-(void)setPhone:(NSString *)text{
    phoneString = text;
}
-(void)setSkype:(NSString *)text{
    skypeString = text;
}
-(void)setProfile:(UIImage *)image{
    profileImage = image;
}
@end
