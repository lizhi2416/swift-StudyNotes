//
//  LZTextView.m
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/20.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "LZTextView.h"

@interface LZTextView ()<UITextViewDelegate>



@end

@implementation LZTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self addObserver:self forKeyPath:@"selectedTextRange" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectedTextRange"]) {
        UITextRange *newContentStr = [change objectForKey:@"new"];
        UITextRange *oldContentStr = [change objectForKey:@"old"];
        NSRange newRange = [self selectTextRange:newContentStr];
        NSRange oldRange = [self selectTextRange:oldContentStr];
        if (newRange.location != oldRange.location) {
            //判断光标移动，光标不能处在特殊文本内
            
            [self.attributedText enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:(NSAttributedStringEnumerationReverse) usingBlock:^(NSDictionary *attrs, NSRange range, BOOL * _Nonnull stop) {
                NSLog(@"range = %@",NSStringFromRange(range));
                if (attrs!=nil && attrs!=0) {
                    if (newRange.location > range.location && newRange.location < (range.location+range.length)) {
                        //光标距离左边界的值
                        NSUInteger leftValue = newRange.location - range.location;
                        //光标距离右边界的值
                        NSUInteger rightValue = range.location+range.length - newRange.location;
                        if (leftValue >= rightValue) {
                            self.selectedRange = NSMakeRange(self.selectedRange.location-leftValue, 0);
                        }else{
                            self.selectedRange = NSMakeRange(self.selectedRange.location+rightValue, 0);
                        }
                    }
                }
            }];
            
        }
    }
    self.typingAttributes = self.defaultAtts;
}

- (NSRange)selectTextRange:(UITextRange *)textRange {
    //获取textField中文本开始点 @"1"这个位置
    UITextPosition* beginning = self.beginningOfDocument;
    //获取textField选中选中范围 @“UITextRange”
    UITextRange* selectedRange = textRange;
    //获取开始点@“3”的位置
    UITextPosition* selectionStart = selectedRange.start;
    //结束点@"7"的位置
    UITextPosition* selectionEnd = selectedRange.end;
    //计算NSRange
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    //返回范围
    return NSMakeRange(location, length);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.typingAttributes = self.defaultAtts;
    if ([text isEqualToString:@""]) {//删除
        __block BOOL deleteSpecial = NO;
        NSRange oldRange = textView.selectedRange;
        
        [textView.attributedText enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(0, textView.selectedRange.location) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSRange deleteRange = NSMakeRange(textView.selectedRange.location-1, 0) ;
            if (attrs != nil && attrs != 0) {
                if (deleteRange.location > range.location && deleteRange.location < (range.location+range.length)) {
                    NSMutableAttributedString *textAttStr = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
                    [textAttStr deleteCharactersInRange:range];
                    textView.attributedText = textAttStr;
                    deleteSpecial = YES;
                    textView.selectedRange = NSMakeRange(oldRange.location-range.length, 0);
                    *stop = YES;
                }
            }
        }];
        return !deleteSpecial;
    }
    
    //输入了done
    if ([text isEqualToString:@"\n"]) {
        if (self.returnKeyType == UIReturnKeyDone) {
            [self resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectedTextRange"];
}


@end
