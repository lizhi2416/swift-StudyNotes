//
//  MusicListCell.m
//  Enesco
//
//  Created by Aufree on 11/30/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "MusicListCell.h"
#import "UIButton+WebCache.h"
#import "JWAudioPlayer.h"

@interface MusicListCell ()<JWAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *musicNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicArtistLabel;
@property (weak, nonatomic) IBOutlet NAKPlaybackIndicatorView *musicIndicator;

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (assign, nonatomic) NSUInteger statu;


@end

@implementation MusicListCell

- (void)setMusicNumber:(NSInteger)musicNumber {
    _musicNumber = musicNumber;
    _musicNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)musicNumber];
    if (musicNumber > 999) {
        _musicNumberLabel.font = [UIFont systemFontOfSize:13];
    }
}

- (void)setMusicEntity:(MusicEntity *)musicEntity {
    _musicEntity = musicEntity;
    _musicTitleLabel.text = _musicEntity.name;
    _musicArtistLabel.text = _musicEntity.artistName;
}

- (NAKPlaybackIndicatorViewState)state {
    return self.musicIndicator.state;
}

- (void)setState:(NAKPlaybackIndicatorViewState)state {
    self.musicIndicator.state = state;
    self.musicNumberLabel.hidden = (state != NAKPlaybackIndicatorViewStateStopped);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statu = 0;
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = CGPointMake(SCREEN_WIDTH-80, 28.5);
    [self.contentView addSubview:activityView];
    self.activityView = activityView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://aufree.qiniudn.com/images/album/img20/89520/4280541424067346.jpg"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
    button.frame = CGRectMake(SCREEN_WIDTH-60, 3.5, 50, 50);
    [button setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    self.button = button;
}

- (void)buttonClick {
    if (self.statu==0) {
        [[JWAudioPlayer sharedInstance] playWithUrl:[NSURL URLWithString:_musicEntity.musicUrl] Delegate:self];
    }else {
        if (self.statu==1) {
            [[JWAudioPlayer sharedInstance] pause];
        }else{
            [[JWAudioPlayer sharedInstance] play];
        }
    }
}

- (void)audioPlayerDidChangeStatu:(DOUAudioStreamerStatus)statu {
    [self.button setSelected:statu==DOUAudioStreamerPlaying];
    
    if (statu==DOUAudioStreamerPlaying) {
        self.statu = 1;
        [self.activityView stopAnimating];
        NSLog(@"正在播放");
    }else if (statu==DOUAudioStreamerBuffering){
        self.statu = 2;
        NSLog(@"正在缓存");
        [self.activityView startAnimating];
    }else if (statu==DOUAudioStreamerPaused){
        self.statu = 3;
        NSLog(@"正在暂停");
        [self.activityView stopAnimating];
    }else {
        NSLog(@"其他状态");
        self.statu = 4;
        [self.activityView stopAnimating];
    }
}

//- (void)audioPlayerDidChangeBufferProgress:(double)preogress;

//- (void)audioPlayerDidChangePlayCurrentTime:(NSTimeInterval)currentTime;

- (void)recoverPlayStatu {
    self.statu = 0;
    [self.button setSelected:NO];
    [self.activityView stopAnimating];
}
@end
