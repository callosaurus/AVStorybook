//
//  Story.h
//  AV Storybook
//
//  Created by Callum Davies on 2017-02-26.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Story : NSObject

@property (nonatomic) NSURL *storyAudio;
@property (nonatomic) int pageIndex;
@property (nonatomic, strong) UIImage *pictureDisplayed;
//@property NSString *storyImageName;

- (instancetype)initWithIndex:(int)index;

@end
