//
//  ViewController.m
//  仿快手相册选择滑动特效
//
//  Created by 蒋理智 on 2018/3/14.
//  Copyright © 2018年 jingwan. All rights reserved.
//

#import "ViewController.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

#define KScreenHeight [UIScreen mainScreen].bounds.size.height

/* Values for NSTextAlignment */
typedef NS_ENUM(NSInteger, JWLayoutStatu) {
    JWLayoutStatuShow = 0,
    JWLayoutStatuHide
};


@interface ViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *touchLabel;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGRect headRect;

@property (nonatomic, assign) CGRect startTouchRect;

@property (nonatomic, assign) CGRect startScrollRect;

@property (nonatomic, assign) BOOL firstComeIn;

@property (nonatomic, assign) JWLayoutStatu layoutStatu;

@property (nonatomic, assign) CGFloat currentTransition_Y;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstComeIn = YES;
    self.currentTransition_Y = 0;
    self.layoutStatu = JWLayoutStatuShow;
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight/2.0)];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"头部视图";
    headLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:headLabel];
    self.headLabel = headLabel;
    
    UILabel *touchLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, KScreenHeight/2.0-50, KScreenWidth, 50)];
    touchLabel.text = @"touch zone";
    touchLabel.backgroundColor = [UIColor redColor];
    touchLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:touchLabel];
    self.touchLabel = touchLabel;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panStart:)];
    touchLabel.userInteractionEnabled = YES;
    pan.delegate = self;
    [touchLabel addGestureRecognizer:pan];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headLabel.frame), KScreenWidth, KScreenHeight/2.0)];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight);
//    [pan requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
    [scrollView.panGestureRecognizer addTarget:self action:@selector(panStart:)];
    
    CGFloat numHeight = KScreenHeight/20.0;
    for (int i = 0; i < 20; i++) {
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * numHeight, KScreenWidth, numHeight)];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.text = [NSString stringWithFormat:@"第%d行",i+1];
        numLabel.backgroundColor = i%2 == 0 ? [UIColor yellowColor] : [UIColor whiteColor];
        [scrollView addSubview:numLabel];
    }
}

- (void)panStart:(UIPanGestureRecognizer *)pan{
    if (pan==_scrollView.panGestureRecognizer) {
//        NSLog(@"scrollView.panGestureRecognizer响应====%d",self.firstComeIn);
        if (!self.firstComeIn) {
            if (pan.state==UIGestureRecognizerStateBegan) {
                [self gestureBegan];
            }else if (pan.state==UIGestureRecognizerStateChanged){
                CGPoint translation = [pan translationInView:self.view];
                [self gestureChangedHeadY:translation.y-self.currentTransition_Y];
            }else if (pan.state==UIGestureRecognizerStateEnded){
                [self gestureEnd];
            }
        }
    }else{
        NSLog(@"UIpanGestureRecognizer响应");
        if (pan.state==UIGestureRecognizerStateBegan) {
            [self gestureBegan];
        }else if (pan.state==UIGestureRecognizerStateChanged){
            CGPoint translation = [pan translationInView:self.view];
            [self gestureChangedHeadY:translation.y];
        }else if (pan.state==UIGestureRecognizerStateEnded){
            [self gestureEnd];
        }
    }
}

- (void)gestureBegan{
    self.headRect = self.headLabel.frame;
    self.startTouchRect = self.touchLabel.frame;
    self.startScrollRect = self.scrollView.frame;
}

- (void)gestureChangedHeadY:(CGFloat)offset_y{
    CGRect frame = self.headRect;
    frame.origin.y += offset_y;
    
    CGRect touchFrame = self.startTouchRect;
    touchFrame.origin.y += offset_y;
    
    CGRect scrollFrame = self.startScrollRect;
    scrollFrame.origin.y += offset_y;
//    NSLog(@"scrollFrame.y========%f",scrollFrame.origin.y);
    scrollFrame.size.height -= offset_y;
    
    if (frame.origin.y>=-(frame.size.height-50) && frame.origin.y<=0) {
        self.headLabel.frame = frame;
        self.touchLabel.frame = touchFrame;
        self.scrollView.frame = scrollFrame;
    }
}

- (void)gestureEndWithStatu:(BOOL )statu{
    CGRect frame = self.headLabel.frame;
    
    CGRect touchFrame = self.touchLabel.frame;
    
    CGRect scrollFrame = self.scrollView.frame;
    
    if (statu) {
        frame.origin.y = 0;
        touchFrame.origin.y = KScreenHeight/2.0-50;
        scrollFrame.origin.y = KScreenHeight/2.0;
        scrollFrame.size.height = KScreenHeight/2.0;
    }else{
        touchFrame.origin.y = 0;
        scrollFrame.origin.y = 50;
        frame.origin.y = -(KScreenHeight/2.0-40);
        scrollFrame.size.height = KScreenHeight-50;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.headLabel.frame = frame;
        self.touchLabel.frame = touchFrame;
        self.scrollView.frame = scrollFrame;
        if (statu) {
            self.layoutStatu = JWLayoutStatuShow;
        }else{
            self.layoutStatu = JWLayoutStatuHide;
        }
    }];
}

- (void)gestureEnd{
    
    CGRect frame = self.headLabel.frame;
    CGFloat hehe = frame.origin.y+frame.size.height;
    
    BOOL statu = hehe>KScreenHeight/4.0;
    
    [self gestureEndWithStatu:statu];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    CGPoint point = [pan locationInView:self.view];
    
//    NSLog(@"已经拖动到点x==%f,y==%f",point.x,point.y);
//    if (point.y==CGRectGetMaxY(self.touchLabel.frame)) {
//
//    }else{
//        
//    }
    if (CGRectContainsPoint(self.touchLabel.frame, point)) {
//        if (self.firstComeIn) {
//            NSLog(@"进入整体拖动地点");
//            [self gestureBegan];
//            [pan setTranslation:CGPointMake(0, 0) inView:self.view];
//            self.firstComeIn = NO;
//        }else{
//            CGPoint panPoint = [pan translationInView:self.view];
//            [self gestureChangedHeadY:panPoint.y];
//        }
        if (self.firstComeIn) {
            [self gestureBegan];
            CGPoint translationPoint = [pan translationInView:self.view];
            self.currentTransition_Y = translationPoint.y;
            self.firstComeIn = NO;
        }
        
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
    if (decelerate) {
        UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
        CGFloat velocity = [pan velocityInView:scrollView].y;
        if (velocity < -2) {//向上拖动隐藏
            if (self.firstComeIn==NO) {
                [self gestureEndWithStatu:NO];
                self.firstComeIn = YES;
                self.currentTransition_Y = 0;
                return;
            }
        }else {
            if (scrollView.contentOffset.y<=0) {
                if (velocity > 2){//向下拖动显示
                    [self gestureEndWithStatu:YES];
                    self.firstComeIn = YES;
                    self.currentTransition_Y = 0;
                    return;
                }
            }
        }
    }
    self.firstComeIn = YES;
    self.currentTransition_Y = 0;
    [self gestureEnd];
}

//// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        if (gestureRecognizer.view==_touchLabel) {
//            return YES;
//        }
//        return NO;
//    }
//    return NO;
//}
//
//// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
//// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
////
//// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        if (gestureRecognizer.view==_touchLabel) {
//            return YES;
//        }
//        return NO;
//    }
//    return NO;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
