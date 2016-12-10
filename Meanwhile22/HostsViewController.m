//
//  HostsViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/26/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "HostsViewController.h"
#import "M22HostsAnimationView.h"
#import "MethodsCache.h"

@interface HostsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *pageAccent;
@property (weak, nonatomic) IBOutlet M22HostsAnimationView *hostsAnimation;
@property (weak, nonatomic) IBOutlet UIButton *capButton;
@property (weak, nonatomic) IBOutlet UIButton *mfgButton;
@property (weak, nonatomic) IBOutlet UIButton *ralfButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)capTapped:(id)sender;
- (IBAction)mfgTapped:(id)sender;
- (IBAction)ralfTapped:(id)sender;
- (IBAction)previousTapped:(id)sender;


@end

@implementation HostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper C lite"];
    self.pageAccent.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self viewArray]];
    
    [self.hostsAnimation addM22HostsAnimation];
    
    [self.capButton setBackgroundImage:[UIImage imageNamed:@"cap button"] forState:UIControlStateNormal];
    [self.mfgButton setBackgroundImage:[UIImage imageNamed:@"mfg button"] forState:UIControlStateNormal];
    [self.ralfButton setBackgroundImage:[UIImage imageNamed:@"ralf button"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Arrays

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.capButton, self.mfgButton, self.ralfButton, self.previousButton];
    return buttons;
}

-(NSArray *)viewArray
{
    NSArray *views = @[self.hostsAnimation];
    return views;
}

#pragma mark - Buttons

- (IBAction)capTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"HostSaved"];
    [self.hostsAnimation removeM22HostsAnimation];
}

- (IBAction)mfgTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"HostSaved"];
    [self.hostsAnimation removeM22HostsAnimation];
}

- (IBAction)ralfTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:3 forKey:@"HostSaved"];
    [self.hostsAnimation removeM22HostsAnimation];
}

- (IBAction)previousTapped:(id)sender
{
    [self performSegueWithIdentifier:@"unwindHostsSegue" sender:self];
    [self.hostsAnimation removeM22HostsAnimation];
}

//The buttons above stop the looping animation once user has left the page. Otherwise, it runs behind the scene
//The unwind segue is used to restart the animation
-(IBAction)returnToHostsVC:(UIStoryboardSegue *)unwindBios
{
    [self.hostsAnimation addM22HostsAnimation];
}











@end
