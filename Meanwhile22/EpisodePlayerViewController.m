//
//  EpisodePlayerViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/23/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "EpisodePlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PodcastParser.h"
#import "MethodsCache.h"

@interface EpisodePlayerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *pageAccent;

@property (weak, nonatomic) IBOutlet UIView *timeContainer;
@property (weak, nonatomic) IBOutlet UILabel *elapsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *soFarLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

@property AVPlayerViewController *videoPlayerController;
@property AVPlayerItem *playerItem;
@property AVPlayer *player;
@property NSTimer *elapsedTimer;
@property NSTimer *remainingTimer;
@property NSTimer *sliderTimer;
@property BOOL isScrubbing;

- (IBAction)pauseTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)minusTapped:(id)sender;
- (IBAction)plusTapped:(id)sender;
- (IBAction)playTapped:(id)sender;
- (IBAction)previousTapped:(id)sender;


@end

@implementation EpisodePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MethodsCache *methods = [MethodsCache new];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self viewArray]];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    [methods createLabelBorderWidth:2.0 color:[UIColor blackColor] forArray:[self labelArray]];
    
    self.titleLabel.text = self.episodeTitle;
    self.summaryLabel.text = [NSString stringWithFormat:@"\n%@", self.episode.itunesSummary];
    NSLog(@"%@", self.episode.itunesSummary);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)viewArray
{
    NSArray *views = @[self.timeContainer, self.bottomContainer];
    return views;
}

-(NSArray *)labelArray
{
    NSArray *labels = @[self.soFarLabel];
    return labels;
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.pauseButton, self.stopButton, self.minusButton, self.plusButton, self.playButton, self.previousButton];
    return buttons;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pauseTapped:(id)sender
{
    
}

- (IBAction)stopTapped:(id)sender
{
    
}

- (IBAction)minusTapped:(id)sender
{
    
}

- (IBAction)plusTapped:(id)sender
{
    
}

- (IBAction)playTapped:(id)sender
{
    
}

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
















@end
