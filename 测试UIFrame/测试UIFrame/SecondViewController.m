//
//  SecondViewController.m
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UITextField+LZExtention.h"
#import "LZTextView.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameT;
@property (weak, nonatomic) IBOutlet UITextField *passwordT;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation SecondViewController
- (IBAction)hehe:(id)sender {
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
    int hehe = arc4random()%10;
    if (hehe>5) {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@" @好友1号 " attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        [mstr insertAttributedString:str atIndex:0];
    }else {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@" #话题2号# " attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        [mstr appendAttributedString:str];
    }
    _textView.attributedText = mstr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LZTextView *textView = [[LZTextView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
    [self.view addSubview:textView];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"你个大傻逼呵呵呵呵呵 ， 结束待机时都是废话，kshdksfj skfjk胜利大街" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    NSAttributedString *hehe = [[NSAttributedString alloc] initWithString:@" @美女" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    textView.defaultAtts = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [attStr appendAttributedString:hehe];
    textView.attributedText = attStr;
    _textView = textView;
    
//    [[self.userNameT.rac_textSignal filter:^BOOL(id value) {
//        NSString *text = value;
//        return text.length > 5;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//
//    [[[self.userNameT.rac_textSignal map:^id(NSString *value) {
//        return [NSNumber numberWithUnsignedInteger:value.length];
//    }] filter:^BOOL(NSNumber *length) {
//        return length.integerValue > 3;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
//    RACSignal *validNameSingal = [self.userNameT.rac_textSignal map:^id(id value) {
//        return @([self nameIsValid:value]);
//    }];
//    RACSignal *validPasswordSingal = [self.passwordT.rac_textSignal map:^id(id value) {
//        return @([self passwordIsValid:value]);
//    }];
//
//    RAC(self.userNameT, textColor) = [validNameSingal map:^id(id value) {
//        return [value boolValue] ? [UIColor redColor] : [UIColor yellowColor];
//    }];
//
//    RAC(self.passwordT, textColor) = [validPasswordSingal map:^id(id value) {
//        return [value boolValue] ? [UIColor redColor] : [UIColor yellowColor];
//    }];
//
//    RACSignal *signUpActiveSingal = [RACSignal combineLatest:@[validNameSingal, validPasswordSingal] reduce:^id(NSNumber *nameValid, NSNumber *passwordValid){
//        return @([nameValid boolValue] && [passwordValid boolValue]);
//    }];
//
//    [signUpActiveSingal subscribeNext:^(id x) {
//        self.loginBtn.enabled = [x boolValue];
//    }];
//
//    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"login action");
//    }];
}

//- (RACSignal *)loginSignal {
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        self.
//    }];
//}

- (BOOL)nameIsValid:(NSString *)text {
    return text.length==8;
}

- (BOOL)passwordIsValid:(NSString *)text {
    return [text isEqualToString:@"password"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
