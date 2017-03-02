//
//  Story.m
//  AV Storybook
//
//  Created by Callum Davies on 2017-02-26.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "Story.h"

@implementation Story

- (instancetype)initWithIndex:(int)index
{
    self = [super init];
    if (self) {
        
        _pageIndex = index;
        
        NSString *audioURL = [NSString stringWithFormat:@"ProjectAudioFile%i.m4a", index];
        
        NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject],audioURL, nil];
        
        self.storyAudio = [NSURL fileURLWithPathComponents:pathComponents];
        
    }
    return self;
}

@end
