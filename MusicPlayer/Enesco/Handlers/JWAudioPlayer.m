//
//  JWAudioPlayer.m
//  Enesco
//
//  Created by 蒋理智 on 2018/5/10.
//  Copyright © 2018年 aufree. All rights reserved.
//

#import "JWAudioPlayer.h"
#import "Track.h"

static void *JWAudioPlayerStatusKVOKey = &JWAudioPlayerStatusKVOKey;
static void *JWAudioPlayerDurationKVOKey = &JWAudioPlayerDurationKVOKey;
static void *JWAudioPlayerBufferingRatioKVOKey = &JWAudioPlayerBufferingRatioKVOKey;

@interface JWAudioPlayer ()
@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, strong) Track *track;
@end

@implementation JWAudioPlayer

+ (instancetype)sharedInstance {
    static JWAudioPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[JWAudioPlayer alloc] init];
        player.streamer = [[DOUAudioStreamer alloc] init];
    });
    return player;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _track = [[Track alloc] init];
    }
    return self;
}

- (void)playWithUrl:(NSURL *)url Delegate:(id <JWAudioPlayerDelegate>)delegate {
    
    if (url==nil) {
        return;
    }
    
    @try {
        [self removeStreamerObserver];
    } @catch(id anException){
    }
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(recoverPlayStatu)]) {
            [_delegate recoverPlayStatu];
        }
        _delegate = nil;
    }
    
    _delegate = delegate;//重设代理
    
    if ([_track.audioFileURL.absoluteString isEqualToString:url.absoluteString] && _streamer) {
        [_streamer play];
        return;//相同的播放地址则不重置
    }
    
    Track *track = [[Track alloc] init];
    track.audioFileURL = url;
    
    _streamer = nil;
    _streamer = [DOUAudioStreamer streamerWithAudioFile:track];
    
    [self addStreamerObserver];
    [self.streamer play];
}

- (void)removeStreamerObserver {
    [_streamer removeObserver:self forKeyPath:@"status"];
    [_streamer removeObserver:self forKeyPath:@"duration"];
    [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
}

- (void)addStreamerObserver {
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:JWAudioPlayerStatusKVOKey];
    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:JWAudioPlayerDurationKVOKey];
    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:JWAudioPlayerBufferingRatioKVOKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == JWAudioPlayerStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == JWAudioPlayerDurationKVOKey) {
        [self performSelector:@selector(updatePlayCurrentTime)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == JWAudioPlayerBufferingRatioKVOKey) {
        [self performSelector:@selector(updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateStatus {
    if (_delegate&&[_delegate respondsToSelector:@selector(audioPlayerDidChangeStatu:)]) {
        [_delegate audioPlayerDidChangeStatu:_streamer.status];
    }
    if (self.statuBlock) {
        self.statuBlock(_streamer.status);
    }
}

- (void)updatePlayCurrentTime {
    if (_delegate&&[_delegate respondsToSelector:@selector(audioPlayerDidChangePlayCurrentTime:)]) {
        [_delegate audioPlayerDidChangePlayCurrentTime:_streamer.currentTime];
    }
}

- (void)updateBufferingStatus {
    if (_delegate&&[_delegate respondsToSelector:@selector(audioPlayerDidChangeBufferProgress:)]) {
        [_delegate audioPlayerDidChangeBufferProgress:_streamer.bufferingRatio];
    }
    if (self.progressBlock) {
        self.progressBlock(_streamer.bufferingRatio);
    }
}

- (void)pause {
    [_streamer pause];
}

- (void)play {
    [_streamer play];
}

- (void)stop {
    [_streamer stop];
}

- (NSTimeInterval)duration {
    return _streamer.duration;
}

@end
