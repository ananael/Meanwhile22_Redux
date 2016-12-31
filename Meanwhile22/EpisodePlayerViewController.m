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
#import "M22PlayerOrbAnimationView.h"
#import "MethodsCache.h"

@interface EpisodePlayerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *pageAccent;
@property (weak, nonatomic) IBOutlet M22PlayerOrbAnimationView *playerAnimation;
@property (weak, nonatomic) IBOutlet UISlider *slider;
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
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper A lite"];
    self.pageAccent.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    [self.playerAnimation addM22PlayerOrbAnimation];
    
    [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"pause button"] forState:UIControlStateNormal];
    [self.stopButton setBackgroundImage:[UIImage imageNamed:@"stop button"] forState:UIControlStateNormal];
    [self.minusButton setBackgroundImage:[UIImage imageNamed:@"minus button"] forState:UIControlStateNormal];
    [self.plusButton setBackgroundImage:[UIImage imageNamed:@"plus button"] forState:UIControlStateNormal];
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"play button"] forState:UIControlStateNormal];
    
    
    MethodsCache *methods = [MethodsCache new];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self viewArray1]];
    [methods createViewBorderWidth:1.0 color:[UIColor blackColor] forArray:[self viewArray2]];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    [methods createLabelBorderWidth:1.0 color:[UIColor blackColor] forArray:[self labelArray]];
    
    self.titleLabel.text = self.episodeTitle;
    self.summaryLabel.text = [NSString stringWithFormat:@"\n%@", self.episode.itunesSummary];
    NSLog(@"%@", self.episode.itunesSummary);
    
    //This code is needed when the app is run for the first time (or re-installed)
    //Because it handles the situation when there is no savedProgress
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"savedProgress"])
    {
        //NSLog(@"Brand new Launch !!");
        
        NSURL *episodeURL = [NSURL URLWithString:self.episode.podcastURL];
        self.playerItem = [[AVPlayerItem alloc]initWithURL:episodeURL];
        self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
        
        [self.player play];
    }
    
    //If there is savedProgress (and the same podcast url is choen), the audio begins where it left off
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"savedProgress"])
    {
        NSString *savedUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"savedPodcast"];
        NSInteger savedSeconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedTime"];
        CMTime storedTime = CMTimeMake(savedSeconds, 1);
        
        //NSLog(@"Stored Time: %ld", (long)savedSeconds);
        
        if ([savedUrl isEqualToString:self.episode.podcastURL])
        {
            //NSLog(@"PODCAST MATCH !!");
            
            NSURL *episodeURL = [NSURL URLWithString:savedUrl];
            self.playerItem = [[AVPlayerItem alloc]initWithURL:episodeURL];
            self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
            
            [self.player seekToTime:storedTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
            
            [self.player play];
            
        } else
        {
            //NSLog(@"NOPE. DIFFERENT PODCASTS!");
            
            //This routine starts if the player has been previously used but a different podcast is chosen
            NSURL *episodeURL = [NSURL URLWithString:self.episode.podcastURL];
            self.playerItem = [[AVPlayerItem alloc]initWithURL:episodeURL];
            self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
            
            [self.player play];
        }
    };
    
    //relates to the time labels
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    
    self.elapsedTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                         target:self
                                                       selector:@selector(displayTimeElapsed)
                                                       userInfo:nil
                                                        repeats:YES];
    
    self.remainingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                           target:self
                                                         selector:@selector(displayTimeRemaining)
                                                         userInfo:nil
                                                          repeats:YES];
    
    [self.slider setThumbImage:[UIImage imageNamed:@"blue rocket"] forState:UIControlStateNormal];
    
    //Sets slider max value to audio duration
    self.slider.maximumValue = [self formattedTimeFromString:self.episode.itunesDuration];
    self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                        target:self
                                                      selector:@selector(updateSlider)
                                                      userInfo:nil
                                                       repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Arrays

-(NSArray *)viewArray1
{
    NSArray *views = @[self.timeContainer, self.bottomContainer];
    return views;
}

