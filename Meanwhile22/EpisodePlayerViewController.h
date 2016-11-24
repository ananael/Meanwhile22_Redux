//
//  EpisodePlayerViewController.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/23/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodeListTableViewCell.h"
#import "Podcast.h"

@interface EpisodePlayerViewController : UIViewController

@property Podcast *episode;
@property NSString *episodeTitle;
@property NSString *episodeSubtitle;
@property NSArray *podcastArray;

@end
