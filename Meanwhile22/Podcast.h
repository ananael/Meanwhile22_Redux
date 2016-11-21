//
//  Podcast.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Podcast : NSObject

@property NSString *title;
@property NSString *itunesSummary;
//The duration property was changed from NSItneger to NString to read from the SoundCloud xml feed.
//@property NSInteger itunesDuration;
@property NSString *itunesDuration;
@property NSString *podcastURL;

-(instancetype)initWithTitle: (NSString *)title
                     Summary: (NSString *)itunesSummary
                        Time: (NSString *)itunesDuration
                         URL: (NSString *)podcastURL;

@end
