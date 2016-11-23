//
//  EpisodeListViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "EpisodeListViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Podcast.h"
#import "PodcastParser.h"
#import "EpisodeListTableViewCell.h"

@interface EpisodeListViewController ()

@property NSMutableArray *podcastArray;
@property NSMutableArray *podcastTitles;
@property NSMutableArray *podcastSubtitles;
@property NSMutableArray *podcastSummaries;
@property NSMutableArray *podcastURLs;

@property Podcast *episode;

@property (weak, nonatomic) IBOutlet UIView *pageAccent;
@property (weak, nonatomic) IBOutlet UIView *bannerContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)previousTapped:(id)sender;


@end

@implementation EpisodeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self dynamicCellHeight];
    
    //Initializing data arrays
    self.podcastArray = [NSMutableArray new];
    self.podcastTitles = [NSMutableArray new];
    self.podcastSubtitles = [NSMutableArray new];
    self.podcastSummaries = [NSMutableArray new];
    self.podcastURLs = [NSMutableArray new];
    
    [self networkCheck];
    //[self initializePodcastParser];
    //[self sortPodcastData];
    
    
    //Initializes the parser and puts the data in an array
    PodcastParser *episodeParser = [[PodcastParser alloc]initWithArray:self.podcastArray];
    [episodeParser parseXMLFile];
    
    //Iterates through the episodes and puts podcast URL into array
    //Iterates through the episode titles and split the string into 2 parts ("title" and "subtitle") and adds to arrays
    for (NSInteger i=0; i<[self.podcastArray count]; i++)
    {
        self.episode = self.podcastArray[i];
        NSString *episodeSummary = self.episode.itunesSummary;
        NSString *stringURL = self.episode.podcastURL;
        NSString *originalTitle = self.episode.title;
        
        //Range is for the first instance of " : "
        NSRange range = [originalTitle rangeOfString:@":"];
        
        //Grabs everything before the range but needs "-1" to remove the " : " from the results
        NSString *episodeTitle = [originalTitle substringToIndex:NSMaxRange(range)-1];
        
        //Grabs everything after the range but needs "+1" to remove the space following " : " from the results
        NSString *episodeSubtitle = [originalTitle substringFromIndex:NSMaxRange(range)+1];
        
        [self.podcastURLs addObject:stringURL];
        [self.podcastTitles addObject:episodeTitle];
        [self.podcastSubtitles addObject:episodeSubtitle];
        [self.podcastSummaries addObject:episodeSummary];
        
        //NSLog(@"%@ : %@", self.podcastTitles[i], self.podcastSubtitles[i]);
        //NSLog(@"%@ : %@", self.podcastTitles[i], self.podcastSummaries[i]);
        
    }
    NSLog(@"PODCAST: %@", self.podcastArray);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dynamicCellHeight
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0;
}

-(void)networkCheck
{
    NSURL *xmlPath = [[NSURL alloc]initWithString:@"https://feeds.audiometric.io/1574314397"];
    NSURLRequest *request = [NSURLRequest requestWithURL:xmlPath];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (!data)
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connection NOT Found" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *networkDefault = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:networkDefault];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }] resume];
}

-(void)initializePodcastParser
{
    //Initializes the parser and puts the data in an array
    PodcastParser *episodeParser = [[PodcastParser alloc]initWithArray:self.podcastArray];
    [episodeParser parseXMLFile];
}

-(void)sortPodcastData
{
    //Iterates through the episodes and puts podcast URL into array
    //Iterates through the episode titles and split the string into 2 parts ("title" and "subtitle") and adds to arrays
    for (NSInteger i=0; i<[self.podcastArray count]; i++)
    {
        self.episode = self.podcastArray[i];
        NSString *episodeSummary = self.episode.itunesSummary;
        NSString *stringURL = self.episode.podcastURL;
        NSString *originalTitle = self.episode.title;
        
        //Range is for the first instance of " : "
        NSRange range = [originalTitle rangeOfString:@":"];
        
        //Grabs everything before the range but needs "-1" to remove the " : " from the results
        NSString *episodeTitle = [originalTitle substringToIndex:NSMaxRange(range)-1];
        
        //Grabs everything after the range but needs "+1" to remove the space following " : " from the results
        NSString *episodeSubtitle = [originalTitle substringFromIndex:NSMaxRange(range)+1];
        
        [self.podcastURLs addObject:stringURL];
        [self.podcastTitles addObject:episodeTitle];
        [self.podcastSubtitles addObject:episodeSubtitle];
        [self.podcastSummaries addObject:episodeSummary];
        
        //NSLog(@"%@ : %@", self.podcastTitles[i], self.podcastSubtitles[i]);
        //NSLog(@"%@ : %@", self.podcastTitles[i], self.podcastSummaries[i]);
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.podcastArray count];
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 // Configure the cell...
 
    EpisodeListTableViewCell *episode = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    episode.titleLabel.text = self.podcastTitles[indexPath.row];
    episode.titleLabel.numberOfLines = 0;
    
    episode.detailLabel.text = self.podcastSubtitles[indexPath.row];
    episode.detailLabel.numberOfLines = 0;
    
    episode.backgroundColor = [UIColor clearColor];
    
    UIView *highlightCell = [UIView new];
    [highlightCell setBackgroundColor:[UIColor colorWithRed:253.0/255 green:229.0/255.0 blue:69.0/255.0 alpha:0.5]];
    episode.selectedBackgroundView = highlightCell;
    
    
    return episode;
 }

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
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

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

















@end
