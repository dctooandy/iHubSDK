//
//  ConnectNode.h
//  VidoeTest
//
//  Created by huntelec on 2015/6/24.
//  Copyright (c) 2015年 huntelec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#import "connectPlayback_delegate.h"
#import "connectStatus_delegate.h"
#import "Player_delegate.h"


@protocol ConnectNodeDelegate <NSObject>
- (void)onHuntVideoImage:(UIImage *)image channel:(int)channel time:(unsigned long long)timestamp;
- (void)onMobileSDKStatusChange:(NSInteger)errCode DeviceType:(NSInteger)SID;
- (void)onIPCamAVIPath:(NSString *)Path;
- (void)onVideoData:(NSData *)Data FrameType:(NSInteger)Type MilliSecondTime:(int)mTime SecondTime:(int)Time;
- (void)onRelayStatus:(NSInteger)status;
@end


@interface ConnectNode : NSObject<Player_delegate, connectPlayback_delegateDelegate, connectStatus_delegateDelegate, AVAudioPlayerDelegate>


- (NSInteger)Initialize:(int)Type;
- (void)DeInitialize;

- (void)addListener:(NSObject<ConnectNodeDelegate> *)listener;
- (void)removeListener:(NSObject<ConnectNodeDelegate> *)listener;


- (NSInteger)ConnectNode:(NSDictionary *)DeviceInfo;
- (BOOL)GetNodeConnectionState;
- (NSInteger)DisconnectNode;
- (NSDictionary *)getDeviceInfo;

- (void)VideoLiveStart:(BOOL)quality Channel:(NSInteger)CH; //NVR IPCam
- (void)VideoLiveStop;
- (void)VideoStreamStart:(BOOL)quality Channel:(NSInteger)CH;
- (void)VideoStreamStop;
- (void)AudioLiveStart;
- (void)AudioLiveStop;
- (void)MicAudioLiveStart;
- (void)MicAudioLiveStop;

- (void)GetNVRPlayback:(NSDate*)playbacktime Channel:(NSInteger)CH; //getNVRPlayback
- (NSArray*)GetNVREventData; //getNVREventData

- (NSString*)GetIPCamEventDateList;
- (NSString*)GetIPCamEventTimeList:(NSString*)Date;
- (NSString*)GetIPCamEventFile:(NSString*)Path Interval:(int)sec;

- (void)GetRelayStatus:(NSInteger)ch;
- (void)SetRelayStatus:(NSInteger)status channel:(NSInteger)ch;

- (NSMutableArray *)GetIPCamPlaybackRtspUrl:(NSString *)startTime stopTime:(NSString *)stopTime;
//- (NSData *)httpRequset:(NSString *)cgiCmd timeout:(NSInteger)timeout;

@end
