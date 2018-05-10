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

@optional

- (void)audioPlayerDidChangeStatu:(DOUAudioStreamerStatus)statu;

- (void)audioPlayerDidChangeBufferProgress:(double)preogress;

- (void)audioPlayerDidChangePlayCurrentTime:(NSTimeInterval)currentTime;

- (void)recoverPlayStatu;//回复原状态，用于上一个代理重置界面

@end

@interface JWAudioPlayer : NSObject

@property (nonatomic, assign, readonly)NSTimeInterval duration;

@property (nonatomic, weak)id <JWAudioPlayerDelegate>delegate;
@property (nonatomic, copy) AudioPlayStatu statuBlock;
@property (nonatomic, copy) AudioBufferProgress progressBlock;


+ (instancetype)sharedInstance;


- (void)playWithUrl:(NSURL *)url Delegate:(id <JWAudioPlayerDelegate>)delegate;

- (void)pause;

- (void)play;

- (void)stop;

@end
