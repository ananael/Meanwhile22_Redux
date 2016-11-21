//
//  PodcastParser.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Podcast.h"

@interface PodcastParser : NSObject<NSXMLParserDelegate>

@property NSMutableArray *podcastArray;

-(instancetype)initWithArray: (NSMutableArray *)podcastArray;

-(void)parseXMLFile;

@end
