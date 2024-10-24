//
//  HuntStreamData.h
//  askyviewer
//
//  Created by skchen on 2013/12/16.
//
//

#import <Foundation/Foundation.h>

@interface HuntStreamDataSDK : NSObject

@property(nonatomic, assign, readonly) int length;

- (void)appendData:(NSData *)data;

- (NSData *)getData;

- (BOOL)isValid;
- (BOOL)isIpcam;
- (BOOL)isDvr;
- (BOOL)isAudio;
- (BOOL)isVideo;
- (BOOL)isSystemHeader;
- (BOOL)isH264;
- (BOOL)isH265;
- (BOOL)isJpeg;

- (int)getVideoType;
-(int)getReserver;
- (NSInteger)getFrameType;
- (NSInteger)getAudioType;

- (int)getChannel;
- (int)getTimeMsec;
- (int)getTimeSec;
- (int)isAudioType;
- (unsigned long long) imageQualityHeight;
//- (/*time_t*/unsigned int)getDuration;
- (unsigned long long) getDuration;
- (unsigned long long) getuSecDuration;
- (BOOL)isPlayback;
- (void)flush;

- (int)length;



@end
