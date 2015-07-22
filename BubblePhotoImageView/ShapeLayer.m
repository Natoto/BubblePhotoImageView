//
//  ShapeLayer.m
//  BubblePhotoImageView
//
//  Created by 跑酷 on 15/7/20.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import "ShapeLayer.h"

@implementation UIView(Mask)

- (void)dwMakeBottomRoundCornerWithView:(UIView *)view
{
    
    CGRect frame = [self convertRect:view.frame fromView:self.superview];
    CGRect rect = CGRectIntersection(self.frame,frame);
    
    //    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor greenColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x+rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y+rect.size.height);
    
    CGPathCloseSubpath(path);
    
    [shapeLayer setPath:path];
    
    
    CFRelease(path);
    self.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
}

- (void)dwMakeBottomRoundCornerWithRadius:(CGFloat)radius
{
    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, size.width - radius, size.height);
    CGPathAddArc(path, NULL, size.width-radius, size.height-radius, radius, M_PI/2, 0.0, YES);
    CGPathAddLineToPoint(path, NULL, size.width, 0.0);
    CGPathAddLineToPoint(path, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(path, NULL, 0.0, size.height - radius);
    CGPathAddArc(path, NULL, radius, size.height - radius, radius, M_PI, M_PI/2, YES);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    self.layer.mask = shapeLayer;
    
    
    //layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
}

- (void)drawBubblestyle{
     
    CGRect rect = self.bounds;
    // Drawing code
    rect.origin = CGPointZero;
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height+1;//莫名其妙会出现绘制底部有残留 +1像素遮盖
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = 6;
    CGFloat margin = 8;//留出上下左右的边距
    
    CGFloat triangleSize = 8;//三角形的边长
    CGFloat triangleMarginTop = 8;//三角形距离圆角的距离
    
    CGFloat borderOffset = 3;//阴影偏移量
    UIColor *borderColor = [UIColor blackColor];//阴影的颜色
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGMutablePathRef path = CGPathCreateMutable();
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context,0,0,0,1);//画笔颜色
//    CGContextSetLineWidth(context, 1);//画笔宽度
    // 移动到初始点
//    CGPathMoveToPoint(path, NULL, size.width - radius, size.height);
//    CGPathAddArc(path, NULL, size.width-radius, size.height-radius, radius, M_PI/2, 0.0, YES);
    
    CGPathMoveToPoint(path,NULL, radius + margin, margin);
    // 绘制第1条线和第1个1/4圆弧
    CGPathAddLineToPoint(path, nil,  width - radius - margin, margin);
//    CGPathAddLineToPoint(path, nil, width - radius - margin, margin);
    CGPathAddArc(path, nil,  width - radius - margin,  radius + margin, radius, -0.5 * M_PI, 0.0, 0);
//    CGPathAddArc(path, nil, width - radius - margin, radius + margin, radius, -0.5 * M_PI, 0.0, 0);
    CGPathAddLineToPoint(path, nil, width, margin + radius);
//    CGPathAddLineToPoint(path, nil, width, margin + radius);
    CGPathAddLineToPoint(path,nil, width, 0);
    CGPathAddLineToPoint(path,nil, radius + margin,0);
    // 闭合路径
//    CGPathCloseSubpath(path);
    
    
    
//    CGContextClosePath(context);
//    // 绘制第2条线和第2个1/4圆弧
    
    CGPathMoveToPoint(path, nil, width - margin, margin + radius);
    CGPathMoveToPoint(path, nil, width, margin + radius);
    CGPathAddLineToPoint(path, nil, width, height - margin - radius);
    CGPathAddLineToPoint(path, nil, width - margin, height - margin - radius);
    
    float arcSize = 3;//角度的大小
    
