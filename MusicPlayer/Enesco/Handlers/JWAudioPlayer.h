//
//  JWAudioPlayer.h
//  Enesco
//
//  Created by 蒋理智 on 2018/5/10.
//  Copyright © 2018年 aufree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioStreamer.h"

typedef void(^AudioBufferProgress)(double progress);

typedef void(^AudioPlayStatu)(DOUAudioStreamerStatus statu);

@protocol JWAudioPlayerDelegate <NSObject>

- (void)audioPlayerDidChangeStatu:(DOUAudioStreamerStatus)statu;

- (void)audioPlayerDidChangeBufferProgress:(double)preogress;

- (void)audioPlayerDidChangePlayCurrentTime:(NSTimeInterval)currentTime;

@optional




@end

@interface JWAudioPlayer : NSObject

@property (nonatomic, assign, readonly)NSTimeInterval duration;

@property (nonatomic, weak)id <JWAudioPlayerDelegate>delegate;

+ (instancetype)sharedInstance;


- (void)playWithUrl:(NSURL *)url;

- (void)pause;

- (void)play;

@end
