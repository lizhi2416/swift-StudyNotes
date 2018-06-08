//
//  Calcultor.m
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "Calcultor.h"

@implementation Calcultor

- (Calcultor *)calculator:(int (^)(int num))block {
    _result = block(_result);
    return self;
}

- (Calcultor *)equal:(BOOL (^)(int num))block {
    _isEqual = block(_result);
    return self;
}

@end
