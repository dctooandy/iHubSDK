//
//  connectPlayback_delegate.h
//  VidoeTest
//
//  Created by huntelec on 2015/8/27.
//  Copyright (c) 2015年 huntelec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol connectPlayback_delegateDelegate <NSObject>
- (void)getPlaybackDataCallback:(UIImage *)image;
- (void)getPlaybackPathCallback:(NSString *)Path;
@end

