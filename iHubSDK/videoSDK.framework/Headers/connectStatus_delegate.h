//
//  connectStatus_delegate.h
//  VidoeTest
//
//  Created by huntelec on 2015/8/28.
//  Copyright (c) 2015年 huntelec. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol connectStatus_delegateDelegate <NSObject>
- (void)connectStatusCallBack:(NSInteger)Status DeviceType:(NSInteger)SID;
@end
