//
//  Player_delegate.h
//  videoSDK
//
//  Created by huntelec on 2015/12/24.
//  Copyright © 2015年 huntelec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol Player_delegate <NSObject>

- (void)PlayerPostImage:(UIImage *)image time:(unsigned long long)timestamp;
- (void)getDataOnly:(NSData *)VideoData FrameType:(NSInteger)type MilliSecondTime:(int)mTime SecondTime:(int)Time;

@end
