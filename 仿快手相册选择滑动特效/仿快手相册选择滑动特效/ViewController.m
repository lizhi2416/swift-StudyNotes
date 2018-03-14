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

@interface ViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *touchLabel;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight/2.0)];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"头部视图";
    headLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:headLabel];
    self.headLabel = headLabel;
    
    UILabel *touchLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headLabel.frame)-50, KScreenWidth, 50)];
    touchLabel.text = @"touch zone";
    touchLabel.backgroundColor = [UIColor redColor];
    touchLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:touchLabel];
    self.touchLabel = touchLabel;
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panStart:)];
//    touchLabel.userInteractionEnabled = YES;
//    pan.delegate = self;
//    [touchLabel addGestureRecognizer:pan];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headLabel.frame), KScreenWidth, KScreenHeight/2.0)];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    CGPoint point = [pan locationInView:self.view];
    
//    NSLog(@"已经拖动到点x==%f,y==%f",point.x,point.y);
    if (point.y==CGRectGetMaxY(self.touchLabel.frame)) {
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
    }else{
        if (CGRectContainsPoint(self.touchLabel.frame, point)) {
            NSLog(@"进入整体拖动地点");
            
            CGPoint panPoint = [pan translationInView:self.view];
            NSLog(@"已经拖动的距离是%f",panPoint.y);
            CGRect headRect = self.headLabel.frame;
            headRect.origin.y += panPoint.y;
            self.headLabel.frame = headRect;
            
            CGRect scrollRect = self.scrollView.frame;
            scrollRect.origin.y += panPoint.y;
            scrollRect.size.height -= panPoint.y;
            self.scrollView.frame = scrollRect;
        }
    }
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
