//
//  ViewController.m
//  BubblePhotoImageView
//
//  Created by 跑酷 on 15/7/20.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import "ViewController.h"
#import "XHBubblePhotoImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShapeLayer.h"
#import "UIImage+HBExtension.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bubblePhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleimg;

@end

@implementation ViewController

#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

- (void)viewDidLoad {
    [super viewDidLoad];
      
//    [self.imageView dwMakeBottomRoundCornerWithRadius:3.0]; 
    UIImage * img = [UIImage imageNamed:@"chat_sender_bg.png"];
   
    CGFloat LEFT = 25;
    CGFloat TOP = 18.5;
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(TOP, LEFT, TOP, LEFT);
    CGRect maskframe =  self.bubblePhotoImageView.bounds;
    UIImage * image3 =  [self getMaskImageWithBubbleImage:img EdgeInsets:edgeInset maskframe:maskframe];//[self merge:image1 anotherImage:image2];
    UIImage *tintedImage =  image3; //[self redrawImage:img size:maskframe.size];
    CALayer* maskLayer = [CALayer layer] ;
    maskLayer.frame = maskframe;;
    maskLayer.contents = (id)[tintedImage CGImage];
    [self.bubblePhotoImageView.layer setMask:maskLayer];
    [self.imageView.layer setMask:maskLayer];
    self.bubbleimg.image = tintedImage;
}
/**
 *  得到mask的图像
 *
 *  @param BubbleImage 气泡原始图
 *  @param edge        拉伸角度
 *  @param maskframe   蒙版大小
 *
 *  @return 返回蒙版图像
 */
-(UIImage *)getMaskImageWithBubbleImage:(UIImage *)BubbleImage  EdgeInsets:(UIEdgeInsets)edgeInsets maskframe:(CGRect)maskframe
{
    BubbleImage = [BubbleImage stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];// : [BubbleImage resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])
    
    UIGraphicsBeginImageContextWithOptions(maskframe.size, NO, 0);
    [BubbleImage drawInRect:CGRectMake(0, 0, maskframe.size.width, maskframe.size.height)];
    CGRect rect = CGRectMake(edgeInsets.left, 0, maskframe.size.width - 2 * edgeInsets.left, maskframe.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIImage * image3 = img ;
    return image3;
}



-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)redrawImage:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

-(UIImage *)getpureImage:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}


-(UIImage *)mergetImage:(UIImage *)image  size:(CGSize)size
{
    CGFloat LEFT = 25;
    CGFloat TOP = 18.5;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    //    UIGraphicsBeginImageContextWithOptions( size, NO, 0 );
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, image.CGImage);
    
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGRect  rect2 = CGRectMake(LEFT, 0, size.width - 2*LEFT, size.height);
    CGContextFillRect(context, rect2);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}


- (UIImage *)merge:(UIImage *)image1 anotherImage:(UIImage *)image2
{
    CGSize canvasSize;
    canvasSize.width = image1.size.width;
    canvasSize.height = image1.size.height;
    CGFloat LEFT = 25;
    CGFloat TOP = 18.5;
    
    //	UIGraphicsBeginImageContext( canvasSize );
    UIGraphicsBeginImageContextWithOptions( canvasSize, NO, 1);
    
    CGPoint offset1 = CGPointZero;
    //    offset1.x = (canvasSize.width - canvasSize.size.width) / 2.0f;
    //    offset1.y = (canvasSize.height - canvasSize.size.height) / 2.0f;
    
    CGPoint offset2 = CGPointMake(LEFT, 0) ;
    offset2.x = (canvasSize.width - image2.size.width) / 2.0f;
    offset2.y = (canvasSize.height - image2.size.height) / 2.0f;
    
    [image1 drawAtPoint:offset1 blendMode:kCGBlendModeNormal alpha:1.0f];
    [image2 drawAtPoint:offset2 blendMode:kCGBlendModeNormal alpha:1.0f];
    
    UIImage * result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}
@end
