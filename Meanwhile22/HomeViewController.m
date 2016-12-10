//
//  HomeViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/17/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "HomeViewController.h"
#import "M22HomeAnimationView.h"
#import "MethodsCache.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet M22HomeAnimationView *homeAnimation;
@property (weak, nonatomic) IBOutlet UIButton *podcastButton;
@property (weak, nonatomic) IBOutlet UIButton *hostButton;

- (IBAction)podcastTapped:(id)sender;
- (IBAction)hostTapped:(id)sender;
- (IBAction)twitterTapped:(id)sender;
- (IBAction)facebookTapped:(id)sender;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper B lite"];
    
    [self.homeAnimation addM22HomeAnimation];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self viewArray]];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    
    [self.podcastButton setBackgroundImage:[UIImage imageNamed:@"vault button"] forState:UIControlStateNormal];
    [self.hostButton setBackgroundImage:[UIImage imageNamed:@"host button"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Arrays

-(NSArray *)viewArray
{
    NSArray *views = @[self.homeAnimation];
    return views;
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.podcastButton, self.hostButton];
    return buttons;
}

#pragma mark - Buttons

- (IBAction)podcastTapped:(id)sender
{
    [self.homeAnimation removeM22HomeAnimation];
}

- (IBAction)hostTapped:(id)sender
{
    [self.homeAnimation removeM22HomeAnimation];
}

- (IBAction)twitterTapped:(id)sender
{
    //openURL was deprecated in iOS10.0
    //openURL: options: completionHandler requires NSURL, NSDictionary (for "options", if no options use  blank dictionary), and completionHandler (if none, use nil)
    NSURL *twitterURL = [NSURL URLWithString:@"https://twitter.com/hashtag/meanwhile22pageslater"];
    [[UIApplication sharedApplication] openURL:twitterURL
                                       options:@{}
                             completionHandler:nil];
}

- (IBAction)facebookTapped:(id)sender
{
    //openURL was deprecated in iOS10.0
    //openURL: options: completionHandler requires NSURL, NSDictionary (for "options", if no options use  blank dictionary), and completionHandler (if none, use nil)
    NSURL *fbURL = [NSURL URLWithString:@"https://www.facebook.com/meanwhille22pageslater/"];
    [[UIApplication sharedApplication] openURL:fbURL
                                       options:@{}
                             completionHandler:nil];
}

//The "podcast" and "host" buttons stop the looping animation once user has left the page. Otherwise, it runs behind the scene
//The unwind segue is used to restart the animation
-(IBAction)returnToHomeVC:(UIStoryboardSegue *)unwindEpisode
{
    [self.homeAnimation addM22HomeAnimation];
}











@end