-(NSArray *)viewArray2
{
    NSArray *views = @[self.pageAccent];
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

// *** Shown in elapsedTimeLabel ***
- (void)displayTimeElapsed
{
    NSInteger dur = CMTimeGetSeconds([self.player currentTime]);
    
    NSString *currentTime = [self formattedTime:dur];
    self.elapsedLabel.text = currentTime;
}

#pragma mark - Label Formatting

// *** Shown in durationLabel ***
-(void)displayTimeRemaining
{
    NSInteger dur = CMTimeGetSeconds([self.player currentTime]);
    //NSInteger remaining = (self.episode.itunesDuration - dur);
    NSInteger remaining = ([self formattedTimeFromString:self.episode.itunesDuration] - dur);
    
    NSString *remainingTime = [self formattedTime:remaining];
    self.remainingLabel.text = remainingTime;
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    [self.elapsedTimer invalidate];
    self.elapsedTimer = nil;
    
    [self.player seekToTime:kCMTimeZero];
    [self.playerAnimation removeM22PlayerOrbAnimation];
}

#pragma mark - Player Formatting

//Use if the parsed duration is in seconds
- (NSString *)formattedTime:(NSInteger)duration
{
    //Asks player for current time
    //The number returned is actually a double, but this stores it as an NSUinteger
    
    NSInteger time = duration;
    
    NSInteger hours = (time/3600);
    NSInteger minutes = (time/60) % 60;
    NSInteger seconds = time % 60;
    
    NSString *format = @"%02i:%02i:%02i";
    
    return [NSString stringWithFormat:format, hours, minutes, seconds];
}

//Use if the parsed duration is in hours/minutes/seconds
- (NSInteger)formattedTimeFromString:(NSString *)duration
{
    
    NSString *timeString = duration;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    NSDate *timeDate = [formatter dateFromString:timeString];
    
    formatter.dateFormat = @"hh";
    NSInteger hours;
    //Resolves the issue of "hh" value of "00" converting to 12 hours
    if ([[formatter stringFromDate:timeDate] intValue] == 12)
    {
        hours = 0;
    } else
    {
        hours = [[formatter stringFromDate:timeDate] intValue];
    }
    formatter.dateFormat = @"mm";
    NSInteger minutes = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat = @"ss";
    NSInteger seconds = [[formatter stringFromDate:timeDate] intValue];
    
    NSInteger timeInSeconds = seconds + (minutes * 60) + (hours * 3600);
    return timeInSeconds;
}

#pragma mark - Player Controls

-(void)updateSlider
{
    NSInteger dur = CMTimeGetSeconds([self.player currentTime]);
    self.slider.value = dur;
}

- (IBAction)sliderActivated:(id)sender
{
    [self.player pause];
    CMTime newTime = CMTimeMakeWithSeconds(self.slider.value, 1);
    [self.player seekToTime:newTime];
    
    //Ths code smooths the slider action by delaying play action until the streaming is ready
    [self.player prerollAtRate:1.0 completionHandler:^(BOOL finished) {
        if (finished) {
            [self.player play];
        }
    }];
}

#pragma mark - Buttons

- (IBAction)pauseTapped:(id)sender
{
    [self.player pause];
    [self.playerAnimation removeM22PlayerOrbAnimation];
    //Extra "savedProgress" location, in case user pauses then closes app without engaging "previous" button
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger seconds = CMTimeGetSeconds([self.player currentTime]);
    [defaults setBool:YES forKey:@"savedProgress"];
    [defaults setObject:self.episode.podcastURL forKey:@"savedPodcast"];
    [defaults setInteger:seconds forKey:@"savedTime"];
    //NSLog(@"Show the current PAUSE time: %f", CMTimeGetSeconds([self.player currentTime]));
}

- (IBAction)stopTapped:(id)sender
{
    [self.player pause];
    
    [self.player seekToTime:kCMTimeZero];
    [self.playerAnimation removeM22PlayerOrbAnimation];
}

- (IBAction)minusTapped:(id)sender
{
    [self.player pause];
    
    NSInteger current = CMTimeGetSeconds([self.player currentTime]);
    
    CMTime backTime = CMTimeMakeWithSeconds(current-30, 1);
    
    [self.player seekToTime:backTime];
    [self.player play];
    [self.playerAnimation addM22PlayerOrbAnimation];
}

- (IBAction)plusTapped:(id)sender
{
    [self.player pause];
    
    NSInteger current = CMTimeGetSeconds([self.player currentTime]);
    
    CMTime backTime = CMTimeMakeWithSeconds(current+30, 1);
    
    [self.player seekToTime:backTime];
    [self.player play];
    [self.playerAnimation addM22PlayerOrbAnimation];
}

- (IBAction)playTapped:(id)sender
{
    [self.player play];
    [self.playerAnimation addM22PlayerOrbAnimation];
}

- (IBAction)previousTapped:(id)sender
{
    [self.player pause];
    
    //Saves progress in case user leaves playerVC but returns and clicks on same podcast episode
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger seconds = CMTimeGetSeconds([self.player currentTime]);
    [defaults setBool:YES forKey:@"savedProgress"];
    [defaults setObject:self.episode.podcastURL forKey:@"savedPodcast"];
    [defaults setInteger:seconds forKey:@"savedTime"];
    //NSLog(@"Show the current SAVED time: %f", CMTimeGetSeconds([self.player currentTime]));
    
    [self.player seekToTime:kCMTimeZero];
    self.player = nil;
    [self.playerAnimation removeM22PlayerOrbAnimation];
    [self.navigationController popViewControllerAnimated:YES];
}
















@end
