//
//  ViewController.m
//  Demo
//
//  Created by 马龙飞 on 2017/10/25.
//  Copyright © 2017年 MLF. All rights reserved.
//

#import "ViewController.h"
#import "RockerControlView.h"

@interface ViewController ()<RockerControlViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RockerControlView *view = [[RockerControlView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 500) / 2, ([UIScreen mainScreen].bounds.size.height - 500) / 2, 500, 500)];
    view.delegate = self;
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -RockerControlViewDelegate
- (void)controlResponseWithControlState:(RockerControlState)controlState xDirectionResponse:(float)x yDirectionResponse:(float)y {
    
    NSLog(@"controlState = %d,x = %f,y = %f",controlState,x,y);
}

@end
