//
//  CATransitionViewController.m
//  AnimationNotes
//
//  Created by maginawin on 15-2-3.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

// ---- CAAnimation 提供如下属性和方法:

// removedOnCompletion: 动画完成时是否移除动画
// timingFunction: 指定一个 CAMediaTimingFunction 对象, 负责控制动画的步长
// -animationDidStart:(CAAnimation*)theAnimation: 开始时将会回调该方法
// -animationDidStop:(CAAnimation*)theAnimation finished:(BOOL)flag: 结束时回调

// ---- CATransition 的 type 控制动画类型, 支持如下的值

// kCATransitionFade: 渐隐
// kCATransitionMoveIn: 移入
// kCATransitionPush: 推入
// kCATransitionReveal: 揭开
// cube: 立方体旋转动画
// suckEffect: 收缩动画 (就像被吸入的效果)
// oglFlip: 翻转动画
// rippleEffect: 水波动画
// pageCurl: 面面揭开动画
// pageUnCurl: 放下页面动画
// cameraIrisHollowOpen: 镜头打开
// cameraIrisHollowClose: 镜头关闭

// ---- CATransition 的 subtype 用于控制动画方向

// kCATransitionRight
// kCATransitionLeft
// kCATransitionTop
// kCATransitionBottom

// ---- 通过 UIView 的 beginAnimations: context: 与 commitAnimations 方法控制子组件的过渡动画

// setAnimationTransition:froView:cache: 控制 UIView 的过渡动画的动画方式

// UIViewAnimationTransitionNone: 不使用动画
// UIViewAnimationTransitionFlipFromLeft: 指定从左边滑入
// UIViewAnimationTransitionFlipFromRight: 从右边滑入
// UIViewAnimationTransitionCurlUp: 翻开书页
// UIViewAnimationTransitionCurlDown: 放下书页

// setAnimationCurve: 方法用于控制动画的变化曲线, 也就是控制动画的变化速度

// UIViewAnimationCurveEaseInOut: 先比较慢, 后逐渐加快
// UIViewAnimationCurveEaseIn: 逐渐变慢
// UIViewANimationCurveEaseOut: 动画逐渐加快
// UIViewAnimationCurveLinear: 匀速动画

#import "CATransitionViewController.h"

@interface CATransitionViewController ()

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 向下翻页
- (IBAction)add:(id)sender {
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView commitAnimations];
}

// 向上翻页
- (IBAction)curl:(id)sender {
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 交换视图控制器中所显示的 UIView 中两个子控件的位置
    [self.view exchangeSubviewAtIndex:3 withSubviewAtIndex:2];
    [UIView commitAnimations];
}

// 移动
- (IBAction)move:(id)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 2.0f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:@"animation"];
    self.view.layer.backgroundColor = [UIColor magentaColor].CGColor;
    self.view.layer.opacity = 0.5;    
}

// 揭开
- (IBAction)reveal:(id)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    [self.view.layer addAnimation:transition forKey:@"animationtest"];
}

// 立方
- (IBAction)cube:(id)sender {
    CATransition* transtion = [CATransition animation];
    transtion.duration = 1.0f;
    transtion.type = @"cube";
    transtion.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transtion forKey:@"animaiton"];
    self.view.layer.backgroundColor = [UIColor purpleColor].CGColor;
}

// 吸
- (IBAction)suck:(id)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.type = @"suckEffect"; // Effect: 效果
    transition.subtype = kCATransitionFromTop;
    [self.view.layer addAnimation:transition forKey:@"animation"];
}

// oglFlip
- (IBAction)oglFlip:(id)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromBottom;
    [self.view.layer addAnimation:transition forKey:@"animation"];
}

// ripple 水波
- (IBAction)rippleEffect:(id)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.type = @"rippleEffect";
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:@"animation"];
    self.view.layer.backgroundColor = [UIColor magentaColor].CGColor;
}

@end
