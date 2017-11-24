//
//  RockerControlView.m
//  Demo
//
//  Created by 马龙飞 on 2017/10/25.
//  Copyright © 2017年 MLF. All rights reserved.
//

#import "RockerControlView.h"

#define RADIUS ([self bounds].size.width / 2.f)

@interface RockerControlView ()

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *validAreaView;
@property (nonatomic, assign) float sX;
@property (nonatomic, assign) float sY;

@end

@implementation RockerControlView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        self.sX = 0;
        self.sY = 0;
        [self createUI];
    }
    
    return self;
}

- (void)createUI {
    
    self.backgroundColor = [UIColor redColor];
    _validAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _validAreaView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _validAreaView.layer.cornerRadius = 100;
    _validAreaView.clipsToBounds = YES;
    _validAreaView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_validAreaView];
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _centerView.layer.cornerRadius = 30;
    _centerView.clipsToBounds = YES;
    _centerView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _centerView.backgroundColor = [UIColor purpleColor];
    [self addSubview:_centerView];

}

//开始移动
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint location = [[touches anyObject] locationInView:self];
    [self moveControlWithTouchPoint:location andRockerControlState:RockerControlStateBegin];
    
}

//开始移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint location = [[touches anyObject] locationInView:self];
    [self moveControlWithTouchPoint:location andRockerControlState:RockerControlStateMoved];
}

- (void)moveControlWithTouchPoint:(CGPoint )touchPoint andRockerControlState:(RockerControlState)rockerControlState {

    float x = 0;
    float y = 0;
    x = touchPoint.x - RADIUS;
    y = touchPoint.y - RADIUS;
    float r = 100;
    float r1 = sqrt(x * x + y * y);
    if ((x * x + y * y) <= r * r) {
        self.centerView.center = touchPoint;
    }else {
        if ((x <= 0) && (y <= 0)) {
            self.centerView.center = CGPointMake(RADIUS - fabs(x / r1 * r), RADIUS - fabs(y / r1 * r));
        }else if ((x < 0) && (y > 0)) {
            self.centerView.center = CGPointMake(RADIUS - fabs(x / r1 * r), RADIUS + fabs(y / r1 * r));
        }else if ((x > 0) && (y < 0)) {
            self.centerView.center = CGPointMake(RADIUS + fabs(x / r1 * r), RADIUS - fabs(y / r1 * r));
        }else {
            self.centerView.center = CGPointMake(RADIUS + fabs(x / r1 * r), RADIUS + fabs(y / r1 * r));
        }
    }
    
    float x1 = fabsf(x);
    float y1 = fabsf(y);
    float distance = sqrtf(x1 * x1 + y1 * y1);
    x1 = fabs(x1 / distance * RADIUS);
    y1 = fabs(y1 / distance * RADIUS);
    distance = sqrtf(x1 * x1 + y1 * y1);
    if (x <= 0 && y <= 0) {
        self.sX = -x1 / RADIUS;
        self.sY = y1 / RADIUS;
    }else if(x > 0 && y <= 0) {
        self.sX = x1 / RADIUS;
        self.sY = y1 / RADIUS;
    }else if(x < 0 && y > 0) {
        self.sX = -x1 / RADIUS;
        self.sY = -y1 / RADIUS;
    }else if(x > 0 && y > 0) {
        self.sX = x1 / RADIUS;
        self.sY = -y1 / RADIUS;
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(controlResponseWithControlState:xDirectionResponse:yDirectionResponse:)]) {
        [self.delegate controlResponseWithControlState:rockerControlState xDirectionResponse:self.sX yDirectionResponse:self.sY];
    }
}

//触摸取消
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self moveEndWithRockerControlState:RockerControlStateCancelled];
}

//触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self moveEndWithRockerControlState:RockerControlStateEnded];
}

- (void)moveEndWithRockerControlState:(RockerControlState)rockerControlState {
    self.sX = 0;
    self.sY = 0;
    self.centerView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(controlResponseWithControlState:xDirectionResponse:yDirectionResponse:)]) {
        [self.delegate controlResponseWithControlState:rockerControlState xDirectionResponse:self.sX yDirectionResponse:self.sY];
    }
}

@end
