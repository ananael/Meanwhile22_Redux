//
//  Podcast.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast

- (instancetype)initWithTitle:(NSString *)title
                      Summary:(NSString *)itunesSummary
                         Time:(NSString *)itunesDuration
                          URL:(NSString *)podcastURL
{
    self = [super init];
    if (self) {
        self.title = title;
        self.itunesSummary = itunesSummary;
        self.itunesDuration = itunesDuration;
        self.podcastURL = podcastURL;
    }
    return self;
}

@end
