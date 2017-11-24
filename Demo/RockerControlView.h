//
//  RockerControlView.h
//  Demo
//
//  Created by 马龙飞 on 2017/10/25.
//  Copyright © 2017年 MLF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RockerControlStateBegin		    = 1000,
    RockerControlStateMoved	        = 1001,
    RockerControlStateCancelled		= 1002,
    RockerControlStateEnded		    = 1003
} RockerControlState;

@protocol  RockerControlViewDelegate<NSObject>

@optional
- (void)controlResponseWithControlState:(RockerControlState)controlState
                     xDirectionResponse:(float)x
                     yDirectionResponse:(float)y;

@end

@interface RockerControlView : UIView

@property (nonatomic, weak)id<RockerControlViewDelegate>delegate;

@end