//    if (self.bubbleMessageType == XHBubbleMessageTypeSending) {
        float arcStartY = margin + radius + triangleMarginTop + triangleSize - (triangleSize - arcSize / margin * triangleSize) / 2;//圆弧起始Y值
        float arcStartX = width - arcSize;//圆弧起始X值
        float centerOfCycleX = width - arcSize - pow(arcSize / margin * triangleSize / 2, 2) / arcSize;//圆心的X值
        float centerOfCycleY = margin + radius + triangleMarginTop + triangleSize / 2;//圆心的Y值
        float radiusOfCycle = hypotf(arcSize / margin * triangleSize / 2, pow(arcSize / margin * triangleSize / 2, 2) / arcSize);//半径
        float angelOfCycle = asinf(0.5 * (arcSize / margin * triangleSize) / radiusOfCycle) * 2;//角度
        //绘制右边三角形
        CGPathAddLineToPoint(path, nil, width - margin , margin + radius + triangleMarginTop + triangleSize);
        CGPathAddLineToPoint(path, nil, arcStartX , arcStartY);
        CGPathAddArc(path, nil, centerOfCycleX, centerOfCycleY, radiusOfCycle, angelOfCycle / 2, 0.0 - angelOfCycle / 2, 1);
        CGPathAddLineToPoint(path, nil, width - margin , margin + radius + triangleMarginTop);
//    }
    
    CGPathMoveToPoint(path, nil, width - margin, height - radius- margin);
//    CGPathMoveToPoint(path, nil, width - margin, height - radius - margin);
    CGPathAddArc(path, nil, width - radius - margin, height - radius - margin, radius, 0.0, 0.5 * M_PI, 0);
    CGPathAddLineToPoint(path,nil, width - margin - radius, height);
    CGPathAddLineToPoint(path,nil, width, height);
    CGPathAddLineToPoint(path,nil, width, height - radius - margin);
    
    
    // 绘制第3条线和第3个1/4圆弧
    CGPathMoveToPoint(path,nil, width - margin - radius, height - margin);
    CGPathAddLineToPoint(path, nil, width - margin - radius, height);
    CGPathAddLineToPoint(path, nil, margin, height);
    CGPathAddLineToPoint(path, nil, margin, height - margin);
    
    
    CGPathMoveToPoint(path, nil, margin, height-margin);
    CGPathAddArc(path, nil, radius + margin, height - radius - margin, radius, 0.5 * M_PI, M_PI, 0);
    CGPathAddLineToPoint(path, nil, 0, height - margin - radius);
    CGPathAddLineToPoint(path, nil, 0, height);
    CGPathAddLineToPoint(path, nil, margin, height);
    
    
    // 绘制第4条线和第4个1/4圆弧
    CGPathMoveToPoint(path, nil, margin, height - margin - radius);
    CGPathAddLineToPoint(path, nil, 0, height - margin - radius);
    CGPathAddLineToPoint(path, nil, 0, radius + margin);
    CGPathAddLineToPoint(path, nil, margin, radius + margin);
    
//    if (!self.bubbleMessageType == XHBubbleMessageTypeSending) {
//        float arcStartY = margin + radius + triangleMarginTop + (triangleSize - arcSize / margin * triangleSize) / 2;//圆弧起始Y值
//        float arcStartX = arcSize;//圆弧起始X值
//        float centerOfCycleX = arcSize + pow(arcSize / margin * triangleSize / 2, 2) / arcSize;//圆心的X值
//        float centerOfCycleY = margin + radius + triangleMarginTop + triangleSize / 2;//圆心的Y值
//        float radiusOfCycle = hypotf(arcSize / margin * triangleSize / 2, pow(arcSize / margin * triangleSize / 2, 2) / arcSize);//半径
//        float angelOfCycle = asinf(0.5 * (arcSize / margin * triangleSize) / radiusOfCycle) * 2;//角度
//        //绘制左边三角形
//        CGPathAddLineToPoint(path, nil, margin , margin + radius + triangleMarginTop);
//        CGPathAddLineToPoint(path, nil, arcStartX , arcStartY);
//        CGPathAddArc(path, nil, centerOfCycleX, centerOfCycleY, radiusOfCycle, M_PI + angelOfCycle / 2, M_PI - angelOfCycle / 2, 1);
//        CGPathAddLineToPoint(path, nil, margin , margin + radius + triangleMarginTop + triangleSize);
//    }
    CGPathMoveToPoint(path, nil, margin, radius + margin);
    CGPathAddArc(path, nil, radius + margin, margin + radius, radius, M_PI, 1.5 * M_PI, 0);
    CGPathAddLineToPoint(path, nil, margin + radius, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, 0, radius + margin);
    
    CGPathCloseSubpath(path);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor orangeColor] CGColor]];

    [shapeLayer setPath:path];
    
    CFRelease(path);
    self.layer.mask = shapeLayer;
    

}
//
//- (id)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame])
//    {
//        [self dwMakeBottomRoundCornerWithRadius:3.0];
//    }
//    return self;
//}
@end
