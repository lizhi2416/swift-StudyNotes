//
//  CaculatorMaker.h
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculatorMaker;

typedef CaculatorMaker *(^CasulatorBlock)(int);

@interface CaculatorMaker : NSObject

@property (nonatomic, assign) int result;

- (CasulatorBlock)add;

- (CasulatorBlock)sub;

- (CasulatorBlock)muilt;

- (CasulatorBlock)divide;

@end
