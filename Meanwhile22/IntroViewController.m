//
//  IntroViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/17/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "IntroViewController.h"
#import "M22IntroAnimationView.h"
#import <AVFoundation/AVFoundation.h>

@interface IntroViewController ()

@property (weak, nonatomic) IBOutlet M22IntroAnimationView *introAnimation;
@property AVAudioPlayer *audioPlayer;
@property NSTimer *timer;
@property NSTimer *soundTimer;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self launchIntro];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fxTimer
{
    self.soundTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(introFX)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void)introFX
{
    // Construct URL to in-project sound file
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"M22 Intro"
                                              withExtension:@"mp3"];
    // Create audio player object and initialize with URL to sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    
    [self.audioPlayer play];
    
}

-(void)introTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.25
                                                  target:self
                                                selector:@selector(segue)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void)segue
{
    [self performSegueWithIdentifier:@"homeSegue" sender:self];
}

-(void)launchIntro
{
    [self.introAnimation addM22IntroAnimation];
    [self introTimer];
    [self fxTimer];
    //[self introFX];
}













@end
