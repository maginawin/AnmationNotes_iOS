//
//  CAPropertyViewController.m
//  AnimationNotes
//
//  Created by maginawin on 15-2-3.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

// ---- CAPropertyAnimation 属性动画, 用于控制 CALayer 的动画属性 (所有支持数值型属性值的属性几乎都可以作为动画属性) 持续改变

// +(id)animationWithKeyPath:(NSString*)keyPath: 仅需要一个参数, 一个字符串类型的值, 指定 CALayer 的动画属性名, 设置该属性动画控制 CALayer 的哪个动画

// 其他属性:
// keyPath: 返回创建 CAPropertyAnimation 时指定的参数
// additive: 指定该属性动画是否以当前动画效果为基础
// cumulative: 该属性指定动画是否为累加效果
// valueFunction: 是一个 CAValueFunction 对象, 负责对属性改变的插值计算, 一般无需指定该值

// position: 位置
// affineTransform: 指定一个 CGAffineTransform 对象, 代表对 CALayer 执行 X, Y 两个维度 (也就是平面) 上的旋转, 缩放, 位移, 斜切, 镜像等变换矩阵
// transform: 指定一个 CAtransform3D 对象, 代表对 CALayer 执行 X, Y, Z 三个维度中的旋转, 缩放, 位移, 斜切, 镜像等变换矩阵

// ---- Core Animation 提供如下函数来创建三维变换矩阵

// CATransform3DEqualToTransform(CATransform3D a, CATransform3D b): 判断两个变换矩阵是否相等
// CATransform3DMakeTranslation(CGFloat tx, CGFloat ty, CGFloat tz): 创建在 X 方向上移动 tx, Y 方向上移动 ty, Z 方向上移动 tz 的变换矩阵
// CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz): 创建在 X 方向上缩放 sx, Y 方向上缩放 sy, Z 方向上缩放 sz的变换矩阵
// CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z): 创建基于指定旋转轴旋转 angle 弧度的变换. 其中 x, y, z 的值用于确定旋转轴的方向, 比如 (1, 0, 0) 指定旋转轴为 X 轴, (1, 1, 0) 指定以 X 轴, Y 轴夹角的中线为旋转轴
// CATransform3DTranslate(CATransform3D t, CGFloat angle, CGFloat x, CGFloat y, CGFloat z): 以已有 t 变换矩阵为基础执行移动变换
// CATransform3DScale(CATransform3D t, CGFloat sx, CGFloat sy, CGFloat sz): 以已有的 t 变换矩阵为基础执行缩放
// CAtransform3DRotate(CATransform3D t, CGFloat angle, CGFloat x, CGFloat y, CGFloat z): 以已有的 t 变换矩阵为基础执行变换
// CATransform3DConcat(CATransform3D a, CATransform3D b): 对 a 执行累加
// CATransform3DInvert(CATransform3D t): 对已有的 t 执行反转
// CATransform3DMakeAffineTransform(CGAffineTransform m): 将 CGAffineTransform 矩阵包装成 CATransform3D 变换矩阵, 只有 X, Y 的变换
// CATransform3DIsAffine(CATransform3D t): 是否是 Affine 变换
// CATransform3DGetAffineTransform(CATransfomr3D t): t 中包含的 Affine 变换

// ---- CABasicAnimation, CAKeyframeAnimation 都继承了 CAPropertyAnimation
// CABasicAnimation 只能指定动画属性的开始和结束值
// CAKeyframeAnimation 可为动画属性指定多个值

// CALayer 的 addAnimation:forKey: 添加动画即可

// ---- CALayer 为动画支持提供了如下的方法

// -addAnimation:forKey: 为 CALayer 添加一个动画, forKey: 为该动画指定的 key (相当于该动画的唯一标识, 这样保证每个 CALayer 可以绑定多个动画对象)
// -animationForKey: 控制该 CALayer 执行指定 key 所对应的动画
// -removeAllAnimations: 删除该 CALayer 上所有的动画
// -removeAnimationForKey: 根据 key 删除该 CALayer 上指定的动画
// -animtionKeys: 获取该 CALayer 上添加的所有动画 key 所组成的数组


#import "CAPropertyViewController.h"

@interface CAPropertyViewController ()

@end

@implementation CAPropertyViewController
CALayer* imageLayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    imageLayer = [CALayer layer];
    imageLayer.cornerRadius = 8.0f;
    imageLayer.borderWidth = 1;
    imageLayer.masksToBounds = YES;
    imageLayer.frame = CGRectMake(30, 80, 100, 100);
    imageLayer.contents = (id)[UIImage imageNamed:@"mainball"].CGImage;
    imageLayer.backgroundColor = [UIColor magentaColor].CGColor;
    [self.view.layer addSublayer:imageLayer];
}

- (IBAction)move:(id)sender {
    CGPoint fromPoint = imageLayer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x + 80, fromPoint.y);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = 0.5f;
    imageLayer.position = toPoint;
    animation.removedOnCompletion = YES;
    [imageLayer addAnimation:animation forKey:@"position"];
}

- (IBAction)rotate:(id)sender {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = imageLayer.transform;
    CATransform3D toValue = CATransform3DRotate(fromValue, M_PI, 1, 0, 0);
    animation.fromValue = [NSValue valueWithCATransform3D:fromValue];
    animation.toValue = [NSValue valueWithCATransform3D:toValue];
    animation.duration = 1.0f;
    animation.removedOnCompletion = YES;
    imageLayer.transform = toValue;
    [imageLayer addAnimation:animation forKey:nil];
}

- (IBAction)scale:(id)sender {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:imageLayer.transform], [NSValue valueWithCATransform3D:CATransform3DScale(imageLayer.transform, 0.2, 0.2, 1)], [NSValue valueWithCATransform3D:CATransform3DScale(imageLayer.transform, 2, 2, 1)], [NSValue valueWithCATransform3D:CATransform3DScale(imageLayer.transform, 1, 1, 2)], [NSValue valueWithCATransform3D:CATransform3DScale(imageLayer.transform, 1, 1, 1)], nil];
    animation.duration = 2.0f;
    animation.removedOnCompletion = YES;
    [imageLayer addAnimation:animation forKey:@"transform"];
}

- (IBAction)group:(id)sender {
    CGPoint fromPoint = imageLayer.position;
    CGPoint toPoint = CGPointMake(280, fromPoint.y + 300);
    CABasicAnimation* moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    moveAnim.toValue = [NSValue valueWithCGPoint:toPoint];
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation* transformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = imageLayer.transform;
    CATransform3D scaleValue = CATransform3DScale(fromValue, 0.5, 0.5, 1);
    CATransform3D rotate = CATransform3DRotate(fromValue, M_PI, 0, 0, 1);
    transformAnim.fromValue = [NSValue valueWithCATransform3D:fromValue];
    CATransform3D toValue = CATransform3DConcat(scaleValue, rotate);
    transformAnim.toValue = [NSValue valueWithCATransform3D:toValue];
    transformAnim.cumulative = YES; // 动画效果叠加
    transformAnim.repeatCount = 2; // 动画反复执行两次, 则旋转 360 度
    transformAnim.duration = 3;
    
    CAAnimationGroup* animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, transformAnim, nil];
    animGroup.duration = 6;
    imageLayer.position = toPoint;
    imageLayer.transform = toValue;
    [imageLayer addAnimation:animGroup forKey:nil];
}

@end
