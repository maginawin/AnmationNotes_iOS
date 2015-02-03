//
//  CALayerViewController.m
//  AnimationNotes
//
//  Created by maginawin on 15-2-3.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "CALayerViewController.h"

@interface CALayerViewController ()

@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // 为 UIView 设置圆角边框
    // 设置该视图控制器所显示的 View 上的 CALayer 的边框宽度
    self.view.layer.cornerRadius = 8;
    // 边框宽度
    self.view.layer.borderWidth = 4;
    // 边框颜色
    self.view.layer.borderColor = [UIColor redColor].CGColor;
    
    // 创建简单的 CALayer
    CALayer* subLayer = [CALayer layer];
    subLayer.backgroundColor = [UIColor magentaColor].CGColor;
    subLayer.cornerRadius = 8;
    subLayer.borderWidth = 2;
    subLayer.borderColor = [UIColor blackColor].CGColor;
    // 设置 subLayer 的阴影, 此处向右下角偏移
    subLayer.shadowOffset = CGSizeMake(4, 5);
    // 设置 subLayer 的阴影模糊程度 (值越大, 越模糊)
    subLayer.shadowRadius = 1;
    subLayer.shadowColor = [UIColor blackColor].CGColor;
    subLayer.shadowOpacity = 0.8; // 设置透明度
    subLayer.frame = CGRectMake(30, 80, 120, 160);
    [self.view.layer addSublayer:subLayer];
    
    CALayer* subLayer2 = [CALayer layer];
    subLayer2.cornerRadius = 8;
    subLayer2.borderWidth = 2;
    subLayer2.borderColor = [UIColor blackColor].CGColor;
    subLayer2.shadowOffset = CGSizeMake(4, 5);
    subLayer2.shadowRadius = 1;
    subLayer2.shadowColor = [UIColor magentaColor].CGColor;
    subLayer2.shadowOpacity = 0.8;
    subLayer2.masksToBounds = YES; // 剪切子 Layer
    subLayer2.frame = CGRectMake(170, 80, 120, 160);
    [self.view.layer addSublayer:subLayer2];
    
    // 使用 CALayer 显示图片
    CALayer* imgLayer = [CALayer layer];
    imgLayer.contents = (id)[UIImage imageNamed:@"mainball"].CGImage;
    imgLayer.frame = subLayer2.bounds;
    [subLayer2 addSublayer:imgLayer];
    
    // 自定义 CALayer 的绘制内容
    CALayer* customLayer = [CALayer layer];
    // 设置委托对象, 该委托对象负责该 CALayer 的绘制
    customLayer.delegate = self;
    customLayer.frame = CGRectMake(30, 250, 260, 160);
    customLayer.shadowOffset = CGSizeMake(0, 3);
    customLayer.shadowRadius = 5.0;
    customLayer.shadowColor = [UIColor blackColor].CGColor;
    customLayer.shadowOpacity = 0.8;
    customLayer.cornerRadius = 10.0;
    customLayer.borderColor = [UIColor blackColor].CGColor;
    customLayer.borderWidth = 2.0;
    customLayer.masksToBounds = YES;
    [self.view.layer addSublayer:customLayer];
    
    // 必须用这行通知调用 delegate 的 drawLayer method
    [customLayer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainball"]];
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    
    CGContextFillEllipseInRect(ctx, CGRectMake(20, 20, 100, 100)); // 填充一个椭圆
    CGContextAddRect(ctx, CGRectMake(160, 20, 100, 60));
    CGContextFillPath(ctx);
    CGContextSetRGBFillColor(ctx, 0.5, 1, 1, 1);
    CGContextFillPath(ctx);
}

@end
