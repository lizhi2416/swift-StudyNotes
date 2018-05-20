//
//  Calcultor.h
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calcultor : NSObject

@property (nonatomic, assign) BOOL isEqual;

@property (nonatomic, assign) int result;

- (Calcultor *)calculator:(int (^)(int num))block;

- (Calcultor *)equal:(BOOL (^)(int num))block;


@end
