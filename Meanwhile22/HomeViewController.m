//
//  HomeViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/17/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "HomeViewController.h"
#import "M22HomeAnimationView.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet M22HomeAnimationView *homeAnimation;
@property (weak, nonatomic) IBOutlet UIButton *podcastButton;
@property (weak, nonatomic) IBOutlet UIButton *hostButton;

- (IBAction)podcastTapped:(id)sender;
- (IBAction)hostTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *twitterTapped;
@property (weak, nonatomic) IBOutlet UIButton *facebookTapped;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.homeAnimation.layer.borderWidth = 2.0;
    self.homeAnimation.layer.borderColor = [UIColor blackColor].CGColor;
    [self.homeAnimation addM22HomeAnimation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)podcastTapped:(id)sender {
}

- (IBAction)hostTapped:(id)sender {
}
@end
